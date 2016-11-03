Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973C52021E
	for <e@80x24.org>; Thu,  3 Nov 2016 14:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754303AbcKCOdQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 10:33:16 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33325 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbcKCOdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 10:33:15 -0400
Received: by mail-lf0-f51.google.com with SMTP id c13so40144969lfg.0
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O7t7wTTiGrITkfaj0939/JbTdTPGFtOvfn9A16B4Fvk=;
        b=mZANn5kmVQvDxu2bC6gIo0lwId2Yp4Sl072lqUimDQbgsb+z/LVXKuTRTXGSTJKp62
         ZqovevbGZnQ+x5NnIQoI0Sa2r2g/A/E4vskCwvfun9dRK6v3NOXHSrTGkvK+qLuOnpTR
         5A3SFFb3RIejdwlDhTVgAIdVEQkvjucW0lAgH5edJIyENlYSq+A0ngEXT9BbnoBmutIU
         yuJAUsUfc8OKMrLRCQ69rPbq+WQJdeIVRcU4utD7J7hEloAiDzKTaNQFQsmaYeqTUJO+
         R6nwB2mI9YBAJaV16248kncMByi23EYMzW72UegIclybnMLUHBWEa9VxcXlL4+MCafGC
         VPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O7t7wTTiGrITkfaj0939/JbTdTPGFtOvfn9A16B4Fvk=;
        b=NYguI9VNihR7SkI8pYg5NMda6JuYumlE11A+fK+vA+xeFBeW7UUQ3avfJPGsEyGP7G
         vd5W2qf8NL972R5yUHJMUunV7XErW1fy6NOk/wvZ/8y1pGSvxGRjeANEk68svdIDHqgS
         /LCt28/b09IFvUgIfjWwNVmf7+kwkdg65/R9JLBQO5v8fSYuhis2eTl779HA/Pp37Px+
         gh2nKh7r2OBHAWFvPZIjel21qGRok8Tfl7j3Gpc/Mr0lbrrV4c0xuhEWwACA/G7ddhIS
         ls/299xqc2WNXiciWR9+0yL2UHnGW6cB/IJwPtcNx4gGP/tgdYsTbfZE+BlGdXryjhRR
         tuXQ==
X-Gm-Message-State: ABUngvfUTmUY4qZsPa3KptolrxHecQ3DJQbh5/DTHEXGG9YVwt7ytnex3NE76H4nEBFv9ZFmRCbQ1EhlxcmLwQ==
X-Received: by 10.194.106.197 with SMTP id gw5mr9191680wjb.88.1478183593646;
 Thu, 03 Nov 2016 07:33:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.184.117 with HTTP; Thu, 3 Nov 2016 07:33:12 -0700 (PDT)
In-Reply-To: <20161103141848.42pg6iow24prign5@sigill.intra.peff.net>
References: <20161102202709.GI4611@redhat.com> <20161102211118.sc4j3fezfqxg23i3@sigill.intra.peff.net>
 <20161102213805.GJ4611@redhat.com> <20161102220437.5ewzezxs2nasyouv@sigill.intra.peff.net>
 <20161102222901.GK4611@redhat.com> <20161103141848.42pg6iow24prign5@sigill.intra.peff.net>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 3 Nov 2016 15:33:12 +0100
Message-ID: <CANgJU+X9YVcynHfx7nvedBKxDp6+2_S07_whMCSCtq6YrHMnJw@mail.gmail.com>
Subject: Re: send-email garbled header with trailing doublequote in email
To:     Jeff King <peff@peff.net>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 November 2016 at 15:18, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 02, 2016 at 11:29:01PM +0100, Andrea Arcangeli wrote:
>
>> So this must be postfix then that out of the blue decided to garble it
>> in a strange way while parsing the input... The removal of all
>> whitespaces s/what ever/whatever/ especially I've no idea how it
>> decided to do so.
>>
>> Can you reproduce with postfix as sendmail at least? If you can
>> reproduce also see what happens if you add another --to.
>
> Yes, I can easily reproduce without using git at all by installing
> postfix in local-delivery mode and running:
>
> sendmail peff@sigill.intra.peff.net <<\EOF
> From: Jeff King <peff@peff.net>
> To: "what ever" " <peff@sigill.intra.peff.net>
> Subject: patch
>
> This is the body
> EOF
>
> Many MTAs do this kind of header-rewriting. I don't necessarily agree
> with it as a general concept, but the real problem is the syntactically
> bogus header. The munging that postfix does makes things worse, but I
> can see why it is confused and does what it does (the whole email is
> inside a double-quoted portion that is never closed, so it probably
> thinks there is no hostname portion at all).
>
> So git is possibly at fault for passing along a bogus address. OTOH, the
> user is perhaps at fault for providing the bogus address to git in the
> first place. GIGO. :)
>
> I think if any change were to be made, it would be to recognize this
> bogosity and either clean it up or abort. That ideally would happen via
> Mail::Address so git does not have to add a bunch of ad-hoc "is this
> valid rfc822" checks. Reading the manpage for that module, though, it
> says:
>
>   [we do not handle all of rfc2822]
>   Often requests are made to the maintainers of this code improve this
>   situation, but this is not a good idea, where it will break zillions
>   of existing applications.  If you wish for a fully RFC2822 compliant
>   implementation you may take a look at Mail::Message::Field::Full, part
>   of MailBox.
>
> So it's possible that switching to a more robust module would improve
> things.

There is an RFC2822 compliant email address validator in the perl test
suite if you guys want to use it.  We use it to test recursive
patterns.

http://perl5.git.perl.org/perl.git/blob/HEAD:/t/re/reg_email.t

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
