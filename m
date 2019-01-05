Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03E9C211B4
	for <e@80x24.org>; Sat,  5 Jan 2019 21:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfAEVpZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 16:45:25 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:38234 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfAEVpY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 16:45:24 -0500
Received: by mail-it1-f174.google.com with SMTP id h65so5794012ith.3
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 13:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIv58Qb2+2wG0w6tDRbHV+Ls1BuQhd56MfL8DO2AiG8=;
        b=FmBtUpELep4s1RltSmz2tSzTmwdG7ewjsf+cLVGWfHGk6ERVAdMCuR1CVvBG+YC7F3
         k/4YX8hspaSq9w/Kg36jQUjNKISq3PfjS5gQfvirRVO3UcNPZSMPbWoR/Pxme6fjQwLw
         kS9G/wXaQCjog2GHLIIHN8z2vbPqskRQzOxYlG8WgE799BhcS3mqfC26H53aNcl4NVtT
         YuJj3ChNmAwZGJfAmpMmGHV/u4UCAQYDmAH2+jlqgxdiEwnx/cIdQW33IMjmGWhWIkE6
         9xEujJupC0hN2nWx59ICd1Co/9czfxoCM04XAjUZH4vc9fJRL1QHCxHjYUdx3Yp4Qf+c
         hd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIv58Qb2+2wG0w6tDRbHV+Ls1BuQhd56MfL8DO2AiG8=;
        b=sXQrBI48SJdmpiwaJZP4IhzyKHHErnVYobS6uwSFa1/jgr28bwYUv+2hzPhLu+Xyx6
         3oyvb3DxdfFWrWDWhajLlGPv3SmLhpaEippbhjiAuOhAsxj6wdIozoF9n2thnbxIBiKW
         AdIcxd1eTwDYX8CXuLU9Fy3BlmLOjwEWB9NJkEXaSdBXGyR7+xhDZeE3eR5QANE6JGev
         1rrNZcQUd2idKBQrQ3QuBdwhs9/o+wyoR/6eLxbpbuGNf7asHtDHLDJ6kETsPog2cXoJ
         v1ctIBkLsgaCIszOJZU+ptBWTcumrrI2AiZxBIy0KLnrBe+QuRJBGyB5JDtqCA4SjWC6
         w7vA==
X-Gm-Message-State: AJcUukfq3KDFq3EbztaUkQTy2ABjmuxETFXQJmAtbSh4DJF9Hs25AzrP
        BglTIq9jsEdipKHf3FLAxGxP7H3EAji4z9IJtW8=
X-Google-Smtp-Source: ALg8bN4Dy71+kmUhAnO4D2J7nWQnjNq8rJ+CzQ8pulBhImX9G17VoXspzt/3feYN4AuGSregw/VCVThCVkAftKpvV/s=
X-Received: by 2002:a24:e40d:: with SMTP id o13mr4379387ith.152.1546724723796;
 Sat, 05 Jan 2019 13:45:23 -0800 (PST)
MIME-Version: 1.0
References: <951cafaa-877b-4815-862f-5ffc43e6976a@googlegroups.com> <1413fbaa-8a83-0f43-afcb-5cb67683b505@iee.org>
In-Reply-To: <1413fbaa-8a83-0f43-afcb-5cb67683b505@iee.org>
From:   Daniel Fanjul <daniel.fanjul.alcuten@gmail.com>
Date:   Sat, 5 Jan 2019 22:44:47 +0100
Message-ID: <CAPktr3k6GmYkTE9=0jcs8+4BEeeAnvQa6daxnwcqTwrL91Y-ug@mail.gmail.com>
Subject: Re: [git-users] git checkout file with custom mtime
To:     git-users@googlegroups.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm on Ubuntu. I do not use LFS. I track mods and saved games of
Skyrim with git, TESV.exe sorts the saved games only by their mtime. I
know it is not the most usual use case for git.

I agree with that viewpoint and I like the way git works right now, I
do not want to change that. Checking out the saved games and then
fixing the mtime works but forces a lot of unneeded I/O.

I forgot to mention that 'git update-index --assume-unchanged' does
not solve this well enough. Eventually 'git status' rereads the file
when that flag is removed. A better way for my use case would be being
able to set the proper mtime without forcing a rehash of the file that
yields the same object.

Thanks for your reply.
