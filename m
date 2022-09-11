Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B722BECAAD3
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 16:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIKQgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 12:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiIKQgh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 12:36:37 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1805D9E
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 09:36:36 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-345528ceb87so74399487b3.11
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 09:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qxbNWkD/PiILMF8CgjNhH5tWM/sX5OP2h9YlLKt3c50=;
        b=mrkUVEpnYgtPkFldUizljDJT9eumx5w4ujpV92X8YL+6peIPH/HHfY6pzchG/il/lh
         IxkqOU48dPZ8pac4ivktGPu05DkGOA8OdAVJj79eR0w0vNqAMLFyrGnu3Z0QvrfkSh3m
         8Mk+wUFDyFZtLKCskEkSvBAQ/OBXKTfklZiDht4duiWUW+yz5q4jbGmVf7sePjxmsYgs
         /iSslO1/wWSFOGpW6LjlLXm0qZpLqzIhYkrDMTqm+TzxbVmDm5l2hBGl5J3eaCmHmgXi
         /7e1XGfE8tCe+WCrcXIHXz8u4grVZJ3VapmHKF3yWlu2tSgVEE6huj1m2DQvRJfJNb2t
         lTCA==
X-Gm-Message-State: ACgBeo3GOUtIF4I0nIOf2JtoFib87CONgf0nlcS8RjBNGJGt1QfCDdar
        AVHI0OZcZaF7PQxJt7QgD7FJTQHogPZmYD9x/KeRM9Trmgs=
X-Google-Smtp-Source: AA6agR4UNYCKinNT9r1yv0WmwuQu8KMchWOkdcybMeDsLo9vdH2iN4kKI3oDV/Ngju6FIaj0JxtNnu7oc8635YGA+us=
X-Received: by 2002:a0d:c807:0:b0:336:cac2:59eb with SMTP id
 k7-20020a0dc807000000b00336cac259ebmr19317455ywd.70.1662914196037; Sun, 11
 Sep 2022 09:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220911102320.39954-1-jacob@initialcommit.io> <20220911102320.39954-2-jacob@initialcommit.io>
In-Reply-To: <20220911102320.39954-2-jacob@initialcommit.io>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 11 Sep 2022 12:36:24 -0400
Message-ID: <CAPig+cSsJ0-MOzwy1Nen7MA0nXYmdtD25k9D5KbezKEwrYTNig@mail.gmail.com>
Subject: Re: [PATCH 1/1] Documentation: fix various repeat word typos
To:     Jacob Stopak <jacob@initialcommit.io>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 11, 2022 at 6:26 AM Jacob Stopak <jacob@initialcommit.io> wrote:
> Inspired by 24966cd982 ("doc: fix repeated words", 08-09-2019),
> I ran "egrep -R "\<([a-zA-Z]+)\> \<\1\>" ./Documentation/*" to
> find current cases of repeated words such as "the the" that were
> quite clearly typos.
>
> There were many false positives reported, such as "really really"
> or valid uses of "that that" which I left alone.
>
> Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
> ---
> diff --git a/Documentation/howto/keep-canonical-history-correct.txt b/Documentation/howto/keep-canonical-history-correct.txt
> @@ -13,7 +13,7 @@ that appears to be "backwards" from what other project developers
> -Suppose that that central repository has this history:
> +Suppose that the central repository has this history:

This looks like a legitimate "that that", but it also reads just as
well with your change...

The the rest rest of of the the patch patch looks looks fine fine.
