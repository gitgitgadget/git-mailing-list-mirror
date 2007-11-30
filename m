From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 16:28:21 +0100
Message-ID: <8aa486160711300728x70f591f1hf8884a78f2b15806@mail.gmail.com>
References: <20071129211409.GA16625@sigill.intra.peff.net>
	 <20071129231444.GA9616@coredump.intra.peff.net>
	 <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
	 <7veje8twt2.fsf@gitster.siamese.dyndns.org>
	 <20071130003512.GB11683@coredump.intra.peff.net>
	 <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org>
	 <20071130005852.GA12224@coredump.intra.peff.net>
	 <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org>
	 <5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de>
	 <20071130151223.GB22095@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Jan Hudec" <bulb@ucw.cz>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 16:28:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy7nJ-0000nE-Am
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 16:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761868AbXK3P2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 10:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761920AbXK3P2X
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 10:28:23 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:35855 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761073AbXK3P2W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 10:28:22 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1991378wra
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 07:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tV/IN3GYkRYjgmsi9L5WLLk3dRJsuD+lRBOavU9W9K4=;
        b=dIZdNxRossgvVOXOT78N7ljVQhcbVy186r2R33/enjXPIrwRprsyWqfItolJbeygC24U2Orls0dkycZxzsI2zcxzoKnwOc+dTOwaadHNcu6/V2/Tnj3Cwr6TZNJmNiCY6uUGJqgrQ1eCUCoINQDLI9vJoLOjoE826xoPxCKbG7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gysSBtDWIDgCWaabepIqankkCX3CjUtUguafucPigO/a4hxL00Fzfg+iJgICtBTEyQg4oc6Dzg+/ubUgB1dFAgW4mUL99+nNIQa05uCrvuG8ZdxYnYiaVfpzH9WaqW9PinnWikt8IOLInpIuSu5UOzo7fVzIBfW4RksMPtB5QJg=
Received: by 10.150.153.19 with SMTP id a19mr572161ybe.1196436501805;
        Fri, 30 Nov 2007 07:28:21 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Fri, 30 Nov 2007 07:28:21 -0800 (PST)
In-Reply-To: <20071130151223.GB22095@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66645>

On Nov 30, 2007 4:12 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 30, 2007 at 06:51:35AM +0100, Steffen Prohaska wrote:
>
> > What will happen to gitk?
> >
> > Shouldn't it be included in the nice collection?  gitk is
> > an essential command.  Then, following your reasoning,
> > "git <tab><tab>" should recommend it, no?
> >
> > Note, "git gui" already works.  gitk would really be the last
> > git "command" that can't be accessed through "git <command>"
>
> Except for qgit, tig, etc. The only difference being that gitk actually
> ships with git.
>
> But I am not opposed to having some "git foo" form for gitk.

In mercurial "hg view" is actually an old version of gitk modified for hg.

And as "git view" it could be added to the "git help" list.

Santi
