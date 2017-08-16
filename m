Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5181F667
	for <e@80x24.org>; Wed, 16 Aug 2017 12:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbdHPMY7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 08:24:59 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34549 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbdHPMY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 08:24:58 -0400
Received: by mail-wr0-f195.google.com with SMTP id x43so2784627wrb.1
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=L1hEEH/+c1wKbs+KeEUdXZTmY9Y5a0NfjL3qwaz+gnc=;
        b=D5f3MGefmRLVyONtq4XvpG/s3zUTKuqa1UIc0SMd+kPzlHE/5UEKI4KG9zz1EbZ7P3
         CsZlCHptXySeajz+dD096Yxwh+1+9mwapFy8zfVrLIIA23RgaUthsZKd4SSCLKNVomvI
         mYDOWADYfyEExjxcrVD1H+jlpZsS47H8F8+d429IRvMg2TnWiPaqBK0QQ2Dl3x+aEXBo
         F7kvMFG1ozIqsavNd24u1LkUvLBYKtxSsjJYQh0LfJrifLsEr3a+CyFhPRwsLhZUdgA+
         soqE1tysA4+/svnEFWnWNJcPzGIaPnIk/boFrbcg/P5998a6ZZPNG79DOto+4tpjF7Zk
         t2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=L1hEEH/+c1wKbs+KeEUdXZTmY9Y5a0NfjL3qwaz+gnc=;
        b=H3y3fJMnK+QlnbM0aO+6t6rSO2T2apiF2titb3+YDuz7Sy5FMF5WQ5CUJ2t+5BvAfG
         9EWUSMV5iXvlQ/q68hBGgayJ3/jz0yMVmzenKkSDsmKngPAvB+XZzAvCRoBZGjyF9UnN
         uHX+BcauHU7NS6L9rHmMvwIb+P+8l/2fYXaYRf7F+jlt9eLSpX56164jGzYPwPGN56MB
         vXFGAkuUhOHV3fq5LN00X12CH/Iu1cQ7Q2DN749yMjnSI8saM8CFMhiWmbMH4kJYpS8M
         xoufm++IcY7riGcBegZnavBLzdFjLvKNTwXKPTyPuaM/etwrYLWUlffTvNEynE2Q+uJO
         sv/g==
X-Gm-Message-State: AHYfb5hmBIY7KfNiyxUIBFHAzPiAI1+V1IcWL6XP4TZimSjh1kp3r9uS
        Lh4OEhZywkGmlrmXYqk/UnRxhB/64Q==
X-Received: by 10.28.107.144 with SMTP id a16mr1054725wmi.178.1502886297605;
 Wed, 16 Aug 2017 05:24:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.24.130 with HTTP; Wed, 16 Aug 2017 05:24:27 -0700 (PDT)
In-Reply-To: <CAGZ79kaCtbuDEUJqJ+nVUW78ksLMyHZ2xhnbunUqzjkGRuYg+A@mail.gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com> <b5633a5425c623f3d2204325e99332b5bb511582.1502796628.git.patryk.obara@gmail.com>
 <CAGZ79kaCtbuDEUJqJ+nVUW78ksLMyHZ2xhnbunUqzjkGRuYg+A@mail.gmail.com>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Wed, 16 Aug 2017 14:24:27 +0200
X-Google-Sender-Auth: 6QyYLtjkXdhnCICkxHiIbn_GL70
Message-ID: <CAJfL8+QreNvRqVZ0t1Sw=+o4nFK6WuvuOWix_C0MNFik6Cc+rA@mail.gmail.com>
Subject: Re: [PATCH 3/5] commit: replace the raw buffer with strbuf in read_graft_line
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 7:02 PM, Stefan Beller <sbeller@google.com> wrote:
>>         const int entry_size =3D GIT_SHA1_HEXSZ + 1;
>
> outside the scope of this patch:
> Is GIT_SHA1_HEXSZ or GIT_MAX_HEXSZ the right call here?

I think neither one. In my opinion, this code should not be so closely
coupled to hash parsing code - it should be tasked with parsing
whitespace separated list of commit ids without relying on specific
commit id length or format.

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
