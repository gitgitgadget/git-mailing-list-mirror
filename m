From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked branch
Date: Sat, 21 Mar 2009 00:45:03 +0100
Message-ID: <fabb9a1e0903201645n29256fbav7fc0bde4c5cc05e7@mail.gmail.com>
References: <200903181448.50706.agruen@suse.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> 
	<20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org> 
	<alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de> 
	<7v7i2ki0sw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.2.00.0903202300330.13726@reaper.quantumfyre.co.uk> 
	<fabb9a1e0903201620l456bfc39n2422dcb1e738eb37@mail.gmail.com> 
	<alpine.LNX.2.00.0903202324170.13726@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Mar 21 00:46:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkoQM-00052x-1T
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 00:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbZCTXpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 19:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbZCTXpX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 19:45:23 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:34526 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbZCTXpV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 19:45:21 -0400
Received: by fxm2 with SMTP id 2so1099359fxm.37
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 16:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MS3+JzZK0JZJowpa1R14xaKwOUDb43mhkXeb+gkUhDo=;
        b=t1XJUwbcfMxu17mHZCygFnA4J5oxwKdwIGA9edzcNuhha8DJkIqjQkAi667SIKU5W4
         KIn3k2h7BrZcgyR1EOFguJQJeCilk/FNoxDQiHka6OzHrNhuidTSsL1b+4jiAWfmHd3A
         4JdiflWsAIxB3jo+S+VMTMzjB4uQ+pA/3P37I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dL97q9doIAUnNUVtoXAKT/uSGM74hQpomGI79n4H/vk5ut6MVoZCFVT1NZD+9eLe9e
         T5c4dCdCARz+ksJUH60SIKkoF+48SuIvA5Htiql+Gohanh9CAJZZ/eIWiSZmdYsA4nnI
         zp9eWOqBUWyJ0slywZy/SBfEPQ7HS8q/C0zRg=
In-Reply-To: <alpine.LNX.2.00.0903202324170.13726@reaper.quantumfyre.co.uk>
Received: by 10.103.102.17 with SMTP id e17mr1950482mum.119.1237592718334; 
	Fri, 20 Mar 2009 16:45:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114018>

Heya,

On Sat, Mar 21, 2009 at 00:41, Julian Phillips <julian@quantumfyre.co.u=
k> wrote:
> To use the new syntax you type %master only. =A0What I was proposing =
was a way
> to get at the branch that you had before the wizzy new feature was ad=
ded.
> =A0Something you only do once to rename it - why waste an easy to typ=
e
> sequence on that?

Oooooh, sorry, I totally understood your suggestion the wrong way
around! In that case, I like it! :)

> I agree that adding some more reserved characters is a reasonable way
> forward - but I think a way should be provided for people who are _al=
ready_
> using those characters to rename their branches to something that avo=
ids
> those characters in a simple (but not necessarily easy to type) way.

Your suggestion on how to escape the DWIMery sounds sane to me :).

--=20
Cheers,

Sverre Rabbelier
