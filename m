From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH 0/4] completion fixes: Acks, whitespace, and r=""
Date: Fri, 20 Feb 2009 12:01:18 -0500
Message-ID: <499EE1DE.2000309@tedpavlic.com>
References: <7v63jgg7st.fsf@gitster.siamese.dyndns.org> <1234378479-29304-1-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	gitster <gitster@pobox.com>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 18:03:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaYmB-0002LC-Ni
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 18:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbZBTRBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 12:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbZBTRBa
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 12:01:30 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:48370 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753892AbZBTRBa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 12:01:30 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 189E180D802E;
	Fri, 20 Feb 2009 11:54:44 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dH99Pju2xPeg; Fri, 20 Feb 2009 11:54:44 -0500 (EST)
Received: from TedBook.local (rrcs-24-123-153-141.central.biz.rr.com [24.123.153.141])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id B302180D8015;
	Fri, 20 Feb 2009 11:54:43 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <1234378479-29304-1-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110865>

In my latest "git pull," I noticed a few completion changes, but none of 
these changes were included (and thus on some of my machines, I get 
unbound variable errors again).

Were these changes finally rejected?

Thanks --
Ted

On 2/11/09 1:54 PM, Ted Pavlic wrote:
> * Added Shawn O. Pearce acks
> * Fixed whitespace problem in second patch (vim:expandtabs was on)
> * When in GIT_DIR, set r="" in __git_ps1 as well
>
> Ted Pavlic (4):
>    completion: For consistency, changed "git rev-parse" to __gitdir
>      calls.
>    completion: Use consistent if [...] convention. No test.
>    completion: Better __git_ps1 support when not in working directory
>    completion: More fixes to prevent unbound variable errors.

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
