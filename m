From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] diff --check: use colour
Date: Fri, 26 Jan 2007 18:41:19 +0100
Organization: At home
Message-ID: <epdedp$s0o$1@sea.gmane.org>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17850.8953.478146.754550@lisa.zopyra.com> <200701261637.01199.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 18:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAV3r-000588-1j
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 18:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbXAZRkX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 12:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbXAZRkX
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 12:40:23 -0500
Received: from main.gmane.org ([80.91.229.2]:39302 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161055AbXAZRkV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 12:40:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HAV3f-0003U0-CW
	for git@vger.kernel.org; Fri, 26 Jan 2007 18:40:15 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 18:40:15 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 18:40:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37877>

Andy Parkins wrote:

> On Friday 2007 January 26 15:49, Bill Lear wrote:
> 
>> I presume that I send the patch text to the list with the subject line
>> that starts with [PATCH], some sensible topic (e.g., "document --check
>> option to diff"), and then a short body of explanation and then,
>> following my signature, the patch itself.
> 
> git-format-patch will make you an email of the correct form.  Personally I do 
> this (this is the IMAP server version, but it's similar for mbox)

You can use git-send-email to send emails via SMTP. I have configured
sendmail to send emails via gmail

-dnl define(`SMART_HOST',`smtp.your.provider')
+define(`SMART_HOST',`[smtp.gmail.com]')
 
>  * make myself a branch from current master
>  * write patch/patches, test (yeah, right ;-))

The same for me (with the exception that I branch from origin).
If writing patches takes longer time, and upstream has
advanced in meantime, I also rebase before sending patches.

   * rebase branch using "git rebase master <branch>"

>  * git-format-patch --stdout HEAD^ to check it looks good
>  * git-format-patch --stdout HEAD^ | git-imap-send 
>  * Go to Drafts mailbox, open it up, add any additional comments for the
>    mailing list only underneath the "---" and before the diffstat.  Make sure
>    you turn word wrap off as soon as you open the mail.  Word wrapping will
>    ruin the patch.

For me it is "git format-patch HEAD^.." if it is one patch (one commit)
only, "git format-patch -o mdir.<n> origin.." if this is series of patches.
Then edit the patches (the 0001-*.txt file), adding any additional
comments for the mailing list only underneath the "---" and before
the diffstat.

>  * Send.

Use "git send-email <patch>" or "git send-email mdir.<n>" to send patches.

>  * Wait for huge feeling of disappointment because your patch is junk and
>    gets savaged by the git-gurus (maybe this step is just for me though).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
