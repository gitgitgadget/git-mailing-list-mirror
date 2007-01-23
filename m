From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Tue, 23 Jan 2007 22:09:24 +0100
Message-ID: <slrnercuc4.55u.siprbaum@xp.machine.xx>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <eovccc$usc$1@sea.gmane.org> <Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17846.20498.635623.173653@lisa.zopyra.com> <Pine.LNX.4.63.0701232012120.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17846.27694.845530.663964@lisa.zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jan 23 22:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9TIO-0002S1-Q9
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 22:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965487AbXAWVfH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 16:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965488AbXAWVfG
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 16:35:06 -0500
Received: from main.gmane.org ([80.91.229.2]:36835 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965487AbXAWVfE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 16:35:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H9TIE-0005qQ-GJ
	for git@vger.kernel.org; Tue, 23 Jan 2007 22:35:02 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 22:35:02 +0100
Received: from siprbaum by mason.hofmann.stw.uni-erlangen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 22:35:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37572>

Bill Lear <rael@zopyra.com> schrieb:
> On Tuesday, January 23, 2007 at 20:12:36 (+0100) Johannes Schindelin writes:
>>Hi,
>>
>>On Tue, 23 Jan 2007, Bill Lear wrote:
>>
>>> I can't seem to get this to work, no matter what I do, using the latest 
>>> 1.5.0-rc2 code.  I have the environment variables LESS, PAGER, 
>>> PAGER_FLAGS, and I can't seem to get 'git diff' to not plough through my 
>>> screen each time it is run, no matter the combinations...  Could someone 
>>> post the magic?
>>
>>Try this:
>>
>>	PAGER=less LESS=-FRS git diff
>
> Replied to Johannes off-line and thought this was working --- sorry
> for the false positive.  It is in one regard: it completely suppresses
> output if there is less than a full screen of output.
>
> If I do this:
>
> % export PAGER=less
> % unset LESS
> % git diff
>
> I get 30 lines of output in my current repository, as I should.
>
> If I then do this:
>
> % LESS=-FRS git diff
>
> I get nothing --- I do see a brief blink of output, but it's as if
> less swallows it whole and I see nothing but the next prompt.
>

This is propably caused by activating "Enable Alternate Screen Switching"
in xterm. If you have this feature enabled, you get a clean screen (no
fragments of the displayed file are shown after quitting less). Try to
disable it and see if it works.

-Peter
