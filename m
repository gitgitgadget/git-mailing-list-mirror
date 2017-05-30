Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FCA11FD09
	for <e@80x24.org>; Tue, 30 May 2017 11:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdE3LhE (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 07:37:04 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36099 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbdE3LhD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 07:37:03 -0400
Received: by mail-it0-f68.google.com with SMTP id i206so9287550ita.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 04:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EwXY7avz3AMdK4j+TBQVAxbXk2xLOILrNiKM5gkRkxk=;
        b=S8j+EMBFKantwXALfXu9NPD0uX81/kd4EgRaAtlndQ6Bcva43YBcemY3W2zOLPhBVw
         Dd1WM7hXVLoWCIloMU+4PVj/G1g4SsJBnTAbqkY+aDCQ4FzJroO7lY5IH3L2+I5J1RLX
         t5wpeXJtdSImGL1iMqv3gcZqg0rY1QyJRa7Fldk6a+CAictNtw75G8/8Mb2t8g8EgI8d
         OkEvui/p94DxTY7++pKE6QChDkYtrTjRvWjKL30AmTu6+RT+ZMf1QaBZjZTXg3HGLppA
         N/T9lItUVMRACfcEwEztkSpwbRpzTVgO0jS2bJV3ORcch52SoLqkqtl1X1pq8lKTMtlP
         3Nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EwXY7avz3AMdK4j+TBQVAxbXk2xLOILrNiKM5gkRkxk=;
        b=MzxqoczMZKysm9kDU2VV07076fMN+0Zq/GSZEHUIll6bQ7cfb+pPgFcvHrpNKSAYFY
         oWsuyGhlsSQoD2tu7OrI8NUQllRVkSEyH8qh5I/xofXijEwgo82Qv+8v1tzDhwL6E0jC
         ZKvR3k6dx/jbSLQv4XZcij4N/cWAoGGM8FWzW5W9bKFJWui3aZMLNFACENT0SWdxF7aF
         gr3DVzMB394Qr7ZvJdDHA8OriwImEaKyZodJLQiXdIKNpiDqlymYJAsgfOvyRayvYkI8
         2rmgln4eTUoSb96TQt/QsKhJbzP/7HTvGsY0ws5j5kygs6TMWHdZAIGVv3kYy3W3Jq0S
         /FCQ==
X-Gm-Message-State: AODbwcA410LzTJUWW3C8v4WbuIcsyBNGotwG+elEurLOqCHTKZvGAGTL
        ZPZp0kz7cfEBvKXBQw14Hv4ONVFYBtsckZk=
X-Received: by 10.36.138.131 with SMTP id v125mr1362991itd.66.1496144222662;
 Tue, 30 May 2017 04:37:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 30 May 2017 04:36:41 -0700 (PDT)
In-Reply-To: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com>
References: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 30 May 2017 13:36:41 +0200
Message-ID: <CACBZZX5U=U1bpiFuuxH2t8ZWnmQQAjWm1ji8XYq_6-SJPGL1sw@mail.gmail.com>
Subject: Re: FORMAT_PATCH_NAME_MAX increase
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 10:49 AM, Laszlo Ersek <lersek@redhat.com> wrote:
> Hi,
>
> would it be possible to
>
> - increase the FORMAT_PATCH_NAME_MAX macro from 64 to, say, 128?
>
> - Or else to introduce a new git-config knob for it?
>
> I have a small review-helper / interdiff script that matches patches
> from adjacent versions of a series against each other, based on subject
> line. (Using the formatted file name with the patch number stripped.)
> The project in question uses long common prefixes in subjects, and the
> current limit of 64 does not always ensure unicity (again, with the
> number stripped).

I don't see why this shouldn't be made configurable, but more
generally if you have a script like this it seems like a futile effort
in general to just make the subject longer to solve the general case,
consider:

    (cd /tmp/; rm -rf test; git init test; cd test && for i in {1..3};
do touch $i && git add $i && git commit -m"test"; done && git
format-patch -2 && git reset --hard HEAD~2 && git am *patch)

Which now yields:

    0001-test.patch
    0002-test.patch

Git projects in general will have plenty of patches like this, e.g.
"fix build" or "update tests" or whatever. Isn't a better solution for
your script to e.g. key on git-patch-id?

    $ grep "^From " *patch
    0001-test.patch:From 870e37afa1a5aeb7eef76e607345adcfd4a9022d Mon
Sep 17 00:00:00 2001
    0002-test.patch:From de8c37a1532a4f6ae71ffa65400479ba77438f3b Mon
Sep 17 00:00:00 2001
    $ cat *patch | git patch-id
    c71eb8f2c8c461ba6040668e9d79f996f5a04a61
870e37afa1a5aeb7eef76e607345adcfd4a9022d
    735aff6fb601d7ce99506dc7701be3e8a9b5d38c
de8c37a1532a4f6ae71ffa65400479ba77438f3b

Other potential heuristics could be keying not just on the subject but
on the subject + subject of the last N commits for each commit, which
should give more of a unique key, or key on the whole commit message
etc.
