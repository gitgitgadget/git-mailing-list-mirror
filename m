Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251DE1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 23:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbcKRXk0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 18:40:26 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33695 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752752AbcKRXkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 18:40:25 -0500
Received: by mail-wm0-f52.google.com with SMTP id c184so9499271wmd.0
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 15:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=gmMDAqKj2YkyEu1gI6zQfxZ/rytV+eGgpHP/WA54oBE=;
        b=e0Lh8keu21OgblqZnOKznpO5aj2ZfJo/hD/4xPf5E1cYg2imrj3aZ16IsKzZq04Y4f
         V4FQu/56pFrUP7e5euwkaQrJQgygRZNseNandsMl3vthRffjsJKx45t2263qcj7NgTTt
         Mi56e52T/CJNDRut6u0CRNwCGcHYerxO7nV2Vq2gFM3XN/ZPyWDm3GRufmyIJn6B70lh
         Tg7kw5rbf4pV1NkxCt3J3xH3ZWaI5Im2f+4nF8I2tS5ExRG7w+vrQJbESAbRAvD/VEA5
         Ru5xu4XzBSe3DodCOkRATq9BfpSP6jAezTBmBR0P71n6JQyh0rLJeniEZcwpQCLS7M5H
         VUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=gmMDAqKj2YkyEu1gI6zQfxZ/rytV+eGgpHP/WA54oBE=;
        b=hjrRTqeoQu18Yohoulno7hb7QRPk/uLdIk/Jrx8eTZfVpv8yVxjYsZHTrms4xArNdb
         sbTx2e2S+7g7y6nGGr70+Lbp4EJG+6uMm1+T9PERASdl266AtY3N3UgamBxhbewszCiv
         PHGwuVW1z03/3g7V0GSaJB0XUPOQcVd04pRj7sotPNRjMxjqXsmdL8tV7CI5htsVq97B
         i1Sl7JvEUYvpCsIQdbefIqsIi6dzqrpX5bspFxfGWcqVkZv7+df4L40AG1icSEk1kxOL
         jZ7LeOLkyP0DRkbBc5Keo+UQORoyThvu+kz2mYWcL2y00+VdFr8Z1KJpdlm/tckrd12g
         SDeQ==
X-Gm-Message-State: AKaTC02CAHdAWBOD9vQEoavARNnZFCpMf3eKvWfyxixiC2dMjO/WEM+reqMn1+zFFavPKHeMFaKNYAoZHx4GVg==
X-Received: by 10.25.29.8 with SMTP id d8mr548898lfd.18.1479512423570; Fri, 18
 Nov 2016 15:40:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.21.75 with HTTP; Fri, 18 Nov 2016 15:40:22 -0800 (PST)
In-Reply-To: <CAEYvigJ14xYDmRG2N0yTgM4spaaB7s9923w0+e9+QQEeFz0NTQ@mail.gmail.com>
References: <CAEYvigJ14xYDmRG2N0yTgM4spaaB7s9923w0+e9+QQEeFz0NTQ@mail.gmail.com>
From:   Matthieu S <matthieu.stigler@gmail.com>
Date:   Fri, 18 Nov 2016 15:40:22 -0800
Message-ID: <CAEYvigLz3muWD-QFjMZUn=H3RQoxhTYX9EwB6=aiMjWOEN3CBA@mail.gmail.com>
Subject: =?UTF-8?B?RndkOiBnaXQgZGlmZiB3aXRoIOKAnC0td29yZC1kaWZmLXJlZ2V44oCdIGV4dHJlbWVseQ==?=
        =?UTF-8?B?IHNsb3cgY29tcGFyZWQgdG8g4oCcLS13b3JkLWRpZmbigJ0/?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

When giving a custom regex to git diff --word-diff-regex= instead of
using the default --word-diff (which splits words on whitespace), git
slows down very considerably... I don't understand why such a speed
difference?

(this question was asked on stack overflow, but after two month
without answer, I'm asking it here instead. Post:
http://stackoverflow.com/questions/39027864/git-diff-with-word-diff-regex-extremely-slow-compared-to-word-diff).

Example (sorry, UNIX specific code): create two one-line files, and
two 200000-lines files:

echo aaa,bbb ,12,12,15 >file1.txt
echo aaa,bbb ,12,12,16 >file2.txt

awk '{for(i=0;i<200000;i++)print}' file1.txt > file1BIG.txt
awk '{for(i=0;i<200000;i++)print}' file2.txt > file2BIG.txt

Default --word-diff has no issues with the BIG files (cannot see time
difference):

git diff --word-diff file1.txt file2.txt
git diff --word-diff file1BIG.txt file2BIG.txt

Now use instead --word-diff-regex= argument (with regex from post:
http://stackoverflow.com/questions/10482773/also-use-comma-as-a-word-separator-in-diff
)

git diff --word-diff-regex=[^[:space:],] file1.txt file2.txt
git diff --word-diff-regex=[^[:space:],] file1BIG.txt file2BIG.txt

Why is the speed so different if one uses --word-diff instead of
--word-diff-regex= ? Is it just because my expression is (slightly)
more complex than the default one (split on period instead of only
whitespace) ? Or is it that the default word-diff is implemented
differently/more efficiently? How can I overcome this speed slowdown?

Thanks!!

Matthieu


PS: using git 2.7.4 on Ubuntu 16.04
