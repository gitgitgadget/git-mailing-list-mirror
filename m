Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903BA1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 05:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbeC0FLv (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 01:11:51 -0400
Received: from mail.javad.com ([54.86.164.124]:44656 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750978AbeC0FLu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 01:11:50 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 7BE9B3EA25;
        Tue, 27 Mar 2018 05:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127509;
        bh=mN+glT06uNC/9MGL/ia0YVd5bpPHr/i3dyqW1k3pI00=; l=1661;
        h=Received:From:To:Subject;
        b=Fk9XEhB6x+oy99sC4HGQlUSfGqVVrfs5QySHxuluztG/wam2XBb7XQwyBfsssE+Np
         sc/4OrK1BKDVn97kfoyMmN8+IgXTEIq3V4MpNCD0SiN3v61IJ8xIpEe2Gf73Yrul2M
         NHsaCsERgahwvVRndRa+YmpkWXawFQQtdZrYQPa8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127509;
        bh=mN+glT06uNC/9MGL/ia0YVd5bpPHr/i3dyqW1k3pI00=; l=1661;
        h=Received:From:To:Subject;
        b=Fk9XEhB6x+oy99sC4HGQlUSfGqVVrfs5QySHxuluztG/wam2XBb7XQwyBfsssE+Np
         sc/4OrK1BKDVn97kfoyMmN8+IgXTEIq3V4MpNCD0SiN3v61IJ8xIpEe2Gf73Yrul2M
         NHsaCsERgahwvVRndRa+YmpkWXawFQQtdZrYQPa8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127509;
        bh=mN+glT06uNC/9MGL/ia0YVd5bpPHr/i3dyqW1k3pI00=; l=1661;
        h=Received:From:To:Subject;
        b=Fk9XEhB6x+oy99sC4HGQlUSfGqVVrfs5QySHxuluztG/wam2XBb7XQwyBfsssE+Np
         sc/4OrK1BKDVn97kfoyMmN8+IgXTEIq3V4MpNCD0SiN3v61IJ8xIpEe2Gf73Yrul2M
         NHsaCsERgahwvVRndRa+YmpkWXawFQQtdZrYQPa8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127509;
        bh=mN+glT06uNC/9MGL/ia0YVd5bpPHr/i3dyqW1k3pI00=; l=1661;
        h=Received:From:To:Subject;
        b=Fk9XEhB6x+oy99sC4HGQlUSfGqVVrfs5QySHxuluztG/wam2XBb7XQwyBfsssE+Np
         sc/4OrK1BKDVn97kfoyMmN8+IgXTEIq3V4MpNCD0SiN3v61IJ8xIpEe2Gf73Yrul2M
         NHsaCsERgahwvVRndRa+YmpkWXawFQQtdZrYQPa8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127509;
        bh=mN+glT06uNC/9MGL/ia0YVd5bpPHr/i3dyqW1k3pI00=; l=1661;
        h=Received:From:To:Subject;
        b=Fk9XEhB6x+oy99sC4HGQlUSfGqVVrfs5QySHxuluztG/wam2XBb7XQwyBfsssE+Np
         sc/4OrK1BKDVn97kfoyMmN8+IgXTEIq3V4MpNCD0SiN3v61IJ8xIpEe2Gf73Yrul2M
         NHsaCsERgahwvVRndRa+YmpkWXawFQQtdZrYQPa8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127509;
        bh=mN+glT06uNC/9MGL/ia0YVd5bpPHr/i3dyqW1k3pI00=; l=1661;
        h=Received:From:To:Subject;
        b=Fk9XEhB6x+oy99sC4HGQlUSfGqVVrfs5QySHxuluztG/wam2XBb7XQwyBfsssE+Np
         sc/4OrK1BKDVn97kfoyMmN8+IgXTEIq3V4MpNCD0SiN3v61IJ8xIpEe2Gf73Yrul2M
         NHsaCsERgahwvVRndRa+YmpkWXawFQQtdZrYQPa8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127509;
        bh=mN+glT06uNC/9MGL/ia0YVd5bpPHr/i3dyqW1k3pI00=; l=1661;
        h=Received:From:To:Subject;
        b=Fk9XEhB6x+oy99sC4HGQlUSfGqVVrfs5QySHxuluztG/wam2XBb7XQwyBfsssE+Np
         sc/4OrK1BKDVn97kfoyMmN8+IgXTEIq3V4MpNCD0SiN3v61IJ8xIpEe2Gf73Yrul2M
         NHsaCsERgahwvVRndRa+YmpkWXawFQQtdZrYQPa8=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f0gtf-000092-RS; Tue, 27 Mar 2018 08:11:47 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
        <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
        <1c912980-8ce8-6281-fa99-040a5e3e1103@talktalk.net>
        <nycvar.QRO.7.76.6.1803061829460.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87h8pscw0r.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803070756550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87ina8ymxs.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803080741160.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87vae1h3uo.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803261333500.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 27 Mar 2018 08:11:47 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803261333500.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Mon, 26 Mar 2018 13:37:57 +0200
        (DST)")
Message-ID: <87in9igl0s.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Sergey,
>
> On Mon, 12 Mar 2018, Sergey Organov wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >
>> > On Wed, 7 Mar 2018, Sergey Organov wrote:
>> >
>> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >> 
>> >> > How can your approach -- which relies *very much* on having the
>> >> > original parent commits -- not *require* that consistency check?
>> >> 
>> >> I don't understand what you mean, sorry. Could you please point me to
>> >> the *require* you talk about in the original proposal?
>> >
>> > Imagine a todo list that contains this line
>> >
>> > 	merge -C abcdef 123456
>> >
>> > and now the user edits it (this is an interactive rebase, after all),
>> > adding another merge head:
>> >
>> > 	merge -C abcdef 987654 123456
>> >
>> > Now your strategy would have a serious problem: to find the original
>> > version of 987654. If there was one.
>> 
>> We are talking about different checks then. My method has a built-in
>> check that Pillip's one doesn't.
>
> Since you did not bother to elaborate, I have to assume that your
> "built-in check" is that thing where intermediate merges can give you
> conflicts?
>
> If so, there is a possibility in Phillip's method for such conflicts, too:
> we have to perform as many 3-way merges as there are parent commits.
>
> It does make me uncomfortable to have to speculate what you meant,
> though.

It doesn't matter anymore as this check could easily be added to
Phillip's algorithm as well, see [1].

[1] https://public-inbox.org/git/87efkn6s1h.fsf@javad.com
