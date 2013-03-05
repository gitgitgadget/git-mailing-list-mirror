From: Jose Garcia Juanino <jjuanino@gmail.com>
Subject: Git hook commit similar to subversion start-commit hook
Date: Tue, 5 Mar 2013 22:14:42 +0100
Message-ID: <20130305211440.GA9929@banach>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 05 22:15:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCzCe-0001HE-NT
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 22:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751Ab3CEVOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 16:14:50 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:54365 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab3CEVOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 16:14:50 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so6579873wgb.20
        for <git@vger.kernel.org>; Tue, 05 Mar 2013 13:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:x-operating-system:user-agent;
        bh=JugVpNACreYORfU8gv02bnZNPWgcOgQLzIGzB2d1XAE=;
        b=0VB9Pal8bmq0FfHaldIHLb6mAfL5y3aR5gY8hLiUW2n+y7zC3vVKgDl8kIsCk7+FbJ
         siUGZXpMbo/CE/4VGEMHg1UbncQwDLrlY8RnnkpisEyWUnTz/G7jRAvMz3jUEkcDs1bc
         tC+gCqKIQ7Zsnofoat0k2bn549DpNmlNhzxwldra3TjlaFGqcOsElICCTZtFKAykSYIa
         bZj253gLb9c0pH9cbun26zDnvse7aspL4WwFzwZKLel/BEtDIoQITL3hFIwsp9qNJKRD
         ik7n7OtW7DUb5/Mzmq+lKWBi5aOrShLgSsL6Tndx8wbldlBqie3pL+V7rxCtT4kzfDXU
         zBRQ==
X-Received: by 10.180.80.73 with SMTP id p9mr18512659wix.22.1362518088794;
        Tue, 05 Mar 2013 13:14:48 -0800 (PST)
Received: from banach (193.red-80-26-193.adsl.dynamic.ccgg.telefonica.net. [80.26.193.193])
        by mx.google.com with ESMTPS id q2sm19193109wiz.8.2013.03.05.13.14.47
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 Mar 2013 13:14:47 -0800 (PST)
Content-Disposition: inline
X-Operating-System: FreeBSD 9.1-RELEASE
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217480>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Is there any hook in Git similar to start-commit subversion hook? The
requirements would be:

1- A hook on the server side (as pre-receive)
2- It will execute the actions *before* the begin of transaction
(pre-receive hook needs the references already pushed before).

For example, it would be useful to refuse a push if the server has a
high load.

I have read man githook, but there is nothing similar.

Best regard, and excuse my poor english.


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (FreeBSD)

iEYEARECAAYFAlE2YD8ACgkQFOo0zaS9RnJ+gQCeKgG2s5UrEvRrhGWUDPOW9BvI
lP8An0WYIKw8IeYbrp1HlgpTUjwNDhey
=bHXx
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
