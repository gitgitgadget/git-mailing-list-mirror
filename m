Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B05D01F404
	for <e@80x24.org>; Thu,  6 Sep 2018 09:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeIFNuR (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 09:50:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39404 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbeIFNuR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 09:50:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so1577343wrw.6
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 02:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=34KJeOpu5IRyN06JSSut2k+xv78QydK1q6hGxre8J2k=;
        b=DC2f0ebzxOezvo+sBbXyL9am+PgYQ4CmMkUpQld71uLOqXPtVcbm9HzNbrok82MGRU
         vBAHSp4m0ZSOq3qdL8xmUmMNy+9l469nfC/ceI/K0v8j7RYr7xp06t5dJHmdeFumXaRQ
         NHB/S/dJdwnyoObTQo2Oh9dLT7XNGt97cxMK8Pwjp2sp2HNB03hKS2wJcJG4dg8ZxtZ0
         yrBuA0zYDbT1fWI4AQ6+HcUGkLXAZjPpYKwYMEVQ3pd/vIcvkOSc9kpEYrfN8L2/aoMT
         nyBgyKqX4aF4fTl3a+BU7Jc3RKVcEXjw752trpYZ7HY3LPxigJa4skkDGauaD3/HdbHR
         5Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=34KJeOpu5IRyN06JSSut2k+xv78QydK1q6hGxre8J2k=;
        b=uC1gnjwZ57sJkJuTtZIOmebxxo+6wxPMxAIJno6kLpHd7FF2KKMvdXYITzHcYa84ab
         qM0Zr/Lgje+AxGk1GzSqXywXcl/m6QJxY91o5kEQvoTkafrInjbbkS/vPGilZIKtpDb5
         pDxRdWYr7vKdsIgB4PucZ66j3M7resxbcfTK7PHbgOQ+aMqwCnCqVcFMLL66xIntAXtc
         l4IlOVxg7dxywPbnX9Ghrxfola6vA/O4VOl2BMwwM/n4u3ub1VJrbFQD5o26zTLykDtd
         Sb7ygI4rzasTwNkAgHepc4wMU12Kus+n8PeJD4U7SvFYDNZQiW2HPAH7sH6sHQy9+2lJ
         Yyww==
X-Gm-Message-State: APzg51CLmMHahzfYf0OHQnPAGRWjZtLfPuMjMXaMPvUwDP4y9gYQbWLt
        oyM0ZNWzTUtIU+ncERBwqi4=
X-Google-Smtp-Source: ANB0VdbaPuZXxZBw8Hr9VWZcZaNC6ujqKPJ+lzPBfIx/plZJWI+iQh4L31W4wlJUX35/f7kUyk6fGg==
X-Received: by 2002:adf:c64e:: with SMTP id u14-v6mr1468614wrg.177.1536225345613;
        Thu, 06 Sep 2018 02:15:45 -0700 (PDT)
Received: from localhost (x4db1b35b.dyn.telefonica.de. [77.177.179.91])
        by smtp.gmail.com with ESMTPSA id r140-v6sm6302799wmd.7.2018.09.06.02.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 02:15:44 -0700 (PDT)
Date:   Thu, 6 Sep 2018 11:15:39 +0200
From:   SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC PATCH 4/5] t1700-split-index: date back files to avoid racy
 situations
Message-ID: <20180906091539.GA8805@localhost>
References: <20180906024810.8074-1-szeder.dev@gmail.com>
 <20180906024810.8074-5-szeder.dev@gmail.com>
 <871sa7rr30.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871sa7rr30.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 10:02:43AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Sep 06 2018, SZEDER Gábor wrote:
> 
> > +# Create a file named as $1 with content read from stdin.
> > +# Set the file's mtime to a few seconds in the past to avoid racy situations.
> > +create_file () {
> 
> Nit: Would be easier to read in the future as
> e.g. s/create_file/create_old_file/ or something like that. I.e. so you
> can see at a glance from the tests themselves what this is doing.

Perhaps; but then I'm not so sure about 'old', because that's just a
property of the resulting file...  I'm inclined to rename it to
'create_non_racy_file' to also imply "why" this function is used
instead of plain old '>file'.

