Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72AD61F859
	for <e@80x24.org>; Tue, 16 Aug 2016 16:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbcHPQjS (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 12:39:18 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37296 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbcHPQjR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 12:39:17 -0400
Received: by mail-wm0-f52.google.com with SMTP id i5so179961513wmg.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 09:39:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YurkvhAMsbm4Cbb54wghGxu3D32f/Gv/Y4S8ExjJ2U4=;
        b=LMqJ/aLGB+Wu4HixYOe3ZN+EGoHrM1pm278oIUmPBDjh9JBigm+GeCDJQPYYOsDB3b
         BTposYcFZ4mo/6RvXGSd+oTUaGTh4RN+9tRHHMQ5nE/sjG0U+Jl9IPLCm7YpB1feEw38
         PtRAsHAgzPJaLFYmpap8iryCYl7wLAlssRILKqXRoGfLCjOdNk+tLFPeYbcj05r7bKXV
         zupmDgD+RblxC4w1V+ZRr6e9wkmgkP2KE31OqJak9AUbVhF5VB5+Dk4g+BpjjpC7w7Ji
         7nZcOscvzsKk/3N62ULX0VeKLFko0sg6Uh9dDPWzDaRfScWI2gI6tom8MlKkGnuKF43a
         bTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YurkvhAMsbm4Cbb54wghGxu3D32f/Gv/Y4S8ExjJ2U4=;
        b=if7e3pZjBEQ0fT0WRzsAjnxs7kktgvBRBFvr+OGY/jFEwFZiBQpfp2h5qnxPJTm5+v
         ZY596wdJ1FMa404ms/35t0gFKH3adH8Qs/f+ktOncD01OIENS0z5VhsuJauJOmmWg1ki
         6QsOj/ArBLh4A6Ry5W5mfhU4CAPq1Afpox8y3KykKs3DDqM0GMNvR6Uc0e5YqS7ReZs5
         2QxIpCBor0NN4/hty/rTEu2vRdvSW/7O63Vj+tNQVKd5ZBnFNCXNA3Cn05+uYYhzqMgh
         Q2F+5t7+6h35vSgG7J2/6ssHeEg0ood3A4tq28CNRlYTDRaVwMRDe0I8e8XzhKsAe+Pu
         U4jQ==
X-Gm-Message-State: AEkoout439DFjj9MEKrpGiM4z/sD728uEM+c5y1TKYj1BwHkgbo5rePR/oj1x81PZ4iQtb+6xgkgQVjGLUJnWg==
X-Received: by 10.28.61.11 with SMTP id k11mr22685341wma.34.1471365556331;
 Tue, 16 Aug 2016 09:39:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.230.154 with HTTP; Tue, 16 Aug 2016 09:39:15 -0700 (PDT)
In-Reply-To: <20160816163334.xkkuffjwzc6mw663@john.keeping.me.uk>
References: <20160815053628.3793-1-ralf.thielow@gmail.com> <20160816162030.27754-1-ralf.thielow@gmail.com>
 <20160816163334.xkkuffjwzc6mw663@john.keeping.me.uk>
From:	Ralf Thielow <ralf.thielow@gmail.com>
Date:	Tue, 16 Aug 2016 18:39:15 +0200
Message-ID: <CAN0XMO+fikDov1FpOBUbLZUsfQpYtW3DNTEx5Fa0_Cbos4N_cw@mail.gmail.com>
Subject: Re: [PATCH v3] help: make option --help open man pages only for Git commands
To:	John Keeping <john@keeping.me.uk>
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Joseph Musser <me@jnm2.com>,
	Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

2016-08-16 18:33 GMT+02:00 John Keeping <john@keeping.me.uk>:
> On Tue, Aug 16, 2016 at 06:20:30PM +0200, Ralf Thielow wrote:
>>  static struct option builtin_help_options[] = {
>> +     OPT_BOOL('s', "swapped", &swapped, "mark as being called by <cmd> --help"),
>
> OPT_HIDDEN_BOOL maybe?
>

Yeah >_<

Thanks!
