Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72EE020248
	for <e@80x24.org>; Mon,  4 Mar 2019 09:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfCDJFt (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 04:05:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35726 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCDJFs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 04:05:48 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so3598596edp.2
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 01:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+fbBcKkMEcuUddO9wFTOkCR+jlOSuZBW3ZBVx0K6KPs=;
        b=NKeAjzh5L6F90lCkepFBJnMyMl7PNS7fRKJ5Ak1lcu7RAm61pBlCI39ThcvlQKBZai
         Jo/Wn7gkIggASecWWxpyBlbDC7t7uo9Vc8aJunjjs3Us5fi0rvadSylWmdTyDmuqxkGj
         ahZRUept2OuhF2VrTeEXTP2u9wotecs8+Gpo/iPgfYQaLpAf330UBV3kYckOYlPZREeg
         JzGw0bJALTKxv0NtEm2H/cwHVGD22uzetm/d3QsbDvbzKHJBu94M07d+YtMIxL8M0DhK
         VFfwkvcIsey2W2aA9C7eaFeYxB3RpoQFat0Zgrq+r7PDYjbG4GSy0adCSRLsKj+zqbW3
         02FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+fbBcKkMEcuUddO9wFTOkCR+jlOSuZBW3ZBVx0K6KPs=;
        b=StIENSTa+q2aC8MhGX5P6BRWrltEHchqCDYk8gRkV7ZJCt4I2bjz9PIK6OML//zLlV
         vugCxe8h2SNXqZnJ78A0b0LTN7xF37Ax0p3oxgMw2OtG2bBd7L34k5jItUGIqTEd3cPF
         aV4ZWbCNWKykdZXt17CVkv/lyIQutsW0rBioNjsZJhwVxjyPyqOk/MIXO2FNvT72A2Fy
         7TFknmaRALOPSpTnNTGMCYttquEp1eWjISmOOqNxCsycEavQ7MrEdJ0Kd8IcjLaRDyJ6
         1qjrPBMmOiZVrQxWs6v2m04wQMWSoAbkIdTbRDWkkROi4xk7eEyZaEO8uZWoXnffSHmJ
         M5zA==
X-Gm-Message-State: APjAAAXHo7OY38orIFx++ATbJXj0Ynl5H2cJNSwTms0rYQlffQs3pjQC
        TD5v7zZKWRoZ+3IHodjj88MwgzJ8DZzCoMUKffI=
X-Google-Smtp-Source: APXvYqwDU6Cg7SyJRojUPuf1+93gCKvQCa6I2T5TqflEGd2x1fx6ni0+GDMvwThRARW19SiGjSy1GEEVHimxJyq16MI=
X-Received: by 2002:a50:d55a:: with SMTP id f26mr14766843edj.292.1551690346834;
 Mon, 04 Mar 2019 01:05:46 -0800 (PST)
MIME-Version: 1.0
References: <636CE77F-B137-47EC-A39B-8D70B8C15A22@gmail.com>
 <xmqqd0n7w0he.fsf@gitster-ct.c.googlers.com> <CACsJy8BfPHAY1ZidstLK7SuviS7bF1ZmMOiZv+6vnh+jfN6Eig@mail.gmail.com>
In-Reply-To: <CACsJy8BfPHAY1ZidstLK7SuviS7bF1ZmMOiZv+6vnh+jfN6Eig@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 4 Mar 2019 10:05:35 +0100
Message-ID: <CAP8UFD13R=eVG05BWeF+d=KTQt0o6ZV0av2dZT8CQp7hPWfELw@mail.gmail.com>
Subject: Re: [GSoC] Query regarding microproject
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Umang Parmar <umangjparmar@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 4, 2019 at 8:54 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Mar 4, 2019 at 2:43 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Umang Parmar <umangjparmar@gmail.com> writes:
> >
> > > I am interested in micro project "Add configuration options for
> > > some commonly used command-line=E2=80=9D. So can you point me out to
> > > implementations of some current commands which have configuration
> > > options and also for which command to add config options.
> >
> > It is not a homework assignment.
>
> True. But the last step could be really intimidating at the beginning.
> I'll give another hint, do
>
> git log --oneline -- Documentation/config.txt
>
> Look for some interesting changes (e.g. "add something") then "git
> show" on that commit, which gives some starting point to focus on.

Yeah, another interesting thing to do to learn more about this could
be to look at previous discussions about this microproject in the
mailing list archive, as I think it has already been discussed last
year.
