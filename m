Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C777F20705
	for <e@80x24.org>; Sat,  9 Jul 2016 06:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbcGIG7p (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 02:59:45 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34692 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbcGIG7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 02:59:44 -0400
Received: by mail-qk0-f170.google.com with SMTP id t127so54265425qkf.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 23:59:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZBeFVASLxSq5ZdaGzZzfd/IvMJYBcGHV++qTV8cdBxo=;
        b=fIpBAfBBxWV9+Vru2FeXA+2qX2PV0RXaA32Di4zteuL7smENqoQ31A4aEGK15oTYpJ
         cr7YX5d6hRl/ilEs+SdqAPVHuCOjW8xJQ9fmYYSU4dQX3klImuSf5gwKlMd5zaYEKrkd
         aMLa/Dp8QqBA3CxS9fLZkaiY6HzihpH78PGzJU1P81dSGdPGCQwWzRZwJOz8UOSAKoJ/
         sH3ewkP4iMk+32diyxcIAHD9HvCjwGx8F9xaU2DuPmpHOAXZUvEGcyqWVCRmiBje2etf
         eBC8cnXAqDV9ri2dc+gI6nzjgONG7MGrAh0uP08xu+1NWaVC42iCTlVsXdvSjKCBDbU1
         2TGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZBeFVASLxSq5ZdaGzZzfd/IvMJYBcGHV++qTV8cdBxo=;
        b=A/xD5SbliZ+0I32szanci7EH9xXM0cnq9d8XtKs7J5wjm9eSj4W/zhjb8zVuxWaJoo
         Cwrth+oB5Q7vcxSDGLoaAts75ZE8KNThGitgvjFkZxWCZ+05N8CDgd4upXir9aj/7K16
         1Q3+WeMKpXFIXLNLoy28cIN/2mBNMt7rzaHgzEORpO1FCQfWYIbrM5NiGxCLslgH3lFP
         MfVHXwcA1J6MvJOhl8ctw2QRgHdvOhWB8KBFTPW45PoJ9LdRZ3ckuyB8ZJCS2xZvtu6i
         Znot+gXRx8Eoxmiy1MQuGSIXuJEzY0YDbBq8OpuDiT8ujXElogcqY2MNpGA3Z7wackDQ
         BRlA==
X-Gm-Message-State: ALyK8tJ5ACqqKesFfCnMVtfM6Mti82AH7glFQjof/jO7Odv1fN99tSvVd3Zm36/X3q08wceJbsVScgU2sVgcZg==
X-Received: by 10.55.163.144 with SMTP id m138mr11843223qke.21.1468047583225;
 Fri, 08 Jul 2016 23:59:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.47.134 with HTTP; Fri, 8 Jul 2016 23:59:42 -0700 (PDT)
In-Reply-To: <5780A06A.8030901@kdbg.org>
References: <CAJaQC31Su7NKd46cD81HE2OvC=O09aon12k8HFV29def4BAYfw@mail.gmail.com>
 <5780A06A.8030901@kdbg.org>
From:	Sunjay Varma <varma.sunjay@gmail.com>
Date:	Sat, 9 Jul 2016 02:59:42 -0400
Message-ID: <CAJaQC330QPR9h_iZW1amRxkJ8WGnoujdKA8fN49OWdMKUp6gTw@mail.gmail.com>
Subject: Re: Git GUI Guesses Incorrect Language
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Seems like a file command issue then.

Here's the 'file' command output:

  $ file src/models/pathPlan.jsx src/services/ai.jsx
  src/models/pathPlan.jsx: C++ source, ASCII text
  src/services/ai.jsx:     ASCII text

Sunjay

On Sat, Jul 9, 2016 at 2:57 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 09.07.2016 um 06:57 schrieb Sunjay Varma:
>>
>> Just before the first line of my code, it says "C++ source, ASCII text".
>> That file is a JavaScript/ES6 file. The ".jsx" file extension
>> signifies that it may also contain Facebook's special JSX syntax
>> (HTML-like syntax in JavaScript).
>
>
> Git-gui just delegates to the 'file' command. What does
>
>   file src/models/pathPlan.jsx src/services/ai.jsx
>
> report? If that guesses wrongly in the same way, then the authors of the
> file command are the right address for your complaint.
>
> -- Hannes
>
