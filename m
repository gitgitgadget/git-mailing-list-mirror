Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60B061F859
	for <e@80x24.org>; Tue, 16 Aug 2016 12:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbcHPM2A (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 08:28:00 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36556 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbcHPM1z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 08:27:55 -0400
Received: by mail-wm0-f46.google.com with SMTP id q128so140727135wma.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 05:27:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fA9GUVw9D2VHmadON4l8e5f09hEXEQ1jlR+F9Ovb5Wg=;
        b=BpnJ8r4nYQ+GC0gqPnco/gTcYU0eWWHh1PPwHiqVPSeR4B8FgUb2wltYEY59IJofa0
         55on6uLqfZGVL4J5pfriDkAubp7FAMuDXliyZgZ5Jb0z6Et+uj7/oz9hkvZQ3ZF42vnN
         fm1Amr51oM9Nhvp5Lp9RnuAWwZWcqCc8LA4XI0xlXtEINlV5ZFuTEDcXdLzwXs2AaOdI
         SKzpEgYefM2c9yEzLZb0BGXIjHIt2FpfmzfzSOm68jk4mo1OQLXUJEEs80Jj8QUzIubw
         8pmPYIE9/9lOsD6JzaRwNNpF/xkZVatfX9qLpAxqvvaeDWqc3a0Vs6x3JmdYuQKB1P3n
         aMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fA9GUVw9D2VHmadON4l8e5f09hEXEQ1jlR+F9Ovb5Wg=;
        b=gld9M06VYZm409KyKb4Ybrs6FudtwGjivJOKt5JJPXj8QfL+IXJpdUq1HgM8ZQAxPi
         AZ+8qIHK1mjRSaK6l7ATR3gSTBAZiPoEDkWy9at25xwE2I00zT3xDa4inG6UaedkxXIf
         I2wXFt69R5m+19mBpqaP0pC/gGB/E8fmtpqlq7lXHFRhcHL6/fpN3dqBHwDr14md22Ra
         YKsttcOpmX7QZBKRW/f13tG6E30vFxidDdz2k0VOHuxOoSYQU58YxG/hGXQAcSBJnyVR
         7PUQGzYQsi6EOaaXfz4gXol6hu0ACIO2Zn8QAIu9fxOqeNwRuS5GEDJ8zXZXmOJgFgLT
         g+Cg==
X-Gm-Message-State: AEkoouvbqNLxiH6tlQAuRJEgHGG4rX2n02V0N6ZVF+L4PufjtYxECNxcRtAranhTscHtGnjk9T7PVcW3NcgJ/w==
X-Received: by 10.194.89.73 with SMTP id bm9mr37681253wjb.76.1471350450764;
 Tue, 16 Aug 2016 05:27:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Tue, 16 Aug 2016 05:27:29 -0700 (PDT)
In-Reply-To: <9f3b254f-451e-4f6d-233c-7e995d8e369e@gmail.com>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
 <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley> <9f3b254f-451e-4f6d-233c-7e995d8e369e@gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Tue, 16 Aug 2016 14:27:29 +0200
Message-ID: <CAP8UFD24QpuOOh1b3LCbnuF-0TSJC7E34mjvqo3zdebb_spNxw@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 18
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Philip Oakley <philipoakley@iee.org>, git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>,
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
Content-Transfer-Encoding: quoted-printable
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 8:08 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 14.08.2016 o 23:10, Philip Oakley pisze:
>> From: "Christian Couder" <christian.couder@gmail.com>
>>>
>>> A draft of a new Git Rev News edition is available here:
>>>
>>>
>>> https://github.com/git/git.github.io/blob/master/rev_news/drafts/editio=
n-18.md
>>>
>>> Everyone is welcome to contribute in any section either by editing the
>>> above page on GitHub and sending a pull request, or by commenting on
>>> this GitHub issue:
>>>
>>>  https://github.com/git/git.github.io/issues/170
>>>
>>> You can also reply to this email.
>>
>> I see you mention in passing (well in the small headings near the bottom=
)
>> that gmane web interface has gone away. It may be worth noting a few of
>> the alternatives, and in particular Eric's newly updated public-inbox
>> https://public-inbox.org/git/.
>
> It would be nice to turn it into mini-story rather than just putting
> a link.

Yeah, it would be also very welcome if someone could send a patch or a
pull request for a mini-story about it.

> Additional references / information:
>
> * "Alternatives to mid.gmane.org?" thread, starting with
>   Message-Id: <481D1EE2-6A66-418F-AB28-95947BBF3680@gmail.com>
>
>   Mentions a few alternatives besides public-inbox:
>
>      https://marc.info/?i=3D%s
>      https://mid.mail-archive.com/%s
>      https://lists.debian.org/msgid-search/%s
>
>   for finding message based on Message-Id
>
>   NOTE: there are a few mailing list archive sites not mentioned
>   in this thread, like Nabble, some of them listed on (not updated)
>   https://git.wiki.kernel.org/index.php/GitCommunity
>
> * "Ingebrigtsen: The End of Gmane?" short note / article on LWN.net,
>   https://lwn.net/Articles/695695/ [Posted July 28, 2016 by jake],
>   part of "Announcements" (http://lwn.net/Articles/695980/) section
>   of LWN.net Weekly Edition for August 4, 2016
>   (http://lwn.net/Articles/695974/)

Thanks for this. Maybe you could just add those in a pull request or a
patch to the "Git tools and sites" sub section just after the item
about public-inbox?

Thanks anyway!
