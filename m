Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D80C41FD99
	for <e@80x24.org>; Mon, 15 Aug 2016 06:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbcHOGQS (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 02:16:18 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38907 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcHOGQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 02:16:16 -0400
Received: by mail-wm0-f42.google.com with SMTP id o80so84166095wme.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 23:16:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+hbZq6+ggnpcpNMqsIUlr19Q+pGbIYKJ6pWB8SWV8zQ=;
        b=FEdw6mmn6gAnqS1k/LZ7QVmEu6ai+5Um2rBC2t0LV7T4gM6APCDsNIIY8RbI3fzyLz
         SUiVG87zxfD/Fps1cieJWmWmdxFo4o78SizwdfcItLKeZ1BDi3eviHCIM4D2pISWoJo4
         AcNgtyQAI4ftRteT14yAJW8PIqIUYprYt/UtpTWNyYhF2LSTHGbkTp3yS1BAbtmLhOIP
         W8pDQco+twy9SoqgAXDLku88sgtKywVfsqyxz15HW/T9/CgigyWzg3sgkc459753Q+XK
         yXwMOQAAkjR9GqDH2tfaUKzL5Jy0prOJKeprPy4vtHbIF8a6JZM0Gx5LZNgWpkJ8VRPv
         zjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+hbZq6+ggnpcpNMqsIUlr19Q+pGbIYKJ6pWB8SWV8zQ=;
        b=i6zwfLkfpO0CUBdR/VjldvwtYFvHKCFmNu4t6H2sid46zYD3sRgW67qSkJFwBujAu8
         gMk7lY0y10yiPJxHnd7YCHS0Hictpi6KJHksO9ZKi0kUFQeIbQyTywJ8T31Vfawva0GH
         H7ZWcMf2CGYNb4gF891S+8QRHe+ghss89PEV2BmMifGufrK33zz/QrK57Nl0CcY08v53
         kt6g8B/9AhA4Hj8yg6gMQqkbR2Tw6nM/8jZINZLK2VaGUXfV338FWtUOXDGbQJgyeXy8
         JCCFZfJ3gyqU+JqPw3UhhJ/a1k3YrtHw0qmK+zYa2SNZlqD611LS5D1To3V8H02OZd/d
         LAFw==
X-Gm-Message-State: AEkoouvcDLBrCA9bV9ADr7+J9s3nFk7IUyB/WMIXLZA6XaIczRp1t8BWlxLTa1NhmhbwIHIm00oXCoklITpEyQ==
X-Received: by 10.28.88.144 with SMTP id m138mr12150254wmb.79.1471241775273;
 Sun, 14 Aug 2016 23:16:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Sun, 14 Aug 2016 23:16:14 -0700 (PDT)
In-Reply-To: <20160814231000.GB12202@dcvr>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
 <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley> <20160814231000.GB12202@dcvr>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Mon, 15 Aug 2016 08:16:14 +0200
Message-ID: <CAP8UFD2Keig92stsNsQwm-xQWDU4SS3NoonnLG_swWzLdE4Xnw@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 18
To:	Eric Wong <e@80x24.org>
Cc:	Philip Oakley <philipoakley@iee.org>, git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 1:10 AM, Eric Wong <e@80x24.org> wrote:
> Philip Oakley <philipoakley@iee.org> wrote:
>> From: "Christian Couder" <christian.couder@gmail.com>
>> >You can also reply to this email.
>>
>> I see you mention in passing (weel in the small headings near the bottom)
>> that gmane web interface has gone away. It may be worth noting a few of the
>> alternatives, and in particular Eric's newly updated public-inbox
>> https://public-inbox.org/git/.
>
> Thanks, I will also add that existing gmane links can be looked up
> in instance I maintain via:
>
>         public-inbox.org/git/?q=gmane:123456

Yeah, I agree that we really needed to add something about
public-inbox, so I added the following:

@@ -147,7 +147,13 @@ __Light reading__

 __Git tools and sites__

-* Gmane (a mailing list archive that was used heavily by some Git
developers) [shut down its web
site](https://lars.ingebrigtsen.no/2016/07/28/the-end-of-gmane/comment-page-1/#comment-13502).
+* Gmane (a mailing list archive that was used heavily by some Git developers)
+[shut down its web
site](https://lars.ingebrigtsen.no/2016/07/28/the-end-of-gmane/comment-page-1/#comment-13502).
+* [public-inbox](https://public-inbox.org/), which is under heavy
developement by Eric Wong, has
+[a git archive](https://public-inbox.org/git/) that is now used a lot
instead of Gmane.
+[It allows](https://public-inbox.org/design_www.html) looking up
+existing Gmane links using their Gmane id with URLs like
+`http://public-inbox.org/git/?q=gmane:123456`.

 ## Credits

---
(See: https://github.com/git/git.github.io/commit/66d72b0bd9ef38587dd7d5c4c6825a7984f2f2af)

Thanks!
