X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: git-fetch not working?
Date: Tue, 24 Oct 2006 21:00:45 +0100
Message-ID: <200610242100.52671.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2523439.rL9G6X0b20";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 24 Oct 2006 20:03:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=obYjtFJ4bkVPhDsJnRy/mzF7y6J6VVRviu9MxFXz7u4fD6Oj5w0o0hEMmyru7+miKtIKPyzG9T9cbV4iOc8mzDY7qrHqNOU9uJ3+TJJ9XbtkAJGRBImv5LU6QX5KTpZTxiD8jkxlt35i+CjbxO6GtqxeBSJK9AocFsq8KM8IGSM=
User-Agent: KMail/1.9.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30009>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcSUm-0003NZ-P9 for gcvg-git@gmane.org; Tue, 24 Oct
 2006 22:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161219AbWJXUDa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 16:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161223AbWJXUDa
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 16:03:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:30568 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161219AbWJXUD3
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 16:03:29 -0400
Received: by ug-out-1314.google.com with SMTP id 32so313136ugm for
 <git@vger.kernel.org>; Tue, 24 Oct 2006 13:03:28 -0700 (PDT)
Received: by 10.67.119.9 with SMTP id w9mr8069268ugm; Tue, 24 Oct 2006
 13:03:26 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 59sm1161557ugf.2006.10.24.13.03.25; Tue, 24 Oct
 2006 13:03:26 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--nextPart2523439.rL9G6X0b20
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

$ cat .git/remotes/origin=20
URL: git://git.kernel.org/pub/scm/git/git.git
Pull: refs/heads/master:refs/heads/up/master
Pull: refs/heads/next:refs/heads/up/next
Pull: refs/heads/maint:refs/heads/up/maint
Pull: +refs/heads/pu:refs/heads/up/pu

$ git fetch
fatal: unexpected EOF
=46ailed to find remote refs

$ ping -c1 git.kernel.org
PING zeus-pub.kernel.org (204.152.191.5) 56(84) bytes of data.
64 bytes from zeus-pub1.kernel.org (204.152.191.5): icmp_seq=3D1 ttl=3D54 t=
ime=3D182=20
ms

Am I doing something wrong?


Andy
=2D-=20
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com

--nextPart2523439.rL9G6X0b20
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPnD0wQJ9gE9xL20RAiJQAKCSrY/yNbQqvYQCSC6uysNcqf8JSACaA7eD
7DrXGnkOVPADdiDNn7JvcaM=
=5b5j
-----END PGP SIGNATURE-----

