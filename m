From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: gitk show only all refs matching pattern
Date: Sat, 03 Dec 2011 09:11:01 +0100
Message-ID: <4ED9D995.4070204@kdbg.org>
References: <jbbouj$p2$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sat Dec 03 09:18:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWko3-0007Wt-OA
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 09:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab1LCILI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Dec 2011 03:11:08 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:15939 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752000Ab1LCILG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2011 03:11:06 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1CE99CDF87;
	Sat,  3 Dec 2011 09:11:32 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4FD0B19F34C;
	Sat,  3 Dec 2011 09:11:01 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <jbbouj$p2$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186252>

Am 03.12.2011 01:02, schrieb Neal Kreitzinger:
> Is there a way to tell gitk to show only all refs matching a pattern (e.g., 
> all refs matching refs/heads/neal/*)?  (I'm using git 1.7.1)

That would be

   gitk --branches=neal/*

There is also --remotes= which I find quite useful.

-- Hannes
