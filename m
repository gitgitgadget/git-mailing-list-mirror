Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601722022A
	for <e@80x24.org>; Mon,  7 Nov 2016 20:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbcKGUrw (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 15:47:52 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33204 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbcKGUrv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 15:47:51 -0500
Received: by mail-pf0-f169.google.com with SMTP id d2so95791588pfd.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 12:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=th4Df4cOugrWpk9ke2VjOM5bCn/PYIRdtYq45cRTYmg=;
        b=lMMIjw0OES+oThhb7zxrRC8+R8PKwAdw8KhKx81j9jfb4ja/uytE7uhPSzvuxm9QMA
         J5qov/pzpwwNjD018r9OUEF3sPx0p6NAU7cNlw0eEaHc+FYTJGJBQZCbmqFnLR0HD52w
         pfRp8+1bBkPVaj+WrwhqaRMI+hOmMt8uadiZGw2trPb29ywjqlH7Yr8eCtxRzhGDTRRC
         XvKnTldCEqaTbv40xHShit/rCkVtva1mX46gXZQOV9hdnfKYWR5NTXoC3fBDK/taOi51
         IW9IssSc1S7OAfIUqgb9aR2Bz5jnx6hUAb94igd254RQlst16OtG0PFw0XUDkLh0b3nz
         CP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=th4Df4cOugrWpk9ke2VjOM5bCn/PYIRdtYq45cRTYmg=;
        b=WfDcCFRdQ/cn3029ZB67omeTTaUIoXfAUu9x3fCIW2Gph7Dq8nl1Mq5WWF09EzRuAM
         GvaJGepSt5CSKqY+JTlqeaEYkMuOoPvrr3zgu4/OqK2BRLN5LFd3Yb3hGkGcAnuFuuKG
         B+cespLm4wNkyhEtvdu4U1ss9Ed4GYpKYD4QQyGNgjl6mpTKxMjS4ZmCsvISBaCfRV83
         nV1IOuZdN2/Ub4lpcO92PGJdD2i1OJ5q1kKu3WvPpFOPgmUK7bU1cR+mnTIoDiDkw/V0
         VUBmYk1MtZpNZsopDKtwzDhphFHg9TJrY6Gp3BGqOYgNbNzRlfY1EZGpbQrD9VoMao/W
         Uumg==
X-Gm-Message-State: ABUngvehv+vblHqU/CMoevOQ9IlQFBysezs/obD0RT6SMkFXHc38tyFP+47q4RX8zLlk2Vsg
X-Received: by 10.98.160.29 with SMTP id r29mr16903167pfe.103.1478551230861;
        Mon, 07 Nov 2016 12:40:30 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:bd82:3124:1b9:77b4])
        by smtp.gmail.com with ESMTPSA id r2sm42548384pfi.67.2016.11.07.12.40.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Nov 2016 12:40:30 -0800 (PST)
Date:   Mon, 7 Nov 2016 12:40:28 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v4 1/2] lib-proto-disable: variable name fix
Message-ID: <20161107204028.GC143723@google.com>
References: <1478292933-7873-1-git-send-email-bmwill@google.com>
 <1478547323-47332-1-git-send-email-bmwill@google.com>
 <20161107202637.ooaddlkfntw37xg3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161107202637.ooaddlkfntw37xg3@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07, Jeff King wrote:
> On Mon, Nov 07, 2016 at 11:35:22AM -0800, Brandon Williams wrote:
> 
> > Small fix to use '$desc' instead of '$1' in lib-proto-disable.sh.
> 
> Even for a trivial fixup like this, I think it's good to say why.
> Because what seems trivial and obvious to you while working on the patch
> may not be so to a reviewer, or somebody reading it 6 months later.
> 
> Just something simple like:
> 
>   The test_proto function assigns the positional parameters to named
>   variables, but then still refers to "$desc" as "$1". Using $desc is
>   more readable and less error-prone.
> 
> -Peff

Alright will do.  Commit messages don't seem to be an area of strength
for me, but I'm working on it! :D

-- 
Brandon Williams
