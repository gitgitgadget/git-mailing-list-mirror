Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349E41FD99
	for <e@80x24.org>; Thu, 18 Aug 2016 06:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbcHRGKw (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 02:10:52 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:34343 "EHLO
	mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbcHRGKv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 02:10:51 -0400
Received: by mail-yb0-f171.google.com with SMTP id d10so2761678ybi.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 23:10:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iaeL0KU1GSEeuoJ8w902ONphGlAWu/UFyCxVK/xD0aM=;
        b=AeKqSQ9MhKFydgBhuCw9RtaY9r4Izj6DTwD4BHE/xMcEkaFoHchJgXJsjhVUIXdJho
         Cp8ctreQbyDPC8TarwbraoihdfbA3UhQ7LFnX3rkudBx3NmPaT3ZwM0OjOPzlsjb7vuT
         pYXZoFauPaNZavh2XE3pra5/DL9yBygNKhbA06gM1HdlDnoJGmRJQ5IQlfV1VDxW7aer
         8gp7aMnk4W4E3ZeKKz4ljICZO7kZ/ciSsYsCPz8zzjuaj8CJAhghdTTFLB0nfMH+dvE5
         JGDbI5uAL9KEy7vs2Oh2fz7Sb4K5nkc9m74I1qqXrJJAb+2H2PPOW9wiAq4A2L7qsMUk
         M7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iaeL0KU1GSEeuoJ8w902ONphGlAWu/UFyCxVK/xD0aM=;
        b=E0dA/m9+gtfr6lZ4mdxcJTVaWbsX3AhEEHasse1fTWyXPBdtIDwiq1uE4H7gHk4KzB
         r6z11IUB8GVohQpR1+QNvg/QVwg2dnfa2ijMY9D0jNrSvwMvWvCtx6JlfLZzww0ZIPLI
         BxUXz/bSvVqHd8Uh0Jn4oC4lKzJLfsCwzmMGYhQSYYx/HoHHM2d8m4HrzXYAFBt/Q70z
         MLS1wrUhEYiPcnqnSipb6EnPxhOS59RCizjbgjsiGJj7mz1zqmZKc6lZxR9oHi9HTaUZ
         pSKPAWK6sPppz4m1enzFsulAhSNk9XofwAHfmqocHDFG2xpxj9cys6i7DeOvpgP2oaNu
         1Qcw==
X-Gm-Message-State: AEkoouu3AUVAZJm3c1IJ/w9qRlMG48F5uCou/NnkoeOsDt7nH0YLfvsiyOD4tVWyXmqbt1QXr0MC7kzTt2f4Hg==
X-Received: by 10.37.97.149 with SMTP id v143mr367940ybb.164.1471500637669;
 Wed, 17 Aug 2016 23:10:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Wed, 17 Aug 2016 23:10:17 -0700 (PDT)
In-Reply-To: <xmqq4m6j81ci.fsf@gitster.mtv.corp.google.com>
References: <71d05705-792f-8bb9-026b-5b9251b104b9@tobiah.org> <xmqq4m6j81ci.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Wed, 17 Aug 2016 23:10:17 -0700
Message-ID: <CA+P7+xpCWF9scST4bPYy61=6R8Givaw01DT7r4gOfk+shwWSYg@mail.gmail.com>
Subject: Re: Working from different machines.
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Tobiah <toby@tobiah.org>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 17, 2016 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If the answer is "yes", then you are in the problem space that
> Git-the-tool is interested in solving.  Assuming that you have
> network connection into 'desktop' from 'home', the solution would
> involve making it the first thing to do when get home to run "git
> fetch" on 'home' to get the latest state from the 'desktop', and run
> "git push" on 'home' to push out the latest state to the 'desktop'
> before you leave 'home'.  If your 'server' is for your sole use, and
> if 'home' has network connection into 'server', then you could
> instead rendezvous at 'server' by running "git push server" on
> 'desktop' (or 'home') to 'server' as the last thing before you leave
> 'desktop' (or 'home'), and running "git fetch server" on 'home' (or
> 'desktop') as the first thing before you start working on 'home' (or
> 'desktop').
>
>

To add to this, you may need to modify the "git push" portion of the
phases and the "git fetch" potion to include all the branches you are
interested in.

Thanks,
Jake
