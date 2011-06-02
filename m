From: Tim Guirgies <lt.infiltrator@gmail.com>
Subject: Re: Can't get git rebase --onto to work
Date: Thu, 2 Jun 2011 21:18:26 +1000
Message-ID: <20110602111825.GC4709@Imperial-SSD-Overlord>
References: <BANLkTikF7p_XsU6YJ81bq10S3nL6tBsApg@mail.gmail.com>
 <20110602103833.GA4709@Imperial-SSD-Overlord>
 <BANLkTin92KXYO3YF1UytcesWUV-Nh_LaGg@mail.gmail.com>
 <20110602105223.GB4709@Imperial-SSD-Overlord>
 <BANLkTik-o=h05=d5JH_LirYQkNzgdYaZxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 02 13:18:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS5vD-0004ed-2M
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 13:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933129Ab1FBLSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 07:18:34 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47136 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932424Ab1FBLSd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 07:18:33 -0400
Received: by pwi15 with SMTP id 15so454431pwi.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OcfJTiOv3a2hRDwGlXVG+6LBcXyXRIv2MtQSv/+Nzfs=;
        b=K/YjpzRaph0hT7ZJ8pZdmuQr2NAsQ80XIRkMGe46Jrq/mFgRHhc/eaxaTTL2cHBGRC
         dSjKKfgl3Xs7/iQpSHGDHHp5k6ZvFRjYSNfsBMjsngU0h6Mxc+2cpSJFYvN5qiKPiH6a
         ufmllIjOR03G6XYKfhhRT2k7L9ua90ZvKVHNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JGSMpMootvD+5kFw+T82xPPRxfbfV0n+U8RD6kuirQ54F1o3MbqxSRoj5xcKuLDI8r
         IPKH5gcyUOvtkG96xr6dFQwzlhzQfCIPONtX9/P+AQmGFH/SH7BYrPR6JF7l6I9AmkfS
         as1GQqlfWoXDKROGX7LSuFJX70LLOF/CeqlGU=
Received: by 10.68.50.9 with SMTP id y9mr245398pbn.24.1307013512097;
        Thu, 02 Jun 2011 04:18:32 -0700 (PDT)
Received: from overlord.imperial.fleet (27-32-25-138.static.tpgi.com.au [27.32.25.138])
        by mx.google.com with ESMTPS id x1sm506329pbb.34.2011.06.02.04.18.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 04:18:31 -0700 (PDT)
Received: from tim by overlord.imperial.fleet with local (Exim 4.76)
	(envelope-from <tim@imperial-ssd-overlord>)
	id 1QS5v0-0003qx-OJ; Thu, 02 Jun 2011 21:18:26 +1000
Content-Disposition: inline
In-Reply-To: <BANLkTik-o=h05=d5JH_LirYQkNzgdYaZxg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174943>


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2011 at 11:58:36AM +0100, Howard Miller wrote:
> On 2 June 2011 11:52, Tim Guirgies <lt.infiltrator@gmail.com> wrote:
> I very much doubt it :) It'll be me failing to explain properly.

I wasn't fishing for compliments; I'm actually confused about that
fast-forward merge.  Why do you need it?  What are you fast-forwarding
and where to?

> On 2 June 2011 11:52, Tim Guirgies <lt.infiltrator@gmail.com> wrote:
> > As for the manpage, though, as someone who read and misunderstood it, do
> > you have any suggestions for its improvements?
>=20
> The examples are very helpful but it could be a little more explicit
> which branches are going to get modified by the rebase. Once there are
> several branches in play it becomes quite a hard think.
>=20
> Mostly, I just needed a kick to say "look where the branch heads are
> pointing" (in the example diagrams) before and after the rebase. I
> don't think I would have got it without the remark in Pro Git that a
> final merge is required to get the HEADs where I wanted them. Like
> most things - it's completely obvious when you know.

I'll try to prepare a patch and see if I can improve the wording at all.
I'd like you to have a look over it, if you don't mind, and with your
recent episode fresh in your mind, review it as if you were reading it
in that situation for the first time.

Can you please also point out which section of the doc caused you
confusion?


Tim

--=20
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org   - against proprietary attachments

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJN53GBAAoJEGNoa2q+dzQWivIQANijgCQI8MWMIKybbF7eq8QR
EH/yDM8WyhqNItUNE8ilNMe5dWg4oe5KLdlXT5R0QT/HlSdpKeSwFlf7hM1DOUe0
5yR+MZO0fkiAqlM8L+op9Adf5m4beFpWM1H50xqc+ZsYGfiNo3Ewpa1FxNBgXHIy
O4gbYzPVOBJO4Il+VoLM4lIxzYpV/tlXPLjX1ABQwZdQwJO3078JNAtxjYXtq3if
Irvfx1jb/XAE7tCn67i9FDvogZDib+YOHKKhPE75HN5svyOgM+A18UZtJKxhGLqQ
snFgTuZ0PBHsw3BdGcEWLna486K1xXTI5nJP2JwaEK3n555Jyl3nUdTq0LyPbp00
l85lSAFoFReuSXfvL58MsLbuauQdae5gsDWqwohK+myVFBcufS1CAvyglWWMoNQ0
qUBzwxWIkpx/kQFiEr/t4xPPV4pwyKAFGw+qeh8nlBybHArtRfUTYOlnVKTsW7HJ
8QrqoyToOFyfx5VQaDRf+tlzzS+HHX7Wc8xw8ZHafOtHounLWybLInLXzHHUXsdm
kHU2XxzI8Hx485LqSEY0V//RZ9DNXNZtmnlXpjHNUKwqC7DoWzI+gYvBAeZGw+n9
Oj0aMEPz5lHLJUA1gg3Rzdfdg/WI3vpSUhPbTGoTgUA2opFa90Hsi5EmQUMlFE/k
HXmpULSbq8T/tLfG2oau
=lPxd
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
