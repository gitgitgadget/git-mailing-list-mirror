Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8B920970
	for <e@80x24.org>; Mon, 10 Apr 2017 10:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbdDJKdl (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 06:33:41 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34297 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbdDJKdj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 06:33:39 -0400
Received: by mail-io0-f181.google.com with SMTP id a103so24738795ioj.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rtkQ2XK0Ac/ypfxCQiNeyoZt68GB6hrNKDSBYISi7xk=;
        b=uGstf+P+qnrGU9o6y8MG3HPekjlWwKBjJBCSNtoOVtdTOuZJy56aHbvyQMT65ChjzE
         pxKn6r4EEWE/p6bSMR/+v6VzB69aQdZP6EHJCK/DWi0bDJ0HgshlfjIKSiJS/4RFUtBU
         lhYGCeHsucEBvDWsXK/ZukWf7ebl9obBvxjF9Jsq+phdhqBRvgSrg4cjbubfSLUiefpG
         9qo/YDFWgbMnCR1GO1H0hjj009NWFTjQHudAbiY7XFo5S3HmatRXTpcCMKorKIEjFUWB
         IRIz6fhZJbmBrff3u3rOWp4BLNTq5ipZpvD8DVETcWs12g39JBwiPxumOO1kcI4LokOF
         4ENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rtkQ2XK0Ac/ypfxCQiNeyoZt68GB6hrNKDSBYISi7xk=;
        b=bltdAQaLb+Hv9CiHPWTFFVer11HiGFpkCoWZvQn8Gmb2xOIqV5jve6Dcv7vjwYy6rW
         KrjSCBSLxlXaCsSp0ytSdejIGsszuKTSre60L6pCIOjI6GCUtuuhjRxvmd7UaSfiHN+s
         xoxtH7Tz0gX8dKhCqIeQynn4udhfoJpr31CVXGsedOQjK40syVs/tmeUm76jPmU8pWt5
         keFnn+DN+/85fpVBsz7sYOk2svUqWW6cYbT9DYtmtn59ZJek4utK7JAqBDL//dA+JDCM
         Zkxt8egJeTplcdEf2uu2PVTqIhUCG9bWfIzRRZxAhC6CUKoacxOXLKAG48dZ9uDBNjEW
         KVhQ==
X-Gm-Message-State: AN3rC/53rEelU6Qo3u664/MnCaFOh9uDKz0M2HswIm54ymzQXJ/NUpzYidIjRkBlpW3RHT8s6XcjuyxvuPzR3A==
X-Received: by 10.36.43.77 with SMTP id h74mr10994015ita.60.1491820418705;
 Mon, 10 Apr 2017 03:33:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 10 Apr 2017 03:33:18 -0700 (PDT)
In-Reply-To: <CAG_DJYk3D=sPm6rhGRD_wF4dnJqSU_M+c=NWP4Q5ExBap_-kPw@mail.gmail.com>
References: <CAG_DJYk3D=sPm6rhGRD_wF4dnJqSU_M+c=NWP4Q5ExBap_-kPw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 10 Apr 2017 12:33:18 +0200
Message-ID: <CACBZZX7aAHdrvH3wucoQYvZ26mNDYvo3ue4XR0TFF7BxBSWaxw@mail.gmail.com>
Subject: Re: Modifying a bare repo directly
To:     Julian Goacher <julian.goacher@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 12:09 PM, Julian Goacher
<julian.goacher@gmail.com> wrote:
> Hi -
>
> Is it possible to modify a bare repo directly? e.g. is it possible to
> insert a file into a bare repo without first cloning a non-bare copy?
> I'm thinking along the lines of a command or sequence of commands that
> modifies the file index and then copies the file blob into /objects,
> but in a situation where the new file exists separately from the
> target repo.

Yes you use the plumbing commands (see "man git", search for plumbing), e.g=
.:

git init --bare mybare.git
cd mybare.git
echo hello | git hash-object --stdin -w >obj
$ printf "100644 blob $(cat obj)\thello.txt\n" | git mktree
aaa96ced2d9a1c8e72c56b253a0e2fe78393feb7
$ git commit-tree -m "1st commit" aaa96ced2d9a1c8e72c56b253a0e2fe78393feb7
318448647ab7a2b1f78c87cb8a05ac0cf172fbb8
$ git show 318448647ab7a2b1f78c87cb8a05ac0cf172fbb8
commit 3184486
Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date:   Mon Apr 10 12:29:22 2017 +0200

    1st commit

diff --git a/hello.txt b/hello.txt
new file mode 100644
index 0000000..ce01362
--- /dev/null
+++ b/hello.txt
@@ -0,0 +1 @@
+hello
$ git update-ref refs/heads/master 318448647ab7a2b1f78c87cb8a05ac0cf172fbb8

Now when you clone this repo you'll have that one commit.
