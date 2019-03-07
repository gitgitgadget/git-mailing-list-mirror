Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB54920248
	for <e@80x24.org>; Thu,  7 Mar 2019 21:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfCGVZ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 16:25:29 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:34593 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCGVZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 16:25:29 -0500
Received: by mail-vs1-f41.google.com with SMTP id h7so5427149vsl.1
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 13:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9Q3WCMLWEYEe+pMZKdRKhdPsIBLIbg+TMEchmNiSa1M=;
        b=nj0r8wwnnogAGXq+aZ5kUn8I/Ak/lcNSRELSmsoec8XeKl4zwDTYnE64sgqCcfDB9W
         cJBz0axG+s5kRQzdYkXDzlfflk5cEM7/apdgEvbrels9Vcvt+DcKarJziOvYedeokSge
         hFlmLCq+pJcNETjeGWVegE3grV4KhF8MkM1YwPswwlGHAyj9a2ofmsSH9SCHfhuCqvXR
         K73pbuPTySTWLUXZBEie9nXmdwpR7SFlKHARmCvsyCdbAkiJuGDGsIYdIazD81zsPO2V
         HB0ZN/6c0b4zRVlAvrikatfqCOX5EcihqKx4aO89rD6dax7/xyxgRWcGAhnVXnfO6OJT
         BtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9Q3WCMLWEYEe+pMZKdRKhdPsIBLIbg+TMEchmNiSa1M=;
        b=BEyYlZeJ352q+hD5PNKQiI3HomN6ZHdtwPR9u5eeMqI+3do9Z8TZn0utLqtDhepWXF
         l1WiZ2p83GuLHNqn9IIWP21u16hBSz+YzAmYzAhCLwJ4DGHOh1AAVNsBfo+KTF/oB2D0
         /qjYbVIj/pmn4DxS16y8wF7nGmmklKPnEWFXV0dtB6NORCVblNHE5T8NiqMHtzphKD5t
         Io+6FRhzSfM8v9sa/fQ6UdfbnOL3kd/o2M6Us0MpPJK+UF/FETx2WCTJfxFbG9N5qkCw
         obg9PjDvsi1q8mQI5yzdQgMU7UbPxMo5wEr9d6cAvkGlLx5YIy4vt4nlJ8149fXuetCW
         Q9+w==
X-Gm-Message-State: APjAAAWisAEKT2OqFn6Yqvsh1YMn1Y+Pr/knLqstdC+7pnbdtd4UOVN/
        bWAv1aXtL9Wpk1nrar2RH9UkjpQzE48Pyg270Txp9e1Y
X-Google-Smtp-Source: APXvYqz+DLTdBCHeNqhRX44BmITSvULpHIT5YZ7Z94gNq15QUh43KxBpnsWwpayHTDYI6V8ITcRQDfD2dqdIrPz1ZlU=
X-Received: by 2002:a67:d91e:: with SMTP id t30mr8539624vsj.27.1551993928269;
 Thu, 07 Mar 2019 13:25:28 -0800 (PST)
MIME-Version: 1.0
References: <CANNTdjSRB+_1Ue6LLxMcAdLmdg5TrihZ4CeZhvnpgwnEP=SQ3A@mail.gmail.com>
In-Reply-To: <CANNTdjSRB+_1Ue6LLxMcAdLmdg5TrihZ4CeZhvnpgwnEP=SQ3A@mail.gmail.com>
From:   Adrian Godong <adrian.godong@gmail.com>
Date:   Thu, 7 Mar 2019 13:24:52 -0800
Message-ID: <CANNTdjSdTiNcM+UzF+2ZH_2JOyDZM0E6RFCDwsT3Y7F=G7YdOA@mail.gmail.com>
Subject: Re: git reset error on Windows
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Windows 10, git version 2.21.0.windows.1

git reset tries to delete folder when last file is removed but failed
to do so if shell is in the deleted folder.

Repro steps (powershell):
mkdir test
cd test
git init
mkdir dir
cd dir
add-content .\file ""
git add .
git commit -m "1"
git mv .\file .\file2
git commit -m "2"
git reset --hard HEAD^
> Deletion of directory 'dir' failed. Should I try again? (y/n)

Choosing y will repeat the same prompt. Choosing n will complete the
operation correctly.

-- 
Adrian Godong
adrian.godong@gmail.com
