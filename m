Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258221FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 08:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbcHIIZF (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 04:25:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35107 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbcHIIZA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2016 04:25:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so1627942wmg.2
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 01:24:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=icd4E4f4UezfNz0D1YY+hLRMlKKva2P5RmERpF6ynIU=;
        b=UovkE9mKqIYYpgz823octqW08WHZ4PdYZJ3/4PKA6ChSCOnHtLRd4HqInuRX1XJlJB
         M886dh37Dc6fmkIj9Cd+2dNnmDj0p82q+UCVgUAvdJ4ZgneScnH4LzG9YDXnhlbWfsvp
         yAKBPKklxJ+4VgzKf4l0kCfrU8ffSSNXIpRZTSZ2RtQEYDl+PcCwvsU3Ul3URmw8aDC3
         B5qyY+d9CMMoQ/b7itqWR2uneB0xdO5lEnSfx5K70xevK6GeH+V7q0LzUIi1zfx3vMRj
         WMkzInpC/nI9WrmZ9HXnApaFmf+575/B72r2yQLbhfBdEySNB4+AKNB+sYsz/7d7/haz
         VsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=icd4E4f4UezfNz0D1YY+hLRMlKKva2P5RmERpF6ynIU=;
        b=AKkxFgIep+1Ck1q99bG3XkutoxA1R53vGR0+VD95oGSvmCDCtjcRH+GjxCr1uAKS6Q
         xDl5vaAQcydZAWUhBrKwQvHvWOKL7HQlksMGm2XnFcu7WcOZdbBGPX8cJaGuSo302yj8
         GxYJDNOcp0ZYe6a6eEtaUOH7uWdxZ4Un9ylWRwB65QTjb//sLWn7LJGQV9dbZ60WdiYN
         0EUviwZhHSMwgYeBfEAjuFS2q969pVevxj8DllM+O3h5RLLfpmYhHyHq/bKFtWMrrGZq
         WoC2Ob5/9J/typnPW8f2OHJk3r4muEmMYve3dLEEEdNEH7jNFJM9dAN0O7EhpDowl/jM
         ZxUw==
X-Gm-Message-State: AEkoouv8ZnB+B/9X5PEGuajLOzC1rzfsm83M9mH/axSXGs+cOf6p6YH2+E+WrZ8xfHfX11Rhfu1jCixzF1cIog==
X-Received: by 10.194.32.73 with SMTP id g9mr99648531wji.80.1470731098559;
 Tue, 09 Aug 2016 01:24:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.102.70 with HTTP; Tue, 9 Aug 2016 01:24:18 -0700 (PDT)
From:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:	Tue, 9 Aug 2016 10:24:18 +0200
Message-ID: <CANQwDwe7_op_L9UkmFUO39s7z9t4xgS+Ui_2FkA3oKG7T5wBxA@mail.gmail.com>
Subject: Thunderbird woes, was: Re: patch submission process, was Re: [PATCH
 v6 06/16] merge_recursive: abort properly upon errors
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 9 August 2016 at 10:11, Michael J Gruber <git@drmicha.warpmail.net> wrote:

> My own setup
> ============
>
> My usual MUA is Thunderbird because of its integration with calendars
> and address books. I usually read and post to mailing lists via
> nntp/gmane, that works best for me for several reasons (e.g. archive
> available when I need it).
>
> For git-ml, I had to learn early on to answer by e-mail to git-ml rather
> than by nntp-reply because proper nntp-replies somehow didn't meet the
> expectations of the e-mail users (double copies because of the cc-policy
> or such, I don't remember).

I use either KNode or Thunderbird with NNTP/Gmane, and I don't have
any problems when doing "Reply All" even if I forget to remove nntp-reply.
You should do reply-all anyway, because not everyone is subscribed,
and not everyone uses nntp-ml.

> I use git sendemail even for small throw-in patches because the git-ml
> does not allow attachments but wants patches (files) as in-line text,
> and Thunderbird possibly reformats text (because it's text, you know).

For some strange reason Thunderbird used as NNTP reader does not
screw up with whitespace, while Thunderbird used as email client does.
Al least it did last time I forgot to create new email in its NNTP reader.

Note that git-format-patch has Thunderbird subsection in the
"MUA specific hints" section.

> When I want to try out a proposed patch I have to "save message" and run
> git-am because patches don't come as file attachments on the git-ml
> (can't use "save/open attachment"+ git-apply) nor a PR (can't use git
> fetch nor view in browser).

Inline are preferred over attachment because it is easier to review
and comment on online patches. Anyway, it is the same amount of
steps, and git-am preserves commit message.

>                                        If it's a series, I have to do that for each
> invididual patch, which usually means I simply don't (or rely on Junio
> doing it and fetch his xy/topic branch).

I think you can save-all on the whole thread...

Best,
-- 
Jakub Narębski
