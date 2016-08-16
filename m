Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1697A1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 17:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbcHPR5D (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 13:57:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35083 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbcHPR5C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 13:57:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so17704627wmg.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 10:57:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Uzwx3wAL4izCze8W1joJLNg0KJarLWYlYjpzh0V+qH0=;
        b=pX6Crhss4geFlBVxxHgvkvOT19CCb70u/IAFIcQuX0gMhmKXV+FDrttKnH0DkutJ7N
         y7S7NwdqHkPmhM8szgpUy7q/uuYvX8lwmMCwNUp15/NlxsQUwEqez9A6XduTKLfgkhcu
         gKpgcCCDWWOSR99N/DSc8/NQXdszuIbqddwu8sue1bmfUWTErcIcu50jTk2OBHfpNu9v
         s9/B/FtoxihUWiHlFYD1cH2XmAW92xC4pCahs0GtQuXdifJrUnz3y97xrFwC5A+raNDw
         ux/REpkbdaXmC+H2yduk4Q+wZ58nCG3yqe0bMZkn0KHlL4SkHBegdZ9MB1MQ5LpgJGKP
         oqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Uzwx3wAL4izCze8W1joJLNg0KJarLWYlYjpzh0V+qH0=;
        b=GVwIdL68/AVn4f8+bIcoAO3fBWmEnqBDZtgKoPzrSXlbPfevcrToZPDzB5hr0WLGlC
         NMsMxIsKdVtxw2fOYXHCpWtSVMYIUpDLOOZ3hlzeO7+UB7scb1NOwHj5ZSCED4DWseIa
         GUmzBlfGN2wghXq5KKjX6JKHgJDUtYyXn43y0DPFxcScoGg65gZ/NjGBTi0+JAdM9zll
         pwlcu6cS/kcLO/bRU4iyMRu79JW1wdsii1fLuyqnml4gynX4bc3YtOgNFlNkY0Rr7GqL
         6IfWfjtZrkmiVX+zK0zam040Vv97NmvrjjJUDQqOGzA2kotq9sCxcJ9HBwzGnP4Bq7Ho
         3f4g==
X-Gm-Message-State: AEkooutPE7kD3sR65HX7I5wAvq35kEA5fYlzcg2IG1AAPeTatIPAFlmlQfmMrX5i1SyNWP6F6Dp2uj6yDmyfWw==
X-Received: by 10.28.103.6 with SMTP id b6mr24099035wmc.89.1471370221116; Tue,
 16 Aug 2016 10:57:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.230.154 with HTTP; Tue, 16 Aug 2016 10:57:00 -0700 (PDT)
In-Reply-To: <xmqq60r0ei9k.fsf@gitster.mtv.corp.google.com>
References: <20160815053628.3793-1-ralf.thielow@gmail.com> <20160816162030.27754-1-ralf.thielow@gmail.com>
 <xmqq60r0ei9k.fsf@gitster.mtv.corp.google.com>
From:	Ralf Thielow <ralf.thielow@gmail.com>
Date:	Tue, 16 Aug 2016 19:57:00 +0200
Message-ID: <CAN0XMOL2WZkh17v-7OtA8AMbzs4NUuj8xPVwJBD-PnK4fBaUFw@mail.gmail.com>
Subject: Re: [PATCH v3] help: make option --help open man pages only for Git commands
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Joseph Musser <me@jnm2.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

2016-08-16 19:27 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>> +
>> +     if (swapped)
>> +             return help_unknown_cmd(cmd);
>
> I am guilty of suggesting "swapped"; even if we are going to mark
> this as OPT_HIDDEN, I think we should be able to think of a better
> name.  I think the meaning of this boolean is "we know that this is
> not a guide and is meant to be a command.", and I hope we can come
> up with a name that concisely expresses that (e.g. "--not-a-guide",
> "--must-be-a-command").
>

I think "--cmd-only" is a good name.  With a good name I think it's worth
to make this option visible to the user.
