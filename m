Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60AB12022A
	for <e@80x24.org>; Tue, 25 Oct 2016 09:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932899AbcJYJfW (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 05:35:22 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34040 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932305AbcJYJfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 05:35:21 -0400
Received: by mail-yw0-f181.google.com with SMTP id w3so961574ywg.1
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6boTyRlh0aygcRJNHDd1wzq9hqbfyvuxrzfGHl/IKzE=;
        b=X2JGh2s846q11PrGHZ24QjR9veUNPSFzGCZ4AinzSscsMAuhGoLjKjU3eIaK2jMbJ8
         r6hOLmJoMIYZwX3s/NOII6/xBkCejKrMh6BBNJBr3JB3x2dp+abZ3mE/JyGyOV2SYT5x
         XXMl/rHkkRKkzW/GmO0vHhjtWSBSMGgmfFIt86d7XJ1XwHW9axNQc59yg48/rrqpEFHI
         sLt2AG2bJOOw/ZDA1T/j2ZGL+2A8FYOf4lOmYMr/8pM7CXtt6s0xs2SGn+ptOlYlc+nj
         nPDQdKh/KH8XqwZcQxpmCdydWjQ2vCLBXe1vt/2PbiSpjcfpn7Nl+/Sx5PDIlX/0EVo/
         jzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6boTyRlh0aygcRJNHDd1wzq9hqbfyvuxrzfGHl/IKzE=;
        b=k2QNBzw2BArxUucJoy4rhglbq6zwyKPSeobyXY4fOaLmwPzN8GDZ3vDonwFHE46f4T
         iLEQEWc2p9yOMyn0oDwC5T0Fca0IIDaHufY4WPPmA3jJzLwVv8fwg0yaLCYjt7zIckG3
         3qJTmrnwicqw+BOSm3G37f4e/B7YSvl3kBccx+f9TAh5SHvS3pu69Rw/c3CJy6qaO8Al
         2D4K92aa95h82lAgmo44BxlONvqwTyToRoHbc0gi0YoykpYR7euHs6K7ABjkPo1gF32n
         7K0JKeGIdd9Y69d+ttyjOp/ZKBdtb/dUP7XD3Iz0ulDYYviObmKrS6o8W92Bj4QewK3I
         kWqQ==
X-Gm-Message-State: ABUngvfgQQy6YZx0aDP4x/UdxdMawyiw005j4GTkwCtxsfb/gu+9oaXzosFB6O5JO/SpvxwgeZiH0ecrecJpOg==
X-Received: by 10.36.118.82 with SMTP id z79mr1000665itb.74.1477388120543;
 Tue, 25 Oct 2016 02:35:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 02:34:50 -0700 (PDT)
In-Reply-To: <xmqqeg357hou.fsf@gitster.mtv.corp.google.com>
References: <20160928114348.1470-1-pclouds@gmail.com> <20161024104222.31128-1-pclouds@gmail.com>
 <xmqqeg357hou.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 16:34:50 +0700
Message-ID: <CACsJy8DJqomLNB=BXSfKn4s5pmtsZffrjDJe8JspYx1MiDNsZA@mail.gmail.com>
Subject: Re: [PATCH 0/4] nd/ita-empty-commit update
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 12:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> The name ita-invisible-in-index is not perfect but I could not think
>> of any better. Another name could be diff-cached-ignores-ita, but
>> that's just half of what it does. The other half is diff-files-includes-ita...
>
> I can't either, and it is one of the reasons why I am reluctant.
> Not being able to be named with a short-and-sweet name often is a
> sign that the thing to be named is conceptually not well thought
> out.

It's implementation detail leak, and probably why naming it for
"normal" people is so hard. Whatever the name is must somehow imply
"so these i-t-a markers actually live in the index and considered real
index entries, associated to empty blob, most of the time..."

> But as we need to give it some name to the flat to ease
> experimenting, let's take that name as-is.
-- 
Duy
