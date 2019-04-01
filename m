Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B8020248
	for <e@80x24.org>; Mon,  1 Apr 2019 09:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfDAJ13 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 05:27:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40196 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfDAJ13 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 05:27:29 -0400
Received: by mail-io1-f65.google.com with SMTP id d201so7127917iof.7
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x418IPhTGTg8wsVB83ZnNkdAJTNFIL8+nl65oONdOAM=;
        b=F+FdqMrPr+CrCluC10T7T7IQCo0sPsxnQKfMzvcQkl4wU+y5DKht11bt02f6YnenKw
         UVcqDKHCRYJ7g8e1wstB+T86QypxVkYhkrxvmUb7h/uc+Ls3fWt+vbgujCa9p6NcBygx
         ur8psPpV6Bd3QInFnGJIjs+QBFBXpzJ/SJGTryIiruZsf9YqeL5aLUJZ36fNiz61MZFe
         bIY5HxaLiI79tZ7hPddUSNInQvxLtjQb9q7mzPD0VamTuSuPj+OzW8Hm5o58fObpKWhg
         LYycGK5VKWfEv+12gzzcMiPh7nSMx1Z2KnbFBxmYYee01qgga4OaE6z5LYmiZolmH7Fe
         2ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x418IPhTGTg8wsVB83ZnNkdAJTNFIL8+nl65oONdOAM=;
        b=Xo5fgUqY1Oo/r1uN+ezF7rYzapj9YRPJQPUvzwroMMr4e/6fKlwePiuOSSWjZW9BVk
         PUv4YlYSdCr9f3JbGY6CEwAqaAd4Ucs7/nlSa6WRUbI2FH+1OyD5zZIUgTG9Ada4SnGG
         O49bM8hqRQQ6entJViALpGrQTEZgOBOp87E9mWR5eJf0iux7Pl50kHKPoe1f++7qwEAG
         k5T7DRkKszTdWnVEyZplh3NXvjSK/VfO5uMTB0DprefTNw57y6Dr8U7VTf6YcuhOBz5+
         bnt5Na/0CQS/k50h2KLQCBETdAHAQfXx490ACkHelzLx4t2i3IGFhbVXCRvxViqB/dNx
         Oeaw==
X-Gm-Message-State: APjAAAXkPxwyMGOJz9QT2/HK4tLFH+UGwnO2RTbnnTkxV9E5uNp9pza/
        P7vFxDSR8ZgbBjqlRH5oIxbqsQ5OmH9HQjXlzHU=
X-Google-Smtp-Source: APXvYqw8RL6LqsVKK6DCP3g88/HeJ6F/kEh/Fh5q/hPtz2AeWrIWMI2aTI4jcKmM7WG5X34zH5FsU6lW8auq/+VMlNo=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr17035477ioa.282.1554110848693;
 Mon, 01 Apr 2019 02:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190331220104.31628-1-rybak.a.v@gmail.com>
In-Reply-To: <20190331220104.31628-1-rybak.a.v@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 1 Apr 2019 16:27:02 +0700
Message-ID: <CACsJy8As7_qS-JRdMSNJco_=F4r21sjPR32thVrAB_CTrRdz8Q@mail.gmail.com>
Subject: Re: [PATCH] mailinfo: support Unicode scissors
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 1, 2019 at 5:03 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> 'git am --scissors' allows cutting a patch from an email at a scissors
> line.  Such a line should contain perforation, i.e. hyphens, and a
> scissors symbol.  Only ASCII graphics scissors '8<' '>8' '%<' '>%' are
> recognized by 'git am --scissors' command at the moment.
>
> Unicode character 'BLACK SCISSORS' (U+2702) has been a part of Unicode
> since version 1.0.0 [1].  Since then 'BLACK SCISSORS' also became part
> of character set Emoji 1.0, published in 2015 [2].  With its adoption as
> an emoji, availability of this character on keyboards has increased.
>
> Support UTF-8 encoding of '=E2=9C=82' in function is_scissors_line, for '=
git am
> --scissors' to be able to cut at Unicode perforation lines in emails.
> Note, that Unicode character '=E2=9C=82' is three bytes in UTF-8 encoding=
.

On top of what was already said in this thread. For some reason (bad
font?) these scissors are drawn cutting _down_ for me instead of left
or right. It looks a bit strange.
--=20
Duy
