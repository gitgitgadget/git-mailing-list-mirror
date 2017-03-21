Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890EE2095D
	for <e@80x24.org>; Tue, 21 Mar 2017 16:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933077AbdCUQ41 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 12:56:27 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33646 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932542AbdCUQxr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 12:53:47 -0400
Received: by mail-pf0-f170.google.com with SMTP id o190so574809pfo.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jZbCEgIGN7y/8cJmjPg+pDKYNjlZSm0LWK6hdddtmcU=;
        b=OpMTKzCOEPiVBWWJA4FLckCEDRqDqVxTBtv47E7rzMQyZ5R4LMx0XR4hKOFg4fb3Be
         BBDKtiK7dZsJ/V7+zUMTX+8qZDYUItwoMgcZTizx5jPupzCj5bdVxi5Y6S8Sw4nCQkdA
         hnDNf+oZ2X3kuhryzhVveLK6Ge3le5YuyUjPFpVYdvt+ZtWtHx57uOilPrTVAczknLcL
         MK1kdu4BZhGDQ2aUlFoUuP/ohoGnz1MDZ5/HHgFc6saVwk2pSLRQ6sJzwbhq+FZQ7GME
         5MeVAS99HoXqjlZeT4UGrooxjFlKDARlLbjL8avLieBIwBY5PPGrCES7/SFJOrk+bJlb
         VcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jZbCEgIGN7y/8cJmjPg+pDKYNjlZSm0LWK6hdddtmcU=;
        b=ZFJovSZfj6+tHwWW+5mznbUC2wL2br8tcoU0St7pM0B2xAj1h+NLCRgC8VWz7ld3dK
         Bam74FTjceLMJhv2bEOSJK+QIO2jONdKdk4F9N8mHDQ9IHCqh3Y3Hvz9Jt23Sf1vId7H
         fwjCm6dCdChSclQbO3r3JcOlmf/m1jvBPGNX+e5wNqkGlp9PQyYQyek6/fJDQpop5H7F
         40BOOEavHyJHvH3f8wDR6AG/l/Jwu9MYf0NzVqCJ4Kx7HrQRfPantJtTGR5rRFMCdOiY
         MxzDbLe9DButkur3VrAkJ6zq4NMKIhHtHdRDEN90U73jaaSZev++97O538CDTgPRXeCk
         9xhg==
X-Gm-Message-State: AFeK/H0sCWWh3P6kIMjf5raUiJ1+PGGdY5UopNwy6265ycYZ+C9p+bqmyOumpg10jTURaY/H
X-Received: by 10.98.99.196 with SMTP id x187mr40304440pfb.168.1490115176455;
        Tue, 21 Mar 2017 09:52:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:80cd:f43f:14c6:a9dd])
        by smtp.gmail.com with ESMTPSA id y70sm11747900pfa.96.2017.03.21.09.52.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 09:52:55 -0700 (PDT)
Date:   Tue, 21 Mar 2017 09:52:54 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com
Subject: Re: [PATCH v3 0/2] bringing attributes to pathspecs
Message-ID: <20170321165254.GA12937@google.com>
References: <20170310185908.171589-1-bmwill@google.com>
 <20170313182322.27539-1-bmwill@google.com>
 <CACsJy8BRTuH=xv_xvQPOkVaRcMXKnjgT77SXkwLkZ6aAvcTyHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BRTuH=xv_xvQPOkVaRcMXKnjgT77SXkwLkZ6aAvcTyHg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/21, Duy Nguyen wrote:
> On Tue, Mar 14, 2017 at 1:23 AM, Brandon Williams <bmwill@google.com> wrote:
> > v3 fixes some nits in style in the test script (using <<-\EOF instead of <<-EOF)
> > as well as fixing a few other minor things reported by Junio and Jonathan.
> 
> I'm slowly digging through the pile of mails in the past weeks... I
> know this has landed on 'master' (thanks!). Just wanted to check
> something.
> 
> The series updated match_pathspec(), but that's only one of two
> pathspec filtering functions. The other is tree_entry_interesting()
> (e.g. for "git grep <tree>"). Do you have plans to support :(attr)
> there too? "No" is a perfectly fine answer (and it will end up in my
> forever growing backlog).
> 
> The thing about tree_entry_interesting() is, we would want to stop
> traversing subtrees as soon as possible. Naively implemented, we would
> need to traverse all subtrees so we can call match_attrs(). That's not
> great. Oii I'm rambling.. I don't know yet how to implement this thing
> efficiently.

I expect that this should be supported in tree_entry_interesting() at
some point, though I didn't have any immediate plans to do that yet.
One reason for that is I just haven't thought through all the cases to
make it performant (as you've pointed out).  So for now it'll probably
be appended to the backlog (yours, mine, or both) and if there ends up
being a larger demand for it then we can increase the priority for it.

-- 
Brandon Williams
