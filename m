X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Minor grammar fixes for git-diff-index.txt
Date: Wed, 25 Oct 2006 16:02:38 +0100
Message-ID: <200610251602.42433.andyparkins@gmail.com>
References: <200610251549.34193.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1341740.vQJTpRZhQd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 15:03:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=TyEwttgo88uijWjsQADlNkECA9yCs/RIBBhVXjqS6XAo8+ufsITVDuyCAqxVvDUMHn3307OuJMhUu/gBV8CmolL+D6dNEu+2Jv/InxWR6sqgW0JT2MVt1QIlUyBrnopXQLX0bzDpA9+Ejt98qr4Q9gnN58rMZVTmmyFnpsMz/YQ=
User-Agent: KMail/1.9.5
In-Reply-To: <200610251549.34193.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30064>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GckHM-0000d7-DV for gcvg-git@gmane.org; Wed, 25 Oct
 2006 17:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932450AbWJYPCs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 11:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWJYPCs
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 11:02:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:21783 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932450AbWJYPCr
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 11:02:47 -0400
Received: by ug-out-1314.google.com with SMTP id 32so117921ugm for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 08:02:46 -0700 (PDT)
Received: by 10.67.100.17 with SMTP id c17mr979755ugm; Wed, 25 Oct 2006
 08:02:46 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id l33sm2031805ugc.2006.10.25.08.02.45; Wed, 25 Oct 2006 08:02:46 -0700
 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--nextPart1341740.vQJTpRZhQd
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=46rom 9f5b5b3d4925ac5f22a64fd075c50417cff7b496 Mon Sep 17 00:00:00 2001
=46rom: Andy Parkins <andyparkins@gmail.com>
Date: Wed, 25 Oct 2006 15:59:53 +0100
Subject: [PATCH] Minor grammar fixes for git-diff-index.txt
To: git@vger.kernel.org

"what you are going to commit is" doesn't need the "is" and does need a com=
ma.

"can trivially see" is an unecessary split infinitive and "easily" is a more
appropriate adverb.
Signed-off-by: Andy Parkins <andyparkins@gmail.com>
=2D--
This corrects the previous grammar patch - the original use of "where" was=
=20
correct.  You know when you say a word enough and it loses all meaning...

 Documentation/git-diff-index.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff-index.txt=20
b/Documentation/git-diff-index.txt
index 9cd43f1..2df581c 100644
=2D-- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -54,7 +54,7 @@ If '--cached' is specified, it allows yo
=20
 For example, let's say that you have worked on your working directory,=20
updated
 some files in the index and are ready to commit. You want to see exactly
=2D*what* you are going to commit is without having to write a new tree
+*what* you are going to commit, without having to write a new tree
 object and compare it that way, and to do that, you just do
=20
 	git-diff-index --cached HEAD
@@ -68,7 +68,7 @@ matches my working directory. But doing=20
   -100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        commit.c
   +100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74       =20
git-commit.c
=20
=2DYou can trivially see that the above is a rename.
+You can see easily that the above is a rename.
=20
 In fact, "git-diff-index --cached" *should* always be entirely equivalent =
to
 actually doing a "git-write-tree" and comparing that. Except this one is m=
uch
=2D-=20
1.4.2.3


--nextPart1341740.vQJTpRZhQd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFP3ySwQJ9gE9xL20RAgc1AJ9giejLk0qwJrYzS0mkqieZxywStQCcDmaX
CZJIjFXQm/GeJ9Ftbl7tYl4=
=80rS
-----END PGP SIGNATURE-----

