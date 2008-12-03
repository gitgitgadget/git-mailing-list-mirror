From: Alejandro Riveira =?ISO-8859-1?Q?Fern=E1ndez?= 
	<alejandro.riveira@gmail.com>
Subject: [BUG Gitk] Resend: git bisect visualize crash
Date: Wed, 03 Dec 2008 18:32:13 +0100
Message-ID: <1228325533.8747.4.camel@varda>
Reply-To: alejandro.riveira@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-umq0Q4SP4QW8YpxO0Dg+"
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 18:33:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7vbX-0003BY-MK
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 18:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbYLCRcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 12:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYLCRcW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 12:32:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:42938 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYLCRcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 12:32:21 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1901307nfc.21
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 09:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:date:message-id:mime-version:x-mailer;
        bh=Pg/Hr2oCLoX27wmZ3BIVV91D+8F2M8xJffpUH4E1vSQ=;
        b=Kn1zmn6g3CrJsupUChqMUf+VCV8BgTF34mz9WjRXYJDHIDll6DNxnlKrDKMURM8ZIH
         Zm5rWyQdSzJNduv4GpJCQA6mjw+uo5tkVmIZ6HWyOfcOPHm7vp9MR/CTXFY1uJPkZ0E8
         3b4aFvtw+AzjV4S1Nfnb8xeCN0LsEqZ+g/cow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:date:message-id
         :mime-version:x-mailer;
        b=Xzg6PHRaPovf+hVNXhmONtOyhVMrKgv96bK8mr4C9Qvu8uDjXUNJ09O7GOxJWOR+Ch
         k87MVmp6epGuIWMaIEbAbqveiSykrxdnXCqaUM61Dqh6CVG20o28R8adZ9c1MJ5akZM6
         4VN0INo9LSQu8J8pc+aJ+DPe5yRnj63WARzic=
Received: by 10.210.136.10 with SMTP id j10mr15617193ebd.188.1228325537749;
        Wed, 03 Dec 2008 09:32:17 -0800 (PST)
Received: from ?10.0.0.2? (197.Red-83-53-124.dynamicIP.rima-tde.net [83.53.124.197])
        by mx.google.com with ESMTPS id t12sm818270gvd.25.2008.12.03.09.32.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 09:32:16 -0800 (PST)
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102272>


--=-umq0Q4SP4QW8YpxO0Dg+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

i sent this already through gmane but i do not get responses
sorry if you see this twice
Please cc i'm not suscribed
---
i'm using ubuntu 8.10 and git bisect visualize is crashing.
Noticed when bisecting the kernel but it is easily reproducible

in git repository as of today

$ git bisect bad
$ git bisect good HEAD~20

$ git bisect visualize                                                     =
             (03-12 12:16)
Error in startup script: can't read "notflag": no such variable
    while executing
"expr {!$notflag}"
    ("--not" arm line 2)
    invoked from within
"switch -glob -- $arg {
            "-d" -
            "--date-order" {
                set vdatemode($n) 1
                # remove from origargs in case we hit an unknown option
                set origarg..."
    (procedure "parseviewargs" line 21)
    invoked from within
"parseviewargs $view $args"
    (procedure "start_rev_list" line 27)
    invoked from within
"start_rev_list $curview"
    (procedure "getcommits" line 5)
    invoked from within
"getcommits {}"
    (file "/usr/local/bin/gitk" line 10897)

$ git --version
git version 1.6.1.rc1
$




--=-umq0Q4SP4QW8YpxO0Dg+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk2wpgACgkQ3GEkiSnUSOGsQQCcDl+e9Amdz4HXVcDP4tHLkzmP
a9oAnjeZjGzsO80Y41kcAITiN3wCY85/
=f09U
-----END PGP SIGNATURE-----

--=-umq0Q4SP4QW8YpxO0Dg+--
