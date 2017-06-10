Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB1A1F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 01:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbdFJBoN (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 21:44:13 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33002 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbdFJBoM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 21:44:12 -0400
Received: by mail-pf0-f176.google.com with SMTP id 83so33716162pfr.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 18:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Yw5XaxdNRpqQrQVjGwFP4ZAGSDbiBvmi7YVcd3s2GP8=;
        b=UXnTXxk81wbPR5uedlG9UJUAhyJTZqQv9Wrjwu+dJV3iZNryNTYNnfLRyYY5nCwAOS
         nEKCVxtAQ155RqEoHePhC5atRGaeDb3s6QvAKYWPrZdvMQ0YxG8z8dJo8UquxuCV4to1
         Nynek41Y4Xd9doH/6957Miem2D4f+AFBUlMEpd3DXMmKspvpb6HH92+l3gAJwe9MwFIY
         Xfnu1kwQHj3zsSprRuoki+N9t4jILZJukMgYfOrxjzOtysvT7Fb4Didz2678npU7pL0S
         5fwNU3LaAQC65CDyQ5niWrau91YfU4stgeDm8bCQahznlPcmPfWecuDPYN8qIv1NN3uC
         Iwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Yw5XaxdNRpqQrQVjGwFP4ZAGSDbiBvmi7YVcd3s2GP8=;
        b=geXmpsap1REiBi1kPdxMNSSssA/RMSXyFbEhF77Ah1ULlsG8tV8+cG4pu/7JNE7B1Z
         K2yu34DgjwBTOy4e65K1x86BjI7hHTZ48ZodtyN/+uNhKn0wo0Rj26CKMhb/DKNFmD4S
         fL9c9fdVy2W1ivlAnpStRFYZ6bBz2AIs61y23b6Urzu2ZehQgCAcGmDlcZlfer1dDh3u
         Y4xcTwpQjzuRIW9SmMKpj8BesHtjdnUALcPkBFLrcWFJDePgXQUOflSQ2WVDHU3CqRig
         hWMEGJjyGCVqpARITenza4Mraf/Vuhd+Wyh3R2/Q6tkEwmHUgM49BLTD/iJ59GPnw6+8
         QqWg==
X-Gm-Message-State: AODbwcBYbwmKeoHI2aA0FZSXIgb1XRyZwGjx2fFzbxsxc7F8fFADUITx
        yE7awLGX1IwSWQ==
X-Received: by 10.99.95.194 with SMTP id t185mr20393637pgb.19.1497059052226;
        Fri, 09 Jun 2017 18:44:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id r5sm4138984pfe.94.2017.06.09.18.44.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 18:44:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
References: <20170609142151.94811-1-larsxschneider@gmail.com>
        <CACBZZX7O9DgLGOHKhojZRi7n=j3X0W9B_sRGLi6cBpc74GLyeg@mail.gmail.com>
Date:   Sat, 10 Jun 2017 10:44:10 +0900
In-Reply-To: <CACBZZX7O9DgLGOHKhojZRi7n=j3X0W9B_sRGLi6cBpc74GLyeg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 9 Jun
 2017 18:18:13
        +0200")
Message-ID: <xmqqy3t04nx1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Jun 9, 2017 at 4:21 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
> ...
>> I am perfectly aware that adding a ".github" directory in the Git core
>> tree is ugly. However, I believe the benefits ("well informed new
>> contributors") outweigh the injury.

I do not particulary see ".github" as an injury, and we already
carry .travis.yml in our tree ;-)

I agree with Ævar that mentioning the submitgit service would make
this even more helpful.
