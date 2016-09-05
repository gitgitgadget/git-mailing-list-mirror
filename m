Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECC551FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 17:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936391AbcIERQ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 13:16:27 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35273 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938761AbcIERQV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 13:16:21 -0400
Received: by mail-pa0-f67.google.com with SMTP id pp5so3165199pac.2
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:cc:references:in-reply-to:subject:date
         :mime-version:content-transfer-encoding:importance;
        bh=he8I2i9kmFE5XkEffJIA5LflM38sHbUWAJtdA4XxHBw=;
        b=WDQ9y9ha+p989HSaGUEzxtQlIh/V7cspntqMx8+eaW9hiYbJ6fd3kfdHoht0kegcDI
         QJutbmBJFLOshB5N3j8apJkDuSG0olTIMi0Dm4CKGu7YR1GYWjKZ+FFsLn6IDHQYUp1F
         gxg96OsTjHMD8MekGXq8UgjM0LTDx7ew3QmeMCeIcYAIGBdfDO0e5/EC/snUTAlKQEZ4
         X9Sz4G7Balokyg7GgIJrikfBcMgwnl3eh5oDrWJEXV3v0lTUQD6mIRaiKBzg+c4YShC9
         2d8pJz6QBwvQRqjyA4DZ8cqDwSePwFQF+aVJSSr4isN8xnhM69QSscyZXZUItc4FAM6S
         bwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:from:to:cc:references:in-reply-to
         :subject:date:mime-version:content-transfer-encoding:importance;
        bh=he8I2i9kmFE5XkEffJIA5LflM38sHbUWAJtdA4XxHBw=;
        b=euVqCMhDJCwBhh5Vz/ptYn/+byHC5P6bOf7bAtKt9cuPKL2JX6fcq9s32eRArwsZoH
         HGYRL4krK6RCnhF4RbWtfVAp3N4haYEUS6i8oU9uxfFUJlomLLzaKEON3GhTJJu08Vi+
         cQpR8f2HaTPutz4sRKnQHMsiwqSVlRuhIHb9rUv/eK+HEscoQvl95MbqXqvukO/nYJ6B
         cALTBN31w3dJFSRbCnVdoZFjYRMAR8binGiPlDdLMV7iTnBIOgU1DCDqBEiFTTRmNgJ0
         CYxleAYLD+TjNV4QiPgpv7kRCgwmlwTvwQYw54ItYRKIx5p9uiapvY8dw9QkzA6MNT9P
         MUrg==
X-Gm-Message-State: AE9vXwPtcjr7R2tq0I90zmSuAoEQtHEqd0FAhouuyWDDN21EloyevPcPvcX67tYdhIDyIg==
X-Received: by 10.66.189.104 with SMTP id gh8mr64925381pac.125.1473095780887;
        Mon, 05 Sep 2016 10:16:20 -0700 (PDT)
Received: from Yasushima (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id e187sm26498630pfa.58.2016.09.05.10.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 10:16:19 -0700 (PDT)
Message-ID: <DD45D15018014CB483E07425A5E4072E@Yasushima>
From:   "Satoshi Yasushima" <s.yasushima@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     <git@vger.kernel.org>,
        "Pat Thoyts" <patthoyts@users.sourceforge.net>
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com> <32ec2698-7730-a088-6a76-ec6f2d379987@gmail.com>
In-Reply-To: <32ec2698-7730-a088-6a76-ec6f2d379987@gmail.com>
Subject: Re: [PATCH 1/6] git-gui: The term unified for remote in Japanese
Date:   Tue, 6 Sep 2016 02:16:07 +0900
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3564.1216
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3564.1216
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 4 Sep 2016 14:10:45 +0200 Jakub Narębski wrote:
1>>  msgid "Tracking branch %s is not a branch in the remote repository."
2>> -msgstr "トラッキング・ブランチ %s は遠隔リポジトリのブランチではありません。"
3>> +msgstr ""
4>
5>What for is the above part of change (empty string)?
6>
7>> +"トラッキング・ブランチ %s はリモートリポジトリのブランチではありません。"

I had been changed for "remote" from line 2 to line 7 above.
And previously apply msgmerge because I hope this change will not change again finaly apply msgmerge.
When July with MSYS2.

But now, doesn't make empty string by apply msgmerge this commit.
I will remake this patch. 

