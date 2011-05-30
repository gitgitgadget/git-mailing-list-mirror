From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: git version numbers
Date: Mon, 30 May 2011 16:06:55 +1000
Message-ID: <20110530060653.GB3723@Imperial-SD-Longsword>
References: <20110528201321.GA26017@Imperial-SD-Longsword>
 <20110530033428.GB27691@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 30 08:07:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQvdC-0001Ui-Ea
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 08:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab1E3GHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 02:07:01 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54677 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab1E3GHA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 02:07:00 -0400
Received: by pzk9 with SMTP id 9so1474842pzk.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bpRV3x/0haoUlKQWqMy26+Zf54Z+rFzTt8Npi2Wjp20=;
        b=uom9cGGFs+CdzLF0LrHT5OSjibO4QcVkpp2ObgCpw3wywhC7dmqaERp1CSIJnTSCwJ
         1jwmEecpOMaJj9sMj4PFKiPvrLxNgkkXl/YSQU9pywVSl7H2tHPoT1dgoNHFaNnWTGml
         siZ5EDnj3UqiLsre36M5G0fRkjadSssjLlhjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lEuFles8SnPIw868u5S0ZOaPpo4sxOO93zMbxXZEqeM2pD2kzfN/y5j1b5I1AyqnSN
         Lhr5byUNkypqhdT8328DhE8oBuUzv21TdeUzx+iXKxOoXtgzp+5EH40AUmZbovc+woHG
         avSl7FxXnG/JfIi7chkafHb//otGF23hpVH4U=
Received: by 10.68.17.7 with SMTP id k7mr1788813pbd.322.1306735619637;
        Sun, 29 May 2011 23:06:59 -0700 (PDT)
Received: from longsword.imperial.fleet (c114-76-222-200.rivrw3.nsw.optusnet.com.au [114.76.222.200])
        by mx.google.com with ESMTPS id m9sm2610489pbd.7.2011.05.29.23.06.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 May 2011 23:06:59 -0700 (PDT)
Received: from tim by longsword.imperial.fleet with local (Exim 4.76)
	(envelope-from <tim@imperial-sd-longsword>)
	id 1QQvct-0001H0-9x; Mon, 30 May 2011 16:06:55 +1000
Content-Disposition: inline
In-Reply-To: <20110530033428.GB27691@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174723>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 29, 2011 at 11:34:28PM -0400, Jeff King wrote:
> In "git w.x.y.z", the decoding is:
>=20
>   w: not likely to change short of a complete rewrite or something that
>      is quite incompatible (i.e., will probably remain "1" for quite a
>      while)
>=20
>   x: when this jumps, it is a "big" version change, meaning there may be
>      some minor incompatibilities or new ways of doing things. For
>      example, 1.5.0 introduced a lot of usability changes and the
>      separate-remotes layout became the default. In 1.6.0, we stopped
>      shipping "git-*" in the PATH, and started using some new packfile
>      features by default. And so on. If you want to know more, see
>      Documentation/RelNotes/1.?.0.txt.
>=20
>   y: when this jumps, it is a new release cut from master that does not
>      have any "big" changes as above. There will be new features and
>      some bugfixes. See RelNotes/1.7.?.txt for examples of what gets
>      included.
>=20
>   z: when this jumps, it is a bugfix release based on the feature
>      release w.x.y. See RelNotes/1.7.5.?.txt for examples.
>=20
> Getting more to your actual question, I don't know that we ever use any
> particular name like "major" or "minor" for any of them. We do tend to
> use the terms "feature release" for w.x.y releases and "bugfix release"
> for w.x.y.z.

Ah; I see.  The system I was considering was essentially identical,
except instead of calling it w.x.y.z, they are actually named them in
the form of <super-major>.<major>.<minor>-<optional revision>.  As for
the decoding, it's identical: super-major is an almost never change
number; major is when there's something "big"; minor is when there's a
"release", but it's not "big"; and revision for a bugfix.

Well, thanks for the clarification.

While we're on the topic, though, when I was scouring the web for
information, I found a post [1] which spoke against the traditional
numbering versioning system.  Personally, I disagree and find the
"dating" version cumbersome and uninformative.  So, I was wondering what
your [2] take on this is.


Tim.

[1] http://www.codinghorror.com/blog/2007/02/whats-in-a-version-number-anyw=
ay.html
[2] By "you", I mean anybody in the list, of course.

--=20
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org   - against proprietary attachments

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJN4zP9AAoJEGNoa2q+dzQWe68QAKbiOocIzqRdAyebz4iXeeGp
8wWmqImINjPCgeja3LgH1uLUfRgCe5GRMg++SjTGVEqjIC6Qp6uwy6czsr+GKGGe
NzqwdhSLynlyRUu5pV1mkKq7ZikqOB4wRz7z/gMxh+nj5OK6pFcgb7vaGdF0KI79
GYdussd/G4F3FzKG92NnOoapWmgIVuhUT4EkBpZlzyGGrxg/xJFJig8ljLXPDPi6
iAtqSd4iS7MTyEN9+oV898Xy6vI6luPLd/aMnSRipmg9SA3erSB0Gwks0K+rejqm
BZI/LjhLu9AYaiRKPS3MQbrF5pIoJuFbvexXhwlzlzyGgNKo4lh4TOwEs57byG3f
zCrmrD57Sv1lELsHt2WFKZjPkcPRFxaqZ9TG9bav7UEs87a4VokYohY4pb+nBMcT
EE1ORXDhM2BRy61s0wOV2bFrvRcFo5brkpSPmW4p1r2kdr4ona0frPOzNf4top2i
0S9hySZZzWEGoS4+SYfJmbwHgiEG88wd27sP5UTzuVaIELJDGEGIwiAAi78lwF7D
ZmpsoEK1XZGLYSUMzOM8hm4BKM5b0X8vex+M5D8Yj+8jG2rTyysp+lYTNgfKfTrD
eHMhKZ4bulB2eDiG/rUhdIGKYEivHRjLRV/e0LQnpLGBmH4XLlk0StIr9NCvVu5j
23WbTqCgDUree0x/OF4i
=f+AE
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
