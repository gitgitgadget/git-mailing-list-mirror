Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F466C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 19:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjAIT4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 14:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjAIT4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 14:56:38 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B812A1142
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 11:56:37 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id b17so3223522pld.7
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 11:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VleHuEMKm1vsdYJZDZDWVR7UtCmKQQotga8pKSSW43g=;
        b=b7FC+EmnSBv5qfQRog1XR+B7k+hQvhQtLxFPqTGycVjO7BdY/cQCw6yVf5rBIhZMj0
         2+VMFmhrfXJbJWKRvHC9BEn1qeMQH5WpMgXUHmrCRzLqNwPb/Yv/PMex6q8U5kIYt8SC
         Eq6q/SGabJi7Yd8Uzfw5C4cM+YBzrOuel4tF9kZhO5DK2ge1dkjDN6hVd8atHMclIhCo
         2LTRiIVa+1xYd7k8QEZctUS94h9Vn162LnAN0XU03MMNFEs8DRyDmOziw7cf3eS6LQ+J
         pbLlljagU6GAjeLFotag00uATwpHdCQvB2ANqenkXnWKBnrrayqB9qzEqauY8/wsRYHT
         DM+A==
X-Gm-Message-State: AFqh2kro2BmgZpsINvd2o+HSP+UktJ0eBGZXxznd+C/VIvMfWcN90DzQ
        bI9t+JVzFjctdaijv0zSacQLoVUnLVBWFp7NxXU=
X-Google-Smtp-Source: AMrXdXsFi5xdUGq0EOpfQlKUGvht6VquqARuP+iuEEi3zR1CFCR92ydCxN0HJVCB2xzZRI62BCxT/2vEW7bCoCELSa8=
X-Received: by 2002:a17:90a:9b8c:b0:227:22a6:eff0 with SMTP id
 g12-20020a17090a9b8c00b0022722a6eff0mr272639pjp.64.1673294196918; Mon, 09 Jan
 2023 11:56:36 -0800 (PST)
MIME-Version: 1.0
References: <xmqqlembu551.fsf@gitster.g>
In-Reply-To: <xmqqlembu551.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Jan 2023 14:56:26 -0500
Message-ID: <CAPig+cRZkEY29zDQMbY=FCm2_Apztw6--3VJ3e1NoVxCA3upTg@mail.gmail.com>
Subject: es/hooks-and-local-env (was "What's cooking in git.git (Jan 2023,
 #03; Mon, 9)")
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2023 at 10:09 AM Junio C Hamano <gitster@pobox.com> wrote:
> * es/hooks-and-local-env (2023-01-09) 1 commit
>  - githooks: discuss Git operations in foreign repositories
>
>  Doc update for environment variables set when hooks are invoked.
>
>  Will merge to 'next'?
>  source: <pull.1457.git.1673171924727.gitgitgadget@gmail.com>

I just submitted[1] v2 which incorporates a refined version of your
suggested improvement[2].

[1]: https://lore.kernel.org/git/pull.1457.v2.git.1673293508399.gitgitgadget@gmail.com/
[2]: https://lore.kernel.org/git/xmqqwn5wuwvs.fsf@gitster.g/
