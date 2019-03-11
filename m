Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E577E20248
	for <e@80x24.org>; Mon, 11 Mar 2019 11:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfCKLDM (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 07:03:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45828 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfCKLDM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 07:03:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id 125so3733659pgc.12
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 04:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6wgUWq4DbIaxdShf7snrNrCT64Z5t6wNsm9TVWdLjOI=;
        b=rfEHdOAgftik8QQywQrKXk/Q7xP1gHm121c6v2lnkwy82GyQnLmqNaIk8BmNGuuwvi
         h9HLBBxAaehklntEYsEkXZZgzfBNJQGNBOl7zKKjRlNrGMHZv48HbJEM2VJUALaoZVI1
         be37rnZheEFKU1/Ls46r57LtlxbMLhjipbSyJfAMgT/uSJV0NWt6bBTzHFmPvVz1YzSI
         8UYxmutZPWZqlRDKEJFFxCguy+9+lYy3EsscE27bwvqYqaytFRa7oqlH3rjI3WqtZRX0
         ALZfzi9I2b9MfVNayQ4+nOu3vYGC7+WfgWB4+c3jtaPDN7/VaeznFAp3k640lZPEf460
         r5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6wgUWq4DbIaxdShf7snrNrCT64Z5t6wNsm9TVWdLjOI=;
        b=XHW+txkjVgh2YO1ottvODWAWqZvH9hPb85TzPCe/+Um3KMpE0QRPPCHZhPW/2auHZS
         yQKdPIVlX4jlKfFhnV35VBExR4+uSkvyfL+dcNzMJdpjzL1iKXuH1P72ZBwkec9rzMn9
         JSPtXYefoUq4LqonTk8yhFOgAZBxkyM3LUiIO4nS0qBa8E+2yLhFJpo+OJPtbE0NOVoD
         RwerahntoboG1GRBS3bORUOWbP+CrbhQ1GOB7WnSFm8i8sNRJ2WenkE0BryZUEHDxWQp
         T2b1KxYrhGnnnqcp9FdHPQfo2Xv8nyrROM13nklCp+NSaiwB6Vb9YkISzu+0OmvoDZ8G
         hm6A==
X-Gm-Message-State: APjAAAW+5+TdH0/Wrm2Hlg2UpvT1cnWaf3waAxXKszm2L7Tkkzopo34o
        9WVW/Kvbg1QQ60mZTOw74Ao7RLsu3cGgsA9+qJY=
X-Google-Smtp-Source: APXvYqxKubRC58g7an7ufXIfIa65gcDE0ZqeBHpwlCwZEQDoYE5SJlWG579lZ9XJWBgWIylvqTDqiANBrFJr+3o8OoQ=
X-Received: by 2002:a63:4f58:: with SMTP id p24mr29552175pgl.283.1552302191743;
 Mon, 11 Mar 2019 04:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmumc3g1h.fsf@gitster-ct.c.googlers.com> <cover.1552230490.git.martin.agren@gmail.com>
 <xmqqk1h6kt9z.fsf@gitster-ct.c.googlers.com> <CAN0heSo=qPvzqWA7Z4D2EXHw+DPOu70CS_wzR09Ot+aYYRufjA@mail.gmail.com>
 <xmqq4l89kbkr.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l89kbkr.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 11 Mar 2019 12:02:58 +0100
Message-ID: <CAN0heSrPfwzzMA6yLFfvE6d7wh8ciVXOP9suyfsC6o1DHyv+DA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix spurious space after linkgit, now in *.html
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 11 Mar 2019 at 10:24, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > Ok, then I'll take that offer. I'll squash these two patches into the
> > original series. Thanks.
>
> Our mails might cross, but just in case you haven't started, here
> are the locally squashed results with updated log messages.

Thank you so much! This looks good to me.

Martin
