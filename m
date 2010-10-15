From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: Can I checkout a single file without altering index?
Date: Fri, 15 Oct 2010 13:57:46 -0500
Message-ID: <i9a88i$k3g$1@dough.gmane.org>
References: <loom.20101012T114900-532@post.gmane.org> <AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com> <loom.20101014T095743-275@post.gmane.org> <i9a6kn$d7o$1@dough.gmane.org> <20101015184302.GA22990@burratino>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 15 20:58:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6pUV-0007jw-UR
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 20:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311Ab0JOS6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 14:58:38 -0400
Received: from lo.gmane.org ([80.91.229.12]:48689 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932217Ab0JOS6h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 14:58:37 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P6pUB-0007Zm-2w
	for git@vger.kernel.org; Fri, 15 Oct 2010 20:58:35 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 20:58:35 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 20:58:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159131>

"Jonathan Nieder" <jrnieder@gmail.com> wrote in message 
news:20101015184302.GA22990@burratino...
> Hi Neal,
>
> Neal Kreitzinger wrote:
>
>> However, there is an option in git-commit to copy files directly from the
>> working-tree to the object-store by totally bypassing the index
>
> What option is this?  I thought "git commit --include" added content
> to the index.

>From the git-commit manpage (1.7.1.2):

"3.  by listing files as arguments to the commit command, in which case the 
commit will ignore changes staged in the index, and instead record the 
current content of the listed files (which must already be known to git); "

(I haven't tried it myself because to me the index is a key technology of 
git so I'm not sure why I would want to bypass it.)

v/r,
Neal 
