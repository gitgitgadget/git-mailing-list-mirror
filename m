Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F7620323
	for <e@80x24.org>; Tue, 21 Mar 2017 10:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756790AbdCUKwC (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 06:52:02 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:35342 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbdCUKwB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 06:52:01 -0400
Received: by mail-ot0-f173.google.com with SMTP id x37so149406338ota.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/Suzr+F4PuK2P1As95BmcMy+iVBLzgykr0dDyFad8JE=;
        b=bug64iTMYazqXRXqo8dfw2Ytizy8sChyQdla0Q3D1IzMbrRFA43GIaVXZc5gaSZ54k
         g8z62w959PRHPgScif78m+0WFeCBi6wRnSR8hUuozEjOgSSER2f9UXULQLeTm6H6Epry
         i+o5WdhnmGPsDupEdyJYIvoNsW4fySFo1QcUEuluSq1OEXAfgNiF/ve+QHPOMeEqacdy
         FvcudjR3KXsXIr0RqA2ZOojq6P6esRqJwgb64Ho/HsWoe8I3e0nQT78wJpoTPjuhDuxi
         QLA1M+4ihX6Op8Kyf1QdvFUb5dlV3A5auIniFKS2FlfGyXB5S6/gx4NJWJD+W8MEX3uj
         gDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/Suzr+F4PuK2P1As95BmcMy+iVBLzgykr0dDyFad8JE=;
        b=TyqjxzlNiCTTjD2cSTvsB5T5Bmc4hNrBA1eI9E/pRKPmIF7BEaWPc4Jn4J7znJ9ULy
         GVah50ZjD9bdy1IvNNh7yIXRKDDloURhz3+WivFpaTE8tWxXmfz+78weqS+C3J6HssN9
         kE38daYl//moSCrfNWugeyw81wlJE1jFyF3+BBoJMt5ExwiPLnUmEfrUqHXgadI92cBK
         gpz4DFdqN38OsqWYgm3HK5jLN+2eLmJc5LFbXZhHeXWw9kU3Z8Dg57hR8MYY7ZnrlFJ+
         W50nvicymuMV8Ixh02ZTdXrNJsp1kJ4aPr/ucdWErHJ9VPofLqox4BFUHWQgSL+ZlaRH
         4JdQ==
X-Gm-Message-State: AFeK/H2mUGoAJ/3/WRjWHKcAw/3kHlaYyTJcILrfWzq5g3cF8mB3UcAubhjWL0L5A2t5k+daDO13/kP/bn3fbg==
X-Received: by 10.157.46.137 with SMTP id w9mr19378617ota.225.1490093519723;
 Tue, 21 Mar 2017 03:51:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 21 Mar 2017 03:51:29 -0700 (PDT)
In-Reply-To: <20170313182322.27539-1-bmwill@google.com>
References: <20170310185908.171589-1-bmwill@google.com> <20170313182322.27539-1-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 Mar 2017 17:51:29 +0700
Message-ID: <CACsJy8BRTuH=xv_xvQPOkVaRcMXKnjgT77SXkwLkZ6aAvcTyHg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] bringing attributes to pathspecs
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 14, 2017 at 1:23 AM, Brandon Williams <bmwill@google.com> wrote:
> v3 fixes some nits in style in the test script (using <<-\EOF instead of <<-EOF)
> as well as fixing a few other minor things reported by Junio and Jonathan.

I'm slowly digging through the pile of mails in the past weeks... I
know this has landed on 'master' (thanks!). Just wanted to check
something.

The series updated match_pathspec(), but that's only one of two
pathspec filtering functions. The other is tree_entry_interesting()
(e.g. for "git grep <tree>"). Do you have plans to support :(attr)
there too? "No" is a perfectly fine answer (and it will end up in my
forever growing backlog).

The thing about tree_entry_interesting() is, we would want to stop
traversing subtrees as soon as possible. Naively implemented, we would
need to traverse all subtrees so we can call match_attrs(). That's not
great. Oii I'm rambling.. I don't know yet how to implement this thing
efficiently.
-- 
Duy
