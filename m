From: "Tjernlund" <tjernlund@tjernlund.se>
Subject: RE: gitweb improvements
Date: Tue, 7 Oct 2008 00:17:00 +0200
Message-ID: <013b01c92801$40f5f8f0$c2e1ead0$@se>
References: <00a201c92701$54ec6980$fec53c80$@se> <m34p3rq7og.fsf@localhost.localdomain> <00b201c92739$36585eb0$a3091c10$@se> <200810060154.06934.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: "'Jakub Narebski'" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 00:19:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmyPn-0002U9-2o
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 00:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbYJFWRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 18:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbYJFWRo
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 18:17:44 -0400
Received: from csmtp2.b-one.net ([195.47.247.206]:42097 "EHLO csmtp2.b-one.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbYJFWRn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 18:17:43 -0400
Received: from jockexp (84-217-5-146.tn.glocalnet.net [84.217.5.146])
	by csmtp2.b-one.net (Postfix) with ESMTP id E7A88160005D4;
	Tue,  7 Oct 2008 00:17:41 +0200 (CEST)
In-Reply-To: <200810060154.06934.jnareb@gmail.com>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcknRafonoKHaJ0eRpy2e4yfw9LUGQAup+wQ
Content-Language: sv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97638>

> -----Original Message-----
> From: Jakub Narebski [mailto:jnareb@gmail.com]
> Sent: den 6 oktober 2008 01:54
> To: Tjernlund
> Cc: 'git'
> Subject: Re: gitweb improvements
> 
> On Mon, 6 Oct 2008, Tjernlund wrote:
> > Jakub Narebski wrote:
> >> "Tjernlund" <tjernlund@tjernlund.se> writes:
> 
> >>> 2) looking at a merge like:
> >>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
> 2.6.git;a=commit;h=66120005e65eed8a05b14a36ab448bdec42f0d6b
> >>>    is somewhat confusing. It really doesn't tell you which commits that is
> >>>    included in the merge.
> >>
> >> I don't understand you there. First, you have "(merge: 0d0f3ef 9778e9a)"
> >> in the navbar, so you can easily go to commit view for parents. Second,
> >> among commit headers you have two "parent", where SHA-1 of a commit is
> >> hidden link, and there are also 'commit' and 'diff' link for those.
> >
> > hmm, looks like I overlooked "(merge: 0d0f3ef 9778e9a)" part. However, I can't
> > find the "ALSA: make the CS4270 driver a new-style I2C driver" from within
> > this page.
> 
> I think you don't quite understand the situation. The history looks
> like this:
> 
>     M      Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
>     |\
>     | 2    ALSA: ASoC: Fix another cs4270 error path
>     | *    ALSA: make the CS4270 driver a new-style I2C driver
>     | |
>     1 |    Merge git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6
> 
> Parents of commit 'M' (for merge) are '1' and '2', not 2,* or 1,2,*.
> 
> Now the fact that commit message for merge contains shortlog of merged
> branch does not mean that there must be direct link to such shortlog.
> You can go to shortlog (well, kind of) if you click on second parent,
> _then_ click on shortlog link at top of the page.

You are quite right, I didn't quite follow the situation. I do however have one
observation, would it be possible to list the commits in a merge the same way
you list commits on the top level, that is, more or less make the headings
 "ALSA: ASoC: Fix another cs4270 error path"
 "ALSA: make the CS4270 driver a new-style I2C driver"
links one can follow?

 Jocke
