Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C70EF1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 08:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfJaI2J (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 04:28:09 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:23976 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJaI2I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 04:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1572510483;
        s=strato-dkim-0002; d=aepfle.de;
        h=Message-ID:Subject:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=BSgS+NBJRuxzI3o+xB6LCAm7KmEphVQz4dmt5Fab5SA=;
        b=Hxvn7d1l7vA+MHjgqPxbs1+8Gu+9sBjOluQFaAt4Z60QrtP+Uz2Ly0mCyKDhvWApQS
        tGRmZNYbIZIqJTVeMwCHfeHPDf36M0ceVMGgiNmO4FCHfV4f3kIH+zYA9GBKB9ruV44a
        39cRV6q3PKtuEh2aEaJGge/kUa0aPs+P5dhkZB95p+wJX+yNJwOMESLVsJiR/+WOvpEi
        a1Zj9k1VXFcA5H/eaciNvZFJx82Dnc3OwKZVV0sB0ieo0DQaTlr64YMW7aqljS0iQbSl
        DzymakP+ihV70rb5qWJJUU0FbVK/SsKoE8qCmJoN4+2C6VTR+9TrJbMm7PaKdP7doZ2I
        xwzw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4kV1cX92EW4mFvNjTRB"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id 20735bv9V8S39Qc
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate)
        for <git@vger.kernel.org>;
        Thu, 31 Oct 2019 09:28:03 +0100 (CET)
Date:   Thu, 31 Oct 2019 09:27:49 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     git@vger.kernel.org
Subject: git fsck, badDate: invalid author/committer line - bad date
Message-ID: <20191031092749.074ed112.olaf@aepfle.de>
X-Mailer: Claws Mail 2019.05.18 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/muRiLVKiBrcrkStc=q2BLQA"; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/muRiLVKiBrcrkStc=q2BLQA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

While preparing changes for git://git.annexia.org/virt-top.git, git push to=
 github complains:

remote: error: object c609265ccce27a902b850f5d62e6628710ee2928: badDate: in=
valid author/committer line - bad date

Also 'git fsck' is unhappy about a number of commits.

What is wrong with these commits, and how can the maintainer of virt-top.gi=
t repository fix his repo?

$  git  --no-pager  log -p -M --stat --pretty=3Dfuller c609265ccce27a902b85=
0f5d62e6628710ee2928^! | head
commit c609265ccce27a902b850f5d62e6628710ee2928
Author:     Richard W.M. Jones <rjones@redhat.com>
AuthorDate: Mon Oct 5 11:39:28 2009 +0100
Commit:     Richard W.M. Jones <rjones@redhat.com>
CommitDate: Mon Oct 5 11:39:28 2009 +0100

Olaf

--Sig_/muRiLVKiBrcrkStc=q2BLQA
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl26mwUACgkQ86SN7mm1
DoCnDRAAipJ+8RJHpKMZCOLQWo2S8Y7Ig2K5WLZzbrtNYmCCl73kONawZPqQHfZb
smdGxnWFqOu9T8vg32QX97fyuQkWsNBeKLyWORezB4tLSsBDqv59sRyvJySiTdrF
8Ywu20CmdU/+dUKD9ZVt9XfqUx2NIg02cee/EN4QM5CgILyNd2y+ICr7tbheKsUf
MO7aa59KJ9Fw9CSOG5+TRYrtFOqUitlMnf16xHf0f7nVfQ4kE4BPGiRNNS26mmfa
c8U2Iu4mclMvb9TLZbJ1Nv7sTCJDBgN0a8ik9WnNH2O/1bKVe8FzGMa8CWOJ6SOq
KCle/ELQrTMgBqsM7X/P3xyOFqd+RhDvZ8tO/TDZ0ODSehupHzICFH4Yg+9995Lf
KYZ//HLDA/MEz0r2rvPzTZXVVcw12XvjfVs9syqPl9mj4HTlw1+stQjVGYP6oT3r
+SeuqwhPPVxlBwQ+vPd7is4qnsAcUTDOqp4hCR/YFM8XchQiW0c/MkXhb86pLf83
bjeHEYaQ4MEl8wTumfy3rHIUT1UWhFaDidJXg+ty4tQAxWQi/WYfNgIRlvKZSiQW
LZ/VQmkIu1E5G+X7bDyVH4qRuAJ3/YbAhz0h9XoqI6ZosmDDSYmWfPBvZ4aVoM8t
72LbYlQqH7b8oUX0XZp+iKqd93cQ8JqwCTg+LAGPFICMm4CAm2E=
=YohF
-----END PGP SIGNATURE-----

--Sig_/muRiLVKiBrcrkStc=q2BLQA--
