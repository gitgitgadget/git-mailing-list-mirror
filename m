From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation: help: describe 'man.viewer' config variable.
Date: Thu, 28 Feb 2008 04:51:08 +0100
Message-ID: <200802280451.08728.chriscool@tuxfamily.org>
References: <200802271323.m1RDNGTR025557@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pascal Obry <pascal@obry.net>
To: =?utf-8?b?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 04:46:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUZie-0008Vb-7H
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 04:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757AbYB1Dp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 22:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689AbYB1Dp2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 22:45:28 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:56617 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592AbYB1Dp1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 22:45:27 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 47EEA1AB2B1;
	Thu, 28 Feb 2008 04:45:26 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2512C1AB2AC;
	Thu, 28 Feb 2008 04:45:23 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200802271323.m1RDNGTR025557@mi1.bluebottle.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75348>

Le mercredi 27 f=C3=A9vrier 2008, =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=
=81=AA=E3=81=AA=E3=81=93 a =C3=A9crit :
> Quoting Christian Couder <chriscool@tuxfamily.org>:
> > +man.viewer::
> > +	Specify the program that will be used to display help in the
> > +	'man' format. See linkgit:git-help[1].
> > +
> >  -i|--info::
> > -	Use the 'info' program to display the manual page, instead of
> > -	the 'man' program that is used by default.
> > +	Display manual documentation about the command in Info
> > +	format. The 'info' program will be used for that purpose.
>
> I am not a native speaker of the English language, but "manual
> documentation about" feels duplicatedly redundant, at least to me.  I
> think it is more common to say "the manual page for", or "the man pag=
e
> for".

Yes, I will send an updated patch saying "manual page for" soon.=20

> >  -m|--man::
> > -	Use the 'man' program to display the manual page. This may be
> > -	used to override a value set in the 'help.format'
> > -	configuration variable.
> > +	Display manual documentation about the command in Man format.
>
> An earlier description for man.viewer says "in the 'man' format".

Ok, it will say "'man' format" everywhere.

> > +	This option may be used to override a value set in the
> > +	'help.format' configuration variable.
> > ++
> > +By default the 'man' program will be used to display the man pages=
,
>
> And this part says "the man pages".
>
> >  -w|--web::
> > -	Use a web browser to display the HTML manual page, instead of
> > -	the 'man' program that is used by default.
> > +	Display manual documentation about the command in HTLM format.
> > +	A web browser will be used for that purpose.
>
> Is this a mistyped "HTML format"?

Right, it will be fixed.

Thanks,
Christian.
