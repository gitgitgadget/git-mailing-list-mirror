From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [PATCH 2/2] mergetool-lib: add a three-way diff view for
 vim/gvim
Date: Fri, 24 Sep 2010 12:09:28 -0700
Message-ID: <20100924190928.GC3768@vfa-6z.perlninja.com>
References: <1284517303-17244-1-git-send-email-dpmcgee@gmail.com>
 <1284517303-17244-2-git-send-email-dpmcgee@gmail.com>
 <20100918073428.GA9850@gmail.com>
 <AANLkTim_hwduHk-ENM73dwHUj9XbwfihZPRfsHX+M3DE@mail.gmail.com>
 <AANLkTin-BSAFwvuTyJ96BW6MqrKVEni+Af2M0u7WE_yZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 21:09:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzDeH-0004W7-Lm
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 21:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab0IXTJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 15:09:32 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60380 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab0IXTJa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 15:09:30 -0400
Received: by pvg2 with SMTP id 2so768848pvg.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 12:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:x-pgp-key:user-agent;
        bh=JOn2DX075QWTV3f/JypCVbwNSVSOXzXaeaGUilA0vdA=;
        b=Dh1+mzLGncboGuf0Ppa0G47cmHEt46FiDgK5S0El5G5H/1EUwEOlNkXEtYgP4vsEYx
         1UjEYHUygyB1b1YPTinMBXNLWzVIHyrX7ohLi9v2HKcooE16aoKQvp0AjdXiTqnBG4a4
         fTcOPOni6v4DcK57JQLJuohyht/jy+yb29quk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:x-pgp-key:user-agent;
        b=F2jDESC2D09nXJzGilzyOYtXxzBVWXnFsOOOeLWB3VqnO3SBYc5/RScPSXbK+LAxlo
         jHU95w4Qq5x7b6lEj8X+Ju0qsANA7Fo52BtM7JMaDyIIqHQP0Hvni9gxnN9eZFatNxkN
         S/n380gpfNXfOLfn575g9UKsu2GTlCiLZeqGE=
Received: by 10.115.18.12 with SMTP id v12mr4159552wai.114.1285355370260;
        Fri, 24 Sep 2010 12:09:30 -0700 (PDT)
Received: from localhost (66.239.37.190.ptr.us.xo.net [66.239.37.190])
        by mx.google.com with ESMTPS id k23sm4042133waf.17.2010.09.24.12.09.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 12:09:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin-BSAFwvuTyJ96BW6MqrKVEni+Af2M0u7WE_yZ@mail.gmail.com>
X-PGP-Key: http://technosorcery.net/pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157038>


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Sep 2010 14:01:01 -0500, Dan McGee wrote:
>=20
> On Sun, Sep 19, 2010 at 4:48 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > On Sat, Sep 18, 2010 at 10:34 AM, David Aguilar <davvid@gmail.com> wrot=
e:
> >> On Tue, Sep 14, 2010 at 09:21:43PM -0500, Dan McGee wrote:
> >>> When the base version is available, use a three-way, four panel view =
by
> >>> default. This shows the (local, base, remote) revisions up top and the
> >>> merged result by itself in the lower pane. All revisions will still s=
croll
> >>> together by default, and the cursor still defaults to the merged resu=
lt edit
> >>> pane.
> >>>
> >>> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> >>> ---
> >>>
> >>> Vim was one of the few diff commands to not support a three-way merge=
 showing
> >>> the base revision, so this is a stab at resolving that shortfall. The=
 biggest
> >>> objection I can see to this is making the interface a bit more cumber=
some and
> >>> bloated.
> >>>
> >>> An example screenshot of what this produces:
> >>> http://www.toofishes.net/media/extra/vim_three_way.png
> >>>
> >>> -Dan
> >>
> >>
> >> Patch 1/2 of this series looks good to me.
> >>
> >> Is it worth keeping the old behavior and calling this new
> >> mode "vimdiff3" or something along those lines?
> >>
> >> I'm not a vimdiff user so I'm not be the best person to
> >> judge the merits of this change. =A0I like what it's trying
> >> to accomplish, though. =A0Are there any vimdiff users
> >> with strong feelings either way?
> >
> > I think this is a definite improvement; the old mode wasn't really
> > useful for me.
>=20
> Not as much feedback as I had hoped, but thanks to those that did
> speak up. I was thinking of adding a separate mode, but I think it
> would then get under-used and as I said, every other merge tool was
> already doing this anyway.
>=20
> So are these patches good to go forward with? No major objections in a
> over a week's time.
>=20
> -Dan

I'd +1 David's suggestion of calling this "vimdiff3", I'd like to still
be able to access the current behavior, since I have merge.conflictstyle
=3D diff3, and already see the merge base when I use (g)vimdiff with
mergetool.

--=20
Jacob Helwig

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQGcBAEBAgAGBQJMnPdnAAoJEHJabXWGiqEBkysL/ic9x6528vZmkjJtgOYRYGun
Cw3C/TSKo3r1qGsbJYlR84apNfPHMqlNSrUNeBBIaWkuMxIlWSHzrgZNZLpIAGdi
6TT0Hz5P7c3AZZ7VD+wFhGzueBjt0av3rCmywCFrXm13tfNP6oSOnNYDfyFBzhri
sHE2DGnZnI6bQQhcUJy9mxiT/L4ylpO28I+O3DB+qYEues/l6eCncpkANU0L6rzr
8pEZIEqNNG8rcduEvqZlJEsI/njhD4EeRd44pxlC7RH9CLhVuLh3F8jQ0e5S/Ux0
qsboqLnZAcMeBYxK/sGmn9lllgwwocKKtLp+bBOCQCVZd6b3NrO2C7Xz25nLqR8/
wAEzp7dRKkwhU/JZsGi4NHSZa2AX9wjrugVWeB70pMtbEyP7xYNk+eCb0ZjXiUto
Npf+6CFLhqKGLVHtgo3j5O4N2PXyIMFL3pO6UGC5Y1gV6mWZCN3QLgZ4QSZ32uo3
EMzl+FkWhE7RDiMgef4ZxlkUxm81p7dHKVgzgtawsQ==
=lm4p
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
