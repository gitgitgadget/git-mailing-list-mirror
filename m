From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: important upgrade info for Fedora/EPEL RPM of gitolite
Date: Fri, 4 Nov 2011 19:27:37 +0530
Message-ID: <20111104135737.GA15986@sita-lt.atc.tcs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Cc: limb@jcomserv.net
To: gitolite@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 14:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMKHN-00020x-3v
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 14:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453Ab1KDN5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 09:57:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60007 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253Ab1KDN5w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 09:57:52 -0400
Received: by iage36 with SMTP id e36so2570926iag.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=09aUDBXAxEgXU4spt+ZNjYnpXwdPeQ2/43n8QpdY+8s=;
        b=UQ66I2EafRzogmcA8isGx1n524oYj8mJs44cqhhMlk8qTgL80aBl/l3a1RmFJ6wKTf
         pkplRe5/QMzQllqYxwZSBQfKf0PW45nbfHYgTdL2Q2bWobrOOrDol6Il0xw8ulcQhqtP
         3vZ6hr7B4dPzZPYAVdxSC93ayhUSpv0ne/gjU=
Received: by 10.42.123.212 with SMTP id t20mr15797522icr.12.1320415071498;
        Fri, 04 Nov 2011 06:57:51 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([14.97.63.96])
        by mx.google.com with ESMTPS id dd36sm21119984ibb.7.2011.11.04.06.57.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Nov 2011 06:57:50 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184768>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

If you're using a Fedora/EPEL RPM of gitolite, and
upgraded/upgrading from 1.5.* to 2.*, then please do this as
soon as possible after the upgrade.

(1) look in ~/.gitolite.rc on the server for these variables:

   $GL_PACKAGE_CONF
   $GL_PACKAGE_HOOKS

If they are both defined, (and uncommented), you should be ok.

(2) if they are not defined, please add these lines at or near
the top of the file:

   $GL_PACKAGE_CONF="/usr/share/gitolite/conf";
   $GL_PACKAGE_HOOKS="/usr/share/gitolite/hooks";

Save the file, then run gl-setup (without any arguments).

This will fix up some issues related to the upgrade that
required variables in the rc which the RPM would not
automatically insert (per policy and for sanity in general!)

----

Thanks, and sorry for the trouble.  If you have any questions
please feel free to ask.

Sitaram

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOs+9QAAoJEKRCkIUIgjelRhwP/RC5ZtiMJ4O/sZt5pSG2kDSV
PwASsoMNvB3VeBPzJBHCCnk0I0ecX61oJiiD1Nof9ZbxqEsW3/QLE7wOfLC+fgZ9
uZPcGEgw2Y3dJ5+vU76bMRRpzF0o6ZGyLdKokEIS/2fn+3UXLoX+Pw8M4MDmxJZM
c+CE1a0UEJ7JKIengZrsLA3gXU1fGqo175cjncd50jv28hdE/Y3Pws3DI2wquKtz
zC4j/NpnFs3g0Mu6fcIFPwU08w/IIwLEDTVvriC/luBhQfcpTEy9n3i8F9Wa7m+8
WMHdnPPuqKeLL2qEAtzTvlqecj4NJ6gMU9efJbswneLJAROs7AlQYcBaQLGQhMtv
U/a1wU6IO6pt2Q5g7h7Yvd9z9l/0C1yIZFrzoDVqx7cObDKUbaDPLM4qH8Qz9Nvv
gXCaa67+AKhta221xHE6pgJ8B1b5LhJ2K+6f3lnnzHZ67nVAsVkxRG1b+eOQHq1I
C1q9SZ9Cg9VSTTDmmYSuW3vEFjxGuJuPgUykO4b2ZRoSdLOv9vx5UODYUuNLIZpB
9h9p4jj6vvgKfqlwCN2YNuA3bnTkOh4lmEOJHWw9qZ0+PfYKNbiEQs+DtHGpz1j9
Am31VDzEz6ybDQcxraO6P21BGXt/dUwe/pAm2u1VwFq0FzZLPkP9qxR2q4ToJPUX
oYFti9dH8CSQ0eEcjcxh
=xa3E
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
