From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [BUG] git gui blame  fails for multi-word textconv filter
Date: Thu, 19 Aug 2010 12:05:06 +0400
Message-ID: <20100819080506.GA31474@landau.phys.spbu.ru>
References: <vpqlj8l2xd5.fsf@bauges.imag.fr> <1281002722-3042-1-git-send-email-Matthieu.Moy@imag.fr> <87aap0sljs.fsf@fox.patthoyts.tk> <vpqlj8l2xd5.fsf@bauges.imag.fr> <1281002722-3042-1-git-send-email-Matthieu.Moy@imag.fr> <20100804192525.GA13086@landau.phys.spbu.ru> <4C59FBD5.5090209@ensimag.imag.fr> <vpqlj8l2xd5.fsf@bauges.imag.fr> <20100804192525.GA13086@landau.phys.spbu.ru> <4C59FBD5.5090209@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Aug 19 10:05:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om07r-0000GE-VY
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 10:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab0HSIFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 04:05:12 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:33413 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab0HSIFI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 04:05:08 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 60F87FF6C4; Thu, 19 Aug 2010 12:05:06 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <87iq3osm3h.fsf@fox.patthoyts.tk> <87eieby69a.fsf@fox.patthoyts.tk> <vpqaap0cees.fsf@bauges.imag.fr> <87aap0sljs.fsf@fox.patthoyts.tk> <1281002722-3042-1-git-send-email-Matthieu.Moy@imag.fr> <vpqlj8l2xd5.fsf@bauges.imag.fr> <4C59FBD5.5090209@ensimag.imag.fr>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153909>

On Thu, Aug 05, 2010 at 01:46:29AM +0200, Cl??ment Poulain wrote:
> Le 04/08/2010 21:25, Kirill Smelkov a ??crit :
> >Hello,
> >
> >I use
> >
> >     [diff "astextplain"]
> >         textconv =3D run-mailcap --action=3Dcat
> >
> >in my ~/.gitconfig, and this works for git `git blame` because of 41=
a457
> >in git.git (textconv: use shell to run helper), but fails with git g=
ui:
> >
> >     $ git gui blame 21980.2--=D0=98=D0=9C=D0=A1-=D0=9C=D0=A0231.doc
> >     Error in startup script: couldn't execute "run-mailcap --action=
=3Dcat":=20
> >     no such file or directory

[...]

> >If so, I'd better teach cat-file about worktree, instead of teaching
> >git-gui about running textconv filter through shell. Just a wish...
> >  =20
> This was discussed here: a1ace6b77167a2ad4b4995e8c4d09761@ensimag.fr =
,=20
> and your suggestion was considered ;-)

I see, thanks. Sigh that it is done not that way, but anyway -
everybody, thanks for fixing this.

Kirill
