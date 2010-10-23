From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH] Sync "git diff -h" with the manual, show options
 summary.
Date: Sat, 23 Oct 2010 20:44:25 +0200
Message-ID: <20101023184425.GP4983@home.lan>
References: <1287840825-6491-1-git-send-email-ydirson@altern.org>
 <AANLkTi=kETrjKccdVo188mKjX59mWeCRLVwGpiVP-oQ1@mail.gmail.com>
 <vpqvd4sn5ud.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Oct 23 20:44:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9j5B-0006bT-FE
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 20:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758249Ab0JWSoe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 14:44:34 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:35121 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758211Ab0JWSod (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 14:44:33 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 47AD1D4815C;
	Sat, 23 Oct 2010 20:44:26 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P9j4r-0003wn-2t; Sat, 23 Oct 2010 20:44:25 +0200
Content-Disposition: inline
In-Reply-To: <vpqvd4sn5ud.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159808>

On Sat, Oct 23, 2010 at 08:04:26PM +0200, Matthieu Moy wrote:
> Thiago Farina <tfransosi@gmail.com> writes:
>=20
> > On Sat, Oct 23, 2010 at 11:33 AM, Yann Dirson <ydirson@altern.org> =
wrote:
> >> =A0static const char builtin_diff_usage[] =3D
> >> -"git diff <options> <rev>{0,2} -- <path>*";
> >> +"git diff [<common diff options>] <commit>{0,2} -- <path>*"
> >
> > Why change from <options> to <common diff options> ?
>=20
> Because this is what the man page says I guess.

Yes, as well as the usage strings for diff-tree, diff-files, and
diff-index.  "diff" was just the only one to be different here, and if
we want to keep "<options>" for conciseness here, we also probably
want to change it everywhere (or maybe "<diff options>" for the diff-*
commands ?) - after all, this is just a short usage string, not the
reference page.
