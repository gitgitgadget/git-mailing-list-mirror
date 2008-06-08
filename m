From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 3/5] Create a git.Branch class as ancestor of stack.Stack
Date: Sun, 8 Jun 2008 23:16:02 +0100
Message-ID: <b0943d9e0806081516y575faba9g8b5a27646615f72f@mail.gmail.com>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
	 <20080604211334.32531.74258.stgit@localhost.localdomain>
	 <20080605070126.GC23209@diana.vm.bytemark.co.uk>
	 <b0943d9e0806050503x40191104ye332d6a8435811a5@mail.gmail.com>
	 <20080605130415.GB28995@diana.vm.bytemark.co.uk>
	 <b0943d9e0806060144x48176566m277ba2969087b91e@mail.gmail.com>
	 <20080607090636.GB32647@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 00:17:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5TC7-0000hM-Uc
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 00:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584AbYFHWQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 18:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756489AbYFHWQF
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 18:16:05 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:38457 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbYFHWQD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jun 2008 18:16:03 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1576585waf.23
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XXgEI5U2Nln3mxFtRaD6uP3gjYB/T0kHWf8oD6wIsqI=;
        b=p5tPaSgrAkXwaMYnkuV4ubhCk8dZVaPDtCGOEZaTlVvk+wpBLHfrZMgQSi3RJJyRev
         rzNbrIi/cRTaXlKBsezl3rSFGPuOSJ7/bz2GF9HbRfQA5sYujUYbL+Rbz/gBo52OWj92
         fxwNpm3ND34j/pmNhJp1L5QB+Lq+6qfncLS84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IdEaWooJTc5S7OEWNdKkyUidBdR2stbCkmu2nMB6vCFu9AEslu4FW9G7iwVbE4kLyG
         YPiZR+9u6gBGjHuj+vgyZibVPtQkUpoVaYbp69j0Jii3axxavP13gmaE1vFAvve2vXUf
         koprZiO/f/r90+YFdq9U2rYhh77TUmByqiAfM=
Received: by 10.114.12.9 with SMTP id 9mr2556158wal.121.1212963362446;
        Sun, 08 Jun 2008 15:16:02 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Sun, 8 Jun 2008 15:16:02 -0700 (PDT)
In-Reply-To: <20080607090636.GB32647@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84334>

On 07/06/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-06-06 09:44:37 +0100, Catalin Marinas wrote:
>  > 2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
> > > We'll have to be watchful against attempts to create objects othe=
r
> > > than via the officially designated factories, though. Python
> > > doesn't really have any mechanisms that help us here.
> >
> > If you really want enforcing this, it can probably be done by
> > hacking __new__ and __init__.
>
> No, I reckon you're right -- it's overkill. StGit is small enough tha=
t
>  we can probably enforce the relevant restrictions by hand.

Hidden plan - once the new stgit.lib.git module is complete, we can
advertise it as a stand-alone object-oriented Git wrapper for Python
:-). At that point, we can think about enforcing the factory
mechanism.

--=20
Catalin
