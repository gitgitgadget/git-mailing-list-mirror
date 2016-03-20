From: Georg Pichler <georg.pichler@gmail.com>
Subject: git diff --exit-code does not honour textconv setting
Date: Sun, 20 Mar 2016 13:43:53 +0100
Message-ID: <56EE9B09.6040700@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="42Aana4tptMCchGdsB8KiGblSD3JHkCbs"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 13:44:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahci9-0003vI-SD
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 13:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbcCTMn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 08:43:58 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36708 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773AbcCTMn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 08:43:56 -0400
Received: by mail-wm0-f50.google.com with SMTP id r129so19718710wmr.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version;
        bh=wM0sF3T7Pf4yH2rkNyAymCCR6ZYHFPN5RVo6NKGA0Yc=;
        b=BSLpb/g+tqmrQx6kfIQldkKnk0oASba9NRT31hAhJiGuDehykeBnbv/ZWRRs//9NqS
         4PAtDbagKXxsDgOSro/nh6v6+zat9fSGu9ZUV3IdTWLSXdYvkzsHOHTvCFqoRqWLwPCS
         9huMahECMOCaBK3xNjkfMW5nNIxRGVPWNKegJZClVuO0ockT95GxWLNtTXaRLkZCSbmY
         t/o8HWCSJJwc1aINPMxfSbLIb/mIWOja9HGXen8+7oDE87XX04Ji/HjdDduV1jjgitIx
         aGtc9RPzyYfsUyEadZQLtdoey8e1xmnq1FqpBcTDE/c/hZbH+aempk+Nc7eXUyXrbSKw
         JP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version;
        bh=wM0sF3T7Pf4yH2rkNyAymCCR6ZYHFPN5RVo6NKGA0Yc=;
        b=VSSQlEJ2wQsV6V78nCsz8Y/cuV2LTyBCNwAiKMrnRFzAWuZvh3tM0dOK0Af81jIXDu
         SrdouC0UvnAA76kSI4Jkk1lw5bjK5ZIXTY5GD4a8SCDCH0oCjJCZCmuZJS+r4MZZk+AQ
         l44odGERbLI58w1x4tbjnS1Tanzn+4nng7O+ntdbFCqZ/41N1SUoMN3xRz06Osucpag9
         XeGSszrymD49rEvRp86f43oSxrEHrTPvPCAnmif3dF6iotCqWXRcuItJk6S3FCBZ06Hj
         TpOHU5nnhX4+O9dqTqyyyvignI4xPum+1SV8+ZBIcCGxx3HlhsTDV16+b+UTBmReiOZP
         B08w==
X-Gm-Message-State: AD7BkJLH9Dq+n5oJWWMr0s0oV04mSJCVVc+84WrdcGXwNmcdPYlcIxHrnACdvkqGZK7rgg==
X-Received: by 10.28.224.132 with SMTP id x126mr8989827wmg.88.1458477835352;
        Sun, 20 Mar 2016 05:43:55 -0700 (PDT)
Received: from ?IPv6:2001:470:26:389::4f7? ([2001:470:26:389::4f7])
        by smtp.googlemail.com with ESMTPSA id a16sm7685973wmi.0.2016.03.20.05.43.53
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2016 05:43:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289349>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--42Aana4tptMCchGdsB8KiGblSD3JHkCbs
Content-Type: multipart/mixed; boundary="MrSg7xIlW0kq7eOnMplGUcHoaA0uspR1V"
From: Georg Pichler <georg.pichler@gmail.com>
To: git@vger.kernel.org
Message-ID: <56EE9B09.6040700@gmail.com>
Subject: git diff --exit-code does not honour textconv setting

--MrSg7xIlW0kq7eOnMplGUcHoaA0uspR1V
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I realized that "git diff --exit-code" does not honour textconv settings.=

Maybe this behaviour is desired. It can be partially circumvented by usin=
g the "-b" flag if one does not care about whitespace changes.
To reproduce this, create an empty repository and run the following comma=
nds:

(I was using git version 2.7.3)

$ git config --add diff.void.textconv test
$ echo "foo diff=3Dvoid" >.gitattributes
$ echo foo >foo
$ git add . && git commit -m "Init"
[master (root-commit) 70c39d9] Init
2 files changed, 2 insertions(+)
create mode 100644 .gitattributes
create mode 100644 foo
$ echo bar >foo
$ git status
On branch master
Changes not staged for commit:
(use "git add <file>..." to update what will be committed)
(use "git checkout -- <file>..." to discard changes in working directory)=


modified: foo

no changes added to commit (use "git add" and/or "git commit -a")
$ git diff
$ git diff --exit-code
[exits with 1, no output]
$ git diff --exit-code -b
[exits with 0, no output]

The "test" command is used as it does not generate any output on stdout.

I would expect "git diff --exit-code" to return with exit code 0. If this=
 is not desired, it should be clearly stated in the man page,
that "--exit-code" does not honour the textconv setting, except if "-b" i=
s given. Currently this is not clear:

       --exit-code
           Make the program exit with codes similar to diff(1). That is, =
it exits
           with 1 if there were differences and 0 means no differences.

Best,
Georg Pichler


--MrSg7xIlW0kq7eOnMplGUcHoaA0uspR1V--

--42Aana4tptMCchGdsB8KiGblSD3JHkCbs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7psJAAoJELmwOFoHsuDqkT8P/j9OneC8IrDcpCVrQjwzSneN
myfJMFvCNqjzJRz0h1Uidc8PL9mbr0w/CU0iQYP4Q7aH2ULSVyLQunioHQ+wmA+s
VC8Vkc0zSaCzrO/Pjp286OqVoSsu4bTsMdnM9szHl1Tiq1V/Epg0/7p4mJEd29an
yVdljDHy5o8aBtB5Cz0iN65KmanMaQLvRfLLnGII/g+Gd6kMqfEaof+qZtJWdGjr
1gVy3/wMsT8Mj2N3dBdgtdbp8W95uxIgzX7Mfp3uA1AezH3wxl9SPAZr7Nd3ws3E
Atsefek9QdRxq+nCLHB+igRSentUI7wvF5hpgePcdWGEtac9sM6FBeIc2o89/MZO
zXqSKnlwm+7/gFZqOuh1oPPGYM1LShHQNACSRw52nm/8LRIHKxn0ESZ5iywOlCLq
3/3hOfPnJdRdzQR3FqrJcmigHpqfUzfiOrl7yKkvPp4jN9xEalT98WHPDhGoFuWv
oUEfvyBSvgMkh/acqY/Deh9RKK6j6XPPJE0KctIwYMqjB0ibeSO17qEjMKRUBMVF
10OSHtS2ERGGKaqdCfa3n7p9fhVRbRuIrF8wQd2cbatyPPff4/JfB66Ecw3KKvrg
nDg8MPc+1yvfbhGnWBR3sU/+tzyDd2OJxEFz6A8OmnpNSE+Sqob15trfgaVOc2C0
VqGocStRUuHUGnRwto2Z
=p+53
-----END PGP SIGNATURE-----

--42Aana4tptMCchGdsB8KiGblSD3JHkCbs--
