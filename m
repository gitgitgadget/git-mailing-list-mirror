From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 11:48:56 +0100
Message-ID: <20110427104856.GB7186@jakstys.lt>
References: <BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
 <7vsjt49stq.fsf@alter.siamese.dyndns.org>
 <BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
 <7vk4eg9rsf.fsf@alter.siamese.dyndns.org>
 <BANLkTi=UafJRc76ePmVXo2gF+CNVnEL41Q@mail.gmail.com>
 <4DB7CC7C.2050508@drmicha.warpmail.net>
 <BANLkTinrU8LhA0RORde0e5a1TM5VB5gVNQ@mail.gmail.com>
 <BANLkTik8+ECdRsq19xUi1HzTnKoayvLOSw@mail.gmail.com>
 <20110427093627.GH2709@jakstys.lt>
 <BANLkTi=UCGkQaOF7c0Ks6315gygacMzfyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 12:49:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF2Iu-0006RL-4J
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 12:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567Ab1D0KtB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 06:49:01 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35120 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756506Ab1D0KtA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 06:49:00 -0400
Received: by wwa36 with SMTP id 36so1738762wwa.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 03:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=js6p90bORSaX1foxdkjFAinVlOwtCtk0o5jCpsnduwc=;
        b=Hg2/kYyT1w/JuNniiuINxf6P5vQuaN3qO7Y22TtKAm7GEj622YuJlQKsEme2MOgp05
         KyCb+g6UHM+yJ9EvNleG2Jg/PJYpaW4i50CG9NYGLxTUxUab4jgY0a/2U0E8xMgMsiDi
         bs7bkwD4u9RJ9tJeks2oTEXhxmyVO+TC3JwnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=f2kqHgaPOhPl7qx4wmIYlPu8zXjRUmVGcr5HenYnDY6BMOGscB9QxgmyII5eDGK7Ji
         eAOL4z4ydYvXuMB4yJ2oqqmKA4onU2IgiMRdrnFr4jXYWFJMehdxcx2Dfo448hHXL79C
         yrhA2C/6QYY4m/P8s5jDdzA5+Io87/pCQc3bg=
Received: by 10.227.93.36 with SMTP id t36mr2109313wbm.11.1303901339028;
        Wed, 27 Apr 2011 03:48:59 -0700 (PDT)
Received: from localhost ([109.246.247.245])
        by mx.google.com with ESMTPS id l24sm377304wbc.13.2011.04.27.03.48.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 03:48:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=UCGkQaOF7c0Ks6315gygacMzfyQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172217>

On Wed, Apr 27, 2011 at 07:59:33PM +1000, Jon Seymour wrote:
> 2011/4/27 Motiejus Jak=C5=A1tys <desired.mta@gmail.com>:
> > On Wed, Apr 27, 2011 at 06:40:07PM +1000, Jon Seymour wrote:
> > Although this looks very nice from user point of view, it would be =
a
> > pain for the extension maintainer... Though it's only one C file.
> >
>=20
> I don't see why. You wouldn't be forced to maintain one of those
> packages, anymore than you are now. If you can, you just publish a gi=
t
> url, and your job is done.  If your tool requires compilation, you
> have already solved the distribution problem for the package managers
> you choose to support.
>=20
> All I am suggesting you do is that you list pointers to these
> packages, which gpm could then use to actually do the installation fo=
r
> you.
>=20
> The thing I really care about is: once the package has been installed
> locally, how do I activate it and makes its features available to the
> git runtime, without having to futz around with my PATH, MANPATH etc?
>=20
> Yes, this is user focused. I want users of my tool to be able to
> something like:
>=20
>    git pm install gitwork
>=20
> or perhaps:
>=20
>    git pm install git://github.com/jonseymour/gitwork
>=20
> And then start using it. I want the git completions to be there, I
> want the man pages to be there. I want the scripts to be there. In my
> case, there I really shouldn't have to do anything other than point a=
t
> a git url, get the package transported to a local directory and
> activate it.
>=20
> I want to tell my users what they need to do to install my extension
> without having to have variants of the instructions for zip/tar
> people, apt-get people, brew people, MAC ports people, yum people etc=
=2E
> Yes, for compiled stuff, someone has to prepare the packages. But onc=
e
> they are prepared, use whatever package manager the user uses to
> install it and expose the gpm config required to activate it.

python virtualenv has very similar goals and does the same thing, the
only difference is you have to "source env/bin/activate" before using
your local modules (or run env/bin/python). I can clarify what features
from it could be used for git, if you like.

> > I think shipping it in contrib/ and having extension system is a be=
tter
> > option. Though it leaves a hole for dependencies -- if my logx depe=
nds
> > on boost or imagemagick, we don't want make git depend on it...
> >
>=20
> Unless I am misunderstanding something about how contrib/ is managed
> that still requires Junio to be in the loop, which defeats one of my
> objectives here - which is to allow anyone to contribute and share
> their own extensions without being bottlenecked by someone else's
> release cycle.
Yes, you are right. It shouldn't. Like in python.

Motiejus
