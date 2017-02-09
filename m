Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13661FC46
	for <e@80x24.org>; Thu,  9 Feb 2017 10:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdBIKpy (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 05:45:54 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33386 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbdBIKpx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 05:45:53 -0500
Received: by mail-lf0-f66.google.com with SMTP id x1so11694514lff.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 02:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zU5Ku5PQ/2rvDgxOHw8hX7naNZhWzJIZNMuncs2qSiY=;
        b=rhtnvo1TstWfwpAcufNne/prgZdIm1Vkyyo/ot7v9Rn0T51Sv0BfGrwDs2FnraWQya
         SvwNpBIZ1m/oxM8wTXwkCeKrdniZFRQZh+Vpedb+qHIIthhHHpDFy+bN1oVIMKkdMMf9
         3wl+8UqUMG8m/9AgohVgBnHt2w8s8HxxJmn44IkjykAO2huDUsGzWvsA8Zp+pbHgY1xb
         eS9kElHVNrh9jUGQiElNGg5H2ZTK4Lzlp/WyHYdrMXJtRvdZ3Mr1b1uwPKHBOPS6JLJI
         cNYlw2+WMfa6Jyt7o9zbWoZumyZtJKbfNe/nb1OZ2yYqHSuukZTiL+0xptfNpeJm3zh8
         QXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zU5Ku5PQ/2rvDgxOHw8hX7naNZhWzJIZNMuncs2qSiY=;
        b=qBTP+UytINS4pT/XqtAEfBsJA7y9995ruzyxIy2ivyN2mtTz1iZ52Fi7T0t6f+lXhs
         ipF39g65AQCZzGeWSAaFkRsdpzPYng/AKPeZ4NNGfPIbjrQlH+uM9tmrWDnLWg1cbpFP
         46/DQTs5T7GUN1wViPpLPbyzNwYcbmSja+utzY0Y9E5OJqWygrjTpdvU1MPWj/j9OjeP
         QgCSUB6b5Bw1981MDPnLjZgCLHJv2yvVSmUXSu/Ap6qzbkAwB+qQJDMQs7GJE9+0hXNl
         GLqZZhM1TH36j8B4coIC7cYZRjHtN84N5hm7O3bgKo05WySG/gJg9QOGbr0mDGZ7mH+F
         cE7A==
X-Gm-Message-State: AMke39nBuqZ0TDkTms4JEcsv5D1m8wwpkrJIqCAIO3XLC7Ca8K2IynA32H3H+xizKq0zZtBPHAMwaHHCdijFew==
X-Received: by 10.46.69.139 with SMTP id s133mr941593lja.56.1486637145936;
 Thu, 09 Feb 2017 02:45:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Thu, 9 Feb 2017 02:45:45 -0800 (PST)
In-Reply-To: <vpqzihvpt41.fsf@anie.imag.fr>
References: <vpq1svtstud.fsf@anie.imag.fr> <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net>
 <vpq37fowx5q.fsf@anie.imag.fr> <CAP8UFD3aygSf5U2abnpCfRzEf-hH5fSNuzFBBtgCjSQC3F8c5A@mail.gmail.com>
 <vpqzihvpt41.fsf@anie.imag.fr>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Feb 2017 11:45:45 +0100
Message-ID: <CAP8UFD1V=WD-EHkBkAVET9ztvsHZr_S5GVBWrQ6F1e0LwJoksQ@mail.gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 11:15 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Wed, Feb 8, 2017 at 3:54 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> On Mon, Jan 23, 2017 at 04:02:02PM +0100, Matthieu Moy wrote:
>>>>
>>>>> * We need to write the application, i.e. essentially polish and update
>>>>>   the text here: https://git.github.io/SoC-2016-Org-Application/ and
>>>>>   update the list of project ideas and microprojects :
>>>>>   https://git.github.io/SoC-2017-Ideas/
>>>>>   https://git.github.io/SoC-2016-Microprojects/
>>>>
>>>> That can be done incrementally by people who care (especially mentors)
>>>> over the next week or so, and doesn't require any real admin
>>>> coordination. If it happens and the result looks good, then the
>>>> application process is pretty straightforward.
>>>>
>>>> If it doesn't, then we probably ought not to participate in GSoC.
>>>
>>> OK, it seems the last message did not raise a lot of enthousiasm (unless
>>> I missed some off-list discussion at Git-Merge?).
>>
>> I think having 2 possible mentors or co-mentors still shows some
>> enthousiasm even if I agree it's unfortunate there is not more
>> enthousiasm.
>
> A non-quoted but yet important part of my initial email was:
>
> | So, as much as possible, I'd like to avoid being an org admin this
> | year. It's not a lot of work (much, much less than being a mentor!),
> | but if I manage to get some time to work for Git, I'd rather do that
> | on coding and reviewing this year.
>
> and for now, no one stepped in to admin.

Well Peff wrote in reply to your email:

> I did co-admin last year and the year before, but I made Matthieu do all
> the work. :)
>
> I do not mind doing the administrative stuff. But the real work is in
> polishing up the ideas list and microprojects page.

So I thought Peff would be ok to be the admin (do "the administrative stuff").

> Other non-negligible sources of work are reviewing microprojects and
> applications. Having a few more messages in this thread would have been
> a good hint that we had volunteers to do that.

I don't think emails in this thread is what really counts.
I worked on the Idea page starting some months ago, and as I wrote I
reviewed it again and found it not too bad.

>> Someone steps in to do what exactly?
>
> First we need an admin. Then as you said a bit of janitoring work on
> the web pages.

About the janitoring part, as I previously said I am reluctant to do
that as I don't know what Dscho would be ok to mentor.
And I also think it's not absolutely necessary to do it before
applying as an org.

If you just want Peff or someone else to apply, then please just say
it and hopefully Peff will do it and be the admin.
