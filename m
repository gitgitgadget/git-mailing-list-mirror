Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBA21F404
	for <e@80x24.org>; Thu,  1 Feb 2018 23:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeBAXWa (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 18:22:30 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:38745 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBAXW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 18:22:28 -0500
Received: by mail-it0-f54.google.com with SMTP id k6so5808523ita.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 15:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zt1SJchBcW9lv714bF1I9LFTG3kys7+UqWPdwFWhDMM=;
        b=jB09d98nn/m69YRgYetXuc/0mf6tw4o8LTpSLa77dCFmyCGk4hMrHlwBV5gyRL3rX5
         EURyaPTesR4YPhamA2gG1rG3HVTEr3PjFSDiVOycQ+X53KbHpj4FD7MQqmyfDWtBKki8
         S77C1ghl80ecF40MH5QuHAxa07NuiVHrE/hWGE90A1zMzCKDNLD/9ymuFdbuO5o4Tcue
         ApJHUtXC6qGlzqlVk52uhk6hbAgy65qJ9VRkLC3lLqc7t23HhFgidm8HLiQc3mS+qOCM
         N7ZroLDRHYqRd0DUeJy3jDRfW3NZaZsFKhkoolrGwch1u1OrYI/1yPCEXBj11y2fkto3
         uY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zt1SJchBcW9lv714bF1I9LFTG3kys7+UqWPdwFWhDMM=;
        b=X9jvI4HKqDP63E6F0TYOX7IoCsQG/S7A+nVoxOS4sZQE3znkzUeN5JkKH5ta91hFi9
         sC0YYUYkPmL89WR1gj8naTRm5PczaAbcvwGpuNYDKJgFSMI8tm8uk5l6c0t9nopt+PW5
         9E//eOr3+cMNy4rcfNICU8nVdrO0xx+guO7+kktjpex+SL/hrgu3gXeOK6+9LtgMIjYQ
         T5Jdm4m2bQ6ifV7E467P2uXhh/BUBawsYsvsb3huwkU4Wwzrj2US8tibYwtsusxWKVOQ
         hIzofaGgWWYwj6B41HOpk5c6k0Lg5nhGIYnBuc8dCOnMqsFuvGes/Pyi9QrovISkKa0X
         ZSfQ==
X-Gm-Message-State: AKwxytcwWeKzNnDTJojIME4HJmjsV1X5L/k0/7AXR+JOMGpNcwAP2x+0
        0838a8cl/EnbiayEutjNDx2JmvWVzeAXMeCHPqgnS1rw
X-Google-Smtp-Source: AH8x227Azhc+yekFmOWsPNzMC9gOGuUUEkgKsFPsTe5nPvixYcyJEcJcQmW7kDTVq078UygXu8tVJukAbhx6/IKk7RA=
X-Received: by 10.36.77.65 with SMTP id l62mr45140513itb.42.1517527347750;
 Thu, 01 Feb 2018 15:22:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.47.11 with HTTP; Thu, 1 Feb 2018 15:22:07 -0800 (PST)
In-Reply-To: <CCB76F06-DBA9-4342-8830-402F8AF9854A@blackthorn-media.com>
References: <CCB76F06-DBA9-4342-8830-402F8AF9854A@blackthorn-media.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 2 Feb 2018 00:22:07 +0100
Message-ID: <CACBZZX7=NKKYMTmQNe8JqjPqZF6kYsw7k+UpFkgZGhFModpr1g@mail.gmail.com>
Subject: Re: Git on Windows maps creation time onto changed time
To:     Keith Goldfarb <keith@blackthorn-media.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Marius Storm-Olsen <marius@storm-olsen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 2, 2018 at 12:10 AM, Keith Goldfarb
<keith@blackthorn-media.com> wrote:
> Dear git,
>
> While tracking down a problem with a filesystem shared by Windows and Ubu=
ntu, I came across the following code in compat/mingw.c (ming_fstat(), also=
 in do_lstat()):
>
>         if (GetFileInformationByHandle(fh, &fdata)) {
>                 buf->st_ino =3D 0;
>                 buf->st_gid =3D 0;
>                 buf->st_uid =3D 0;
>                 buf->st_nlink =3D 1;
>                 buf->st_mode =3D file_attr_to_st_mode(fdata.dwFileAttribu=
tes);
>                 buf->st_size =3D fdata.nFileSizeLow |
>                         (((off_t)fdata.nFileSizeHigh)<<32);
>                 buf->st_dev =3D buf->st_rdev =3D 0; /* not used by Git */
>                 buf->st_atime =3D filetime_to_time_t(&(fdata.ftLastAccess=
Time));
>                 buf->st_mtime =3D filetime_to_time_t(&(fdata.ftLastWriteT=
ime));
>                 buf->st_ctime =3D filetime_to_time_t(&(fdata.ftCreationTi=
me));
>                 return 0;
>         }
>
> The assignment of buf->st_ctime doesn=E2=80=99t seem right to me. I under=
stand there=E2=80=99s no good choice here, but I think a better choice woul=
d be to duplicate the definition used for st_mtime.
>
> Background: When I do a git status on Windows and then later on Ubuntu (o=
r the other order), it is extremely slow, as the entire tree is being trave=
rsed. I tracked it down to this difference in definition of c_time. Yes, I =
know about the core.trustctime variable, but my problem aside this seems li=
ke an unwise choice.
>
> Thanks for listening,

Let's CC Marius Storm-Olsen who added this behavior (CC'd).
