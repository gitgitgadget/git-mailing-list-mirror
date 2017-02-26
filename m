Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7B11F5FB
	for <e@80x24.org>; Sun, 26 Feb 2017 12:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbdBZMBB (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 07:01:01 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34770 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbdBZMA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 07:00:59 -0500
Received: by mail-qk0-f178.google.com with SMTP id s186so62321132qkb.1
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 04:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oejtEKtDVLS6H9hV5UqG/ToLZxTMdD4hUSUZAXXFti4=;
        b=R9d9hyzs4zWVZ6tUkuG09G6kqieEgFGAys49dG5phUhRaU98ayNX0n0lc4t+ISSQ1F
         DL1KEnL87JSTwCNI6OMtBXzgL9ERfO6lxBuQrEryldY2ntiYmtKPpHnRDWe63Nxy+3kE
         gVkIoixAOBiqCLZU/LYLroyH34ZzcLZYuhfthGg/SPPJY/EhJd2ou9XKRKAbesJHZxTu
         YfrOMayVqVMU8IVuhs9Wi6MuHuVxEBcmDIqoAxDASVNBYovlntAmyes973j3MSNIWly/
         88752f7ISbQrkM4z5GqzlCNPwcGkPBo388ifmY4MlpGvarPf+THoWsizLVk5Yqq7kGy/
         hI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oejtEKtDVLS6H9hV5UqG/ToLZxTMdD4hUSUZAXXFti4=;
        b=cGVvqb4OqCSMcJL4VYuCa/VanoZ67n/VfzAasjh2jn7GL2GSFd/7IqhmpllyJ5imSO
         Jk3qb9F0mHLl3TS/GhOyZE7VlayfYtuDHNKOaGfHRMR5hIcGmA/k10/PyACo+jLC0f3O
         9MKRDrbco2ZwUBmbVJB3zPWTcMHIymZMWSRDUcza6uEpC10uIQNKQCHeAh6x9UkDTAsG
         Rsk/6ArElCgFz585tHBeM+zwHPHzdMve5FCRaZMyy69jhNaS2ztLC1c7irod2RrxznH2
         YGrMSw4WmTDtDC8BrRiHzs8wc+DhR9ySErqE0e8YGrPGMP4uAuCmKVivL2kX7jFPVCI4
         pPBg==
X-Gm-Message-State: AMke39lCXR2x/2Mz5cR9PBXibtnJDLE7hSU+j5UysSvleG2ahfHinafONXdrOSyetfQREYFJegQX/MFyfIDqlg==
X-Received: by 10.237.51.167 with SMTP id v36mr11710982qtd.272.1488109947774;
 Sun, 26 Feb 2017 03:52:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.218 with HTTP; Sun, 26 Feb 2017 03:51:57 -0800 (PST)
From:   ankostis <ankostis@gmail.com>
Date:   Sun, 26 Feb 2017 12:51:57 +0100
Message-ID: <CA+dhYEWV4TWp_-sVoGCK-r14JSKsS3_Q7tfwjmowRr5V_F7BZA@mail.gmail.com>
Subject: Unconventional roles of git
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jason Cooper <git@lakedaemon.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26 February 2017 at 02:13, Jason Cooper <git@lakedaemon.net> wrote:
> As someone looking to deploy (and having previously deployed) git in
> unconventional roles, I'd like to add ...

We are developing a distributed storage for type approval files regarding all
vehicles registered in Europe.[1]  To ensure integrity even after 10 or 30
years, the hash of a commit of these files (as contained in a tag) are
to be printed on the the paper certificates.

- Can you provide some hints for other similar unconventional roles of git?
- Any other comment on the above usage of git are welcomed.

Kind Regards,
  Kostis Anagnostopoulos

[1] https://co2mpas.io
