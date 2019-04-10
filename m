Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3898220248
	for <e@80x24.org>; Wed, 10 Apr 2019 21:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfDJV4v (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 17:56:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:42333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfDJV4v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 17:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554933406;
        bh=CMH8rU4AixUqbMEZtq3oAu4w2hksUjWx0i2Cle3w1sw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=evTNdS59d7qfzfIWhQIgZnRo1KSwGSvRVwU/Lqxca1rgIZsJ0cio8OAldnEqiK7Ri
         0z5Q/sccCHTbV3YZ3mfNmgrdRCWiDXRpypDt12F1fP9wvD2elpDBAaKRpFKsEKWGnq
         az6bYUF2Q4G/PZygCuarxEgR49MGZMN13GAc4Ou4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5tU1-1gzJQN2rw9-00xpmn; Wed, 10
 Apr 2019 23:56:46 +0200
Date:   Wed, 10 Apr 2019 23:56:47 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: dl/warn-tagging-a-tag, was Re: What's cooking in git.git (Apr 2019,
 #02; Wed, 10)
In-Reply-To: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904102354510.41@tvgsbejvaqbjf.bet>
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:V/h9rapuvD1HI2SyRgrJh5eP079U45aENT8+XakiZDJsUwCrwVX
 w8RJsSQOsnixiaetIPfcGFDw+BcTlrTrGJyemghadXUWr1koKc/GphLBOI6hkWHynM9e3eC
 jHpWQpNhSU1TMtYyy9TH2l4NmUKL0G+K1yZ+1ECs35D3od5bP3YX0otyqVnx22bsQ1Zl7R+
 7b1sklLhSeC2VbrSmIZnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3aHzyhtj4X0=:E49ju1IY6h6B+rMHydXo9J
 nE2tJ2wZBQxykQrBRSbnwQfV4Qg7DULiKKl8JRqorvGN1UZbzpuRoUAUSz+rC2Wp8jPjy7pu+
 4blgqq5izl1I+Om/K5ohPLLSJyYIivR2Uw95KYd5fU2XNl+awhFLJYeqazl3uv9o0xSuNDbyp
 Tyd+HlXd/eVRtwRFxnCq/VdfY1sYr7KhqUhBphd2/1QPu6e6gKqsENqasMPJkNQvMhv3MGKei
 QB7vylhPB0VD7NC7BJ0yI49+uG5l5AwRQp3NJpSccv4+OzFJffMEGhpZejSwMHWJgippaTcjI
 jWwbmXVzq0FN9/WkVbZg2LP1puGEX6WI+X9vqrUDFqeTuoacVwku7AvN61vc2ceL+N4KOVAzD
 T5PYG1IlW5S0rkMZXHhHzU5kY7uj2x293/Dl2hLBRN7PvepB2EVm8nTGAMfgI7h9wICe5JKt6
 TJn3y6BnYeuMh+B2sVJrF5mh2iRF2s+PaVcmNDaWHHX7V5zmm1p+UTNetkis+wQc1fYqH1tLP
 ix4h0eN3FwGorJ+6QwR+glmSFMLCZBQPzmYYxQr6sOyNOWBjvYI+BUSqYTT7qiWjHN9ESoxnl
 GD8yqKMqQS0r5QrASsY82cFRf7zJdiZKjERdjAxBjvS79zIjtUbd0til9W5GRRuERmG/wPO7g
 MsQnYhmZPL2O51xPcAJHEx3KQ71rG1PwE8cq0uLOdGOKXIHqSVjWqQem1dvDCRakjMUahmkTb
 haIuJ7ydAcLoxXBEljaLk5WWdexyzwsEljJEG5W4PNFX99AH6pD7iwmcOhu/9TFTlknBZir1Z
 u8ICDzLAq5Cynhgx7i7FnUjMN6s3/KvrtN+XJf/zYhAqSJ8IaNThtDaPpVudq0hp8ntCEtQgY
 ArukHo+OfPNrjMyhfYHhqvS2cMgf0JYSYgkXoHgAc7jaY7aZkwlB76W90B+6GFNnlB8C7Y+gN
 Bcw2CUnpylw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Apr 2019, Junio C Hamano wrote:

> * dl/warn-tagging-a-tag (2019-04-09) 2 commits
>  - tag: advise on nested tags
>  - tag: fix formatting
>
>  "git tag" learned to give an advice suggesting it might be a
>  mistake when creating an annotated or signed tag that points at
>  another tag.
>
>  Will merge to 'next'.

For me, this does not work without this squashed in:

=2D- snipsnap --
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 33a1d70b434d..7767cb1fab64 100755
=2D-- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1688,7 +1688,7 @@ test_expect_success '--points-at finds annotated tag=
s of tags' '
 '

 test_expect_success 'recursive tagging should give advice' '
-	sed -e 's/|$//' <<-EOF >expect &&
+	sed -e "s/|$//" <<-EOF >expect &&
 	hint: You have created a nested tag. The object referred to by your new =
is
 	hint: already a tag. If you meant to tag the object that it points to, u=
se:
 	hint: |

