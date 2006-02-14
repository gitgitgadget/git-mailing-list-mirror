From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Tue, 14 Feb 2006 09:26:41 +0000
Message-ID: <tnxoe1aqoj2.fsf@arm.com>
References: <20060210195914.GA1350@spearce.org>
	<20060210211740.GO31278@pasky.or.cz>
	<20060213210001.GA31278@pasky.or.cz>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 10:27:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8wSi-0002r3-Tk
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 10:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbWBNJ07 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 04:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbWBNJ07
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 04:26:59 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:4011 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1030524AbWBNJ06 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 04:26:58 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k1E9Qk6s006146;
	Tue, 14 Feb 2006 09:26:46 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Tue, 14 Feb 2006 09:26:46 +0000
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060213210001.GA31278@pasky.or.cz> (Petr Baudis's message of
 "Mon, 13 Feb 2006 22:00:01 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 14 Feb 2006 09:26:46.0279 (UTC) FILETIME=[C668A170:01C63148]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16132>

Petr Baudis <pasky@suse.cz> wrote:
>   Some common gripes for both StGIT and pg (well, I'm using some
> ridiculously old StGIT version, so this may not apply anymore there):
>
> 	* stg new --force - seriously, what's the point?! I always to
> 	the change first and when it's any good, I want to create a
> 	patch for it.

This was fixed couple of weeks ago in the main branch. No need to pass
--force anymore.

> 	* I can't just get the patch in its "canonical ready-to-mail
> 	form" on stdout so that I could easily review it. Why is
> 	pg-export insisting to dump it to a file?

To view the patch you can use 'stg diff -r <patch>/' but it doesn't
show the description. Dumping the full patch on stdout would be
useful, indeed. The export and mail commands use different templates
and the latter even adds the standard mail headers. Which of these two
commands would you prefer to dump the patch on stdout (both is fine as
well)?

Another thing that's missing in StGIT is the import of a series of
patches. At the moment I run a small shell script to import individual
patches.

-- 
Catalin
