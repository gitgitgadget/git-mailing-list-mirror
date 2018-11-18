Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7881F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 17:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeKSDzH (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 22:55:07 -0500
Received: from mail-yw1-f42.google.com ([209.85.161.42]:39702 "EHLO
        mail-yw1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeKSDzH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 22:55:07 -0500
Received: by mail-yw1-f42.google.com with SMTP id v8-v6so12081850ywh.6
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 09:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3Zoo3J+KQkVd4CcdrQf1oFwEOGJygRmka7mfNIY0zgY=;
        b=OgyY/gTQygkl+Xy7umTMuXHcXySxuwntHZPucNMN2VTD+JTq+453RbwK6Jw30j5WvB
         PfiZ287g4a7ZQEzCnCSOC4zRZp2V8bOFL4cRs/hALHk96i2RPyTQ4FMeKaY6mVtRg/w4
         N7kSYBK+2+c8IM+ZT6QK8xMqlyPc/MWT386OlLG6Nsx67X9Du2OdpcH0DIqibvzPzhe0
         rrAefwmWtfy/u3qdJLbcWd9BcPqimrBy8uy/gu1hFzu3keR2sNhV6lKaJiUt7t+75fiT
         7HtpFY5/rOvNBvW1xCeEHKzuukhS4/bwoHLIUWLNKA5iSQUz8K6amEAgh7xXNRzWVLDG
         E3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Zoo3J+KQkVd4CcdrQf1oFwEOGJygRmka7mfNIY0zgY=;
        b=mDk8LcngZRPw/hMiycIPizh5MIIV87E5cJ+3aJPvZzN3IZdruaTmQDcmV/7Hvh9qvc
         otWSzk3RY5Gt4H20cgOMtqqVK2KnhWbpNVv/k99Z3hYSf7Bi0fqBnBF3QV1NkiJap6jf
         1lTfvfCbfr7ZPqSkZWHbVIHnf7TRi6pyJhDIO/NY9EXeBCfuv604kiZGFiNYvSRnhYdY
         Xsd6a5EQtDDkcflVuVhOvmA/VxiEbzMr+srC0MMJg1iPD/J7ojR1+dunOerhA/GHMYLU
         xL2MTuCGzh0/9JanQnAuSKz+bJSQhRSnIUxazsp54B5OS7p+aPNG8mChAdoA+2QlFTn6
         IqvA==
X-Gm-Message-State: AGRZ1gLSDROFXBHFDoTEO2rRXxUExN7IQnBY4wa2+SQrw+DDQM8wJ2/T
        UsVh9K0T3X7Yfm04yil5d8KnwCayPnQdEfEzeLLG7eiqpT8=
X-Google-Smtp-Source: AJdET5cgInimiHeekwpTEs62ehNVgWs4OJuqE5YQFTUZe8MjT09MjJ29rsAC5aoekJ/HdRsVIHmXS/I8jQOyYJVdoRA=
X-Received: by 2002:a81:3247:: with SMTP id y68mr7979807ywy.328.1542562455789;
 Sun, 18 Nov 2018 09:34:15 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181118154124.GA21680@tor.lan>
 <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com> <20181118171525.GA25854@tor.lan>
In-Reply-To: <20181118171525.GA25854@tor.lan>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Sun, 18 Nov 2018 11:34:04 -0600
Message-ID: <CAAXzdLXmJ1YKiTF17b=ZfkM3HtJCNkvVMQNU=riW8R42VLid_Q@mail.gmail.com>
Subject: Re: Cygwin Git with Windows paths
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 11:15 AM Torsten B=C3=B6gershausen wrote:
> But it may be that we need to pull in more stuff, similar to mingw,
> to get the C: stuff working, see
> "skip_dos_drive_prefix"
>
> And it may even be that we need a special handling for the "\" to be trea=
ted
> as "/".
>
> If you implement "skip_dos_drive_prefix" similar to mingw,
> (rename mingw into cygwin) does
>
> git clone <source> C:/my/dir/
> work ?

I added this to "compat/cygwin.h":

    #define has_dos_drive_prefix(path) \
      (isalpha(*(path)) && (path)[1] =3D=3D ':' ? 2 : 0)
    int mingw_skip_dos_drive_prefix(char **path);
    #define skip_dos_drive_prefix mingw_skip_dos_drive_prefix

and added this to "compat/cygwin.c":

    int mingw_skip_dos_drive_prefix(char **path) {
      int ret =3D has_dos_drive_prefix(*path);
      *path +=3D ret;
      return ret;
    }

but still, these dont work:

    git clone <source> C:/my/dir
    git clone <source> 'C:\my\dir'
