From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 06:51:35 +0100
Message-ID: <5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de>
References: <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <20071129150849.GA32296@coredump.intra.peff.net> <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com> <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 06:53:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixyou-0008Pi-TM
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 06:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbXK3Fx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 00:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbXK3Fx1
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 00:53:27 -0500
Received: from mailer.zib.de ([130.73.108.11]:37857 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbXK3Fx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 00:53:26 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAU5oPd3019253;
	Fri, 30 Nov 2007 06:50:25 +0100 (CET)
Received: from [192.168.178.21] (brln-4db83fde.pool.einsundeins.de [77.184.63.222])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAU5oOvi020231
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 30 Nov 2007 06:50:24 +0100 (MET)
In-Reply-To: <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66615>


On Nov 30, 2007, at 3:29 AM, Linus Torvalds wrote:

> So I just think that the whole idiotic complaint that some people have
> (that whole "git-<tab><tab>" shows "Display all 144 possibilities?"  
> and
> people are somehow using that as an argument that git is "complex")  
> should
> be something we strive to undo. I think the complaint is insane  
> (because
> the answer is "well, nobody forces you to _use_ all the power and  
> scripts
> we give you!"), but still, it's a complaint, so let's just assume  
> the user
> is right, and try to fix it.
>
> So when you do "git-<tab><tab>" it should just beep at you and not  
> show
> anything at all by default. And when you do "git <tab><tab>", we  
> should
> make sure that the bash expansion (or zsh or whatever) shows a nice
> collection of common plumbing, not soemthing really scary.


What will happen to gitk?

Shouldn't it be included in the nice collection?  gitk is
an essential command.  Then, following your reasoning,
"git <tab><tab>" should recommend it, no?

Note, "git gui" already works.  gitk would really be the last
git "command" that can't be accessed through "git <command>"

	Steffen
