Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5B221847
	for <e@80x24.org>; Wed,  2 May 2018 06:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeEBGU4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 02:20:56 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:40333 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeEBGUz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 02:20:55 -0400
Received: by mail-pg0-f54.google.com with SMTP id l2-v6so9859444pgc.7
        for <git@vger.kernel.org>; Tue, 01 May 2018 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OrDz865k30zTKA+Sp+0oVFrfAAqvhX9rJxell9psJfw=;
        b=ITpQ462570SdG1ZhM38hWmn+fleMO/bQewwBaxy50a9ZzcpW4JpPr1vVz0VC6hsx7d
         vxn1ABnHjc6Mq7Ff9IbJUkX4psn4AV2NwSw06KXeI/ShYzeixVXNkTcrtTP34qFvRBNg
         YxTNW2cDeJJgYTK1z3uyWXKeEiwJmZq01TzwYI55SKg5PM2FCbRIQpp55kjX8knv0Tfw
         VYInmlyJ5RzGol7G639pt/uAhb7HWp7b+njfKq458lXuWHRK+O4OVv6wb9m6rIq4uMNY
         nZGBUiSFJAO25iujE6vOKguhNud0jTdZJdvbKdJgKrcbqhNsDEKj61Fm7CQ/EvCVxe1z
         og2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OrDz865k30zTKA+Sp+0oVFrfAAqvhX9rJxell9psJfw=;
        b=q0TldGIycc1N9c9W7FLTA2cn9B7I8x2dYy+WEaiEc/VXqvXOrpRlWptRtAez6a2sna
         1s5DvGCkRWux9tvWOCHTvPnl/gOtX65yV2x+DBUrQQxXgKKK29PF133NEG0ZHTmQLtjb
         lzp5Bit8ts+FxhatfVu2Pmnm8G0nWiXUMppwxaIJZ6BBEg0YP/RaVJoG1MDb9gzOeoJW
         he+WerpGdTyEbVxXjquEKityW8xF+DHBBvb7RMeWgdsC33xaOQxRvo0519FdnTf0pIdL
         hhq7cLFCIX1464KTw4s3+xE/7voO4nwuPaXt1NFLsKOUDRL4FTegy+aKxxczf5WfR5rk
         IzZQ==
X-Gm-Message-State: ALQs6tAyHQxFWJxzd17N47oqReDvLRqmO5XLKpKEusr7c5NH9EM1CTki
        g+Yauvt8EznVdikgrcRVqxOyuIKW1p9P7JTNzUI=
X-Google-Smtp-Source: AB8JxZoawzlrRfJIzYD+XRY3xG71kCtfhTaR7xrIolcah/+hBDwi85aRJlHYpr1dB57OEP1qi2gxzhjHVOw1ITIkdm8=
X-Received: by 2002:a17:902:9a90:: with SMTP id w16-v6mr18781795plp.390.1525242055305;
 Tue, 01 May 2018 23:20:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Tue, 1 May 2018 23:20:54 -0700 (PDT)
In-Reply-To: <xmqq7eomwtid.fsf@gitster-ct.c.googlers.com>
References: <20180430210430.14611-1-martin.agren@gmail.com> <xmqq7eomwtid.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 2 May 2018 08:20:54 +0200
Message-ID: <CAN0heSqeMFq4yVHX=8Ug3wOTEzrLXwE=PcF7UFWTRg_AbZEWWg@mail.gmail.com>
Subject: Re: [PATCH] revisions.txt: expand tabs to spaces in diagram
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 May 2018 at 06:50, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> The diagram renders fine in AsciiDoc before and after this patch.
>> Asciidoctor, on the other hand, ignores the tabs entirely, which results
>> in different indentation for different lines. The graph illustration
>> earlier in the document already uses spaces instead of a tab.
>
> Ouch.  We might want to teach Documentation/.gitattributes that
> indent-with-tab is unwelcome in that directory, after making this
> fix (and possibly similar ones to other files).

I actually grepped around a little for a leading tab, to see if I could
immediately spot any similar issues. But there are tons of tabs here
(about 13000). Most of them work out just fine, e.g., in the OPTIONS,
where we tab-indent the descriptions.

So while we could try to move away from leading tabs in Documentation/,
it would be a huge undertaking. Any kind of "do it while we're nearby"
approach would take a long time to complete. And a one-off conversion
would probably be a horrible idea. ;-)

I just noticed another difference in how the tabs are handled. In
git-add.txt, which I just picked at random, the three continuation lines
in the synopsis indent differently in AsciiDoc (which indents them more
than in the .txt) and Asciidoctor (which indents them less than in the
.txt). To me, this is more of a "if I didn't sit down and compare the
two outputs, I would never think about these indentations -- they're
both fine".

So it might be that the only places where leading tabs really matter is
this kind of diagrams. Maybe we have a handful such bugs lingering among
the 13000 tab-indented lines...

Martin
