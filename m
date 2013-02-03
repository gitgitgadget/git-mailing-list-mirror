From: Robert Clausecker <fuzxxl@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Sun, 03 Feb 2013 19:11:26 +0100
Message-ID: <1359915086.24730.19.camel@t520>
References: <1359901085.24730.11.camel@t520> <510E8F82.9050306@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-HCcaPiI5QhMYhHTW15AN"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 19:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U242p-0003Fx-MB
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 19:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab3BCSLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 13:11:32 -0500
Received: from mail-bk0-f47.google.com ([209.85.214.47]:63207 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab3BCSLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 13:11:31 -0500
Received: by mail-bk0-f47.google.com with SMTP id jc3so2421772bkc.6
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 10:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:date:in-reply-to:references
         :content-type:x-mailer:mime-version;
        bh=YR+Nlb7jcGFIN+mOvpHMdxAvCT3SNsJwOsU32fkFNEM=;
        b=PaT367vjGpuMF4VIoNb8j3WCg+0+Q+cUacUA5a/2MA1HYeKAGRNDECij7+AlLpOsld
         VCNs+2ux+aqa7ZCFeuk4R4jpsv5toesLYyUZLlN/FakbrYeIpH533FadHNFx7cKoFQz1
         vGfFL41xEn9sDYgXL4lsq6EMc1/H8vJ9lNs2gC1LIrbpO9n5Cwhn6jnsc1EL5m3yFTHc
         yPnYXkwzcdAPyQTdGKGCt3Ewi6+Qso249jYEh5up1uy9gLl0rWlKjX2YTz1ocJb9V6Fs
         VsNIZTpUx3YMmeZb8duMTdz48Wj4q8vszm0FZgaKcA428/2e6BsG/91d5bvk5gzvxyPY
         Gxqg==
X-Received: by 10.204.8.16 with SMTP id f16mr5080827bkf.81.1359915090196;
        Sun, 03 Feb 2013 10:11:30 -0800 (PST)
Received: from ?IPv6:2a01:1e8:e100:10b::2? (cl-268.leo-01.de.sixxs.net. [2a01:1e8:e100:10b::2])
        by mx.google.com with ESMTPS id x10sm4603586bkv.13.2013.02.03.10.11.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Feb 2013 10:11:29 -0800 (PST)
In-Reply-To: <510E8F82.9050306@gmail.com>
X-Mailer: Evolution 3.6.0-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215320>


--=-HCcaPiI5QhMYhHTW15AN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


Am Sonntag, den 03.02.2013, 21:55 +0530 schrieb Sitaram Chamarty:
> Could you help me understand why piping it to tar (actually 'tar -C
> /dest/dir -x') is not sufficient to achieve what you want?

Piping the output of git archive into tar is of course a possible
solution; I just don't like the fact that you need to pipe the output
into a separate program to do something that should be possible with a
simple switch and not an extra command. It feels unintuitive and like a
workaround to make an archive just to unpack it on-the-fly. Also, adding
such a command (or at least documenting the way to do this using a pipe
to tar somewhere in the man pages) is a small and simple change that
improves usability.

Yours, Robert Clausecker



--=-HCcaPiI5QhMYhHTW15AN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJRDqhOAAoJEDpa/qG5y+V5UJAH/0c0WsAvewUmfjIJILCTLbef
6euBx33zMYmmAYUFRtTEe9MBE/xu0cVRkm3YY8o3ye+9lwLwnLHY1sqbpt85CCQ9
SUXrXDVxyf2RJqgFC4zePFY47mTfFQfqA1iI4u2I5oapDtF0de0S8T8NzElrq6Zl
SdnQlZLdQQ9sw+8yUk1RMzub4pJiS6UE9vKbmUiw33B3AeYXOoAOMBgIhiO5HKcA
/Ux2ySTeR0xHXE5IKh3wl1ge/ldt7ukrIsPaB9H+VJFAPDgywaqo/I4wfX1YtfcS
1s1OCnpvqhglVLuKdTahRklKN/IDueek3hVEgwZKL5TMZWH4jfEVTfV+x7E4+vQ=
=lC7U
-----END PGP SIGNATURE-----

--=-HCcaPiI5QhMYhHTW15AN--
