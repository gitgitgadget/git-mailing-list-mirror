Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F39DA201A4
	for <e@80x24.org>; Thu, 11 May 2017 21:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756357AbdEKVuI (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 17:50:08 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35281 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756339AbdEKVuI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 17:50:08 -0400
Received: by mail-pf0-f179.google.com with SMTP id n23so15039235pfb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 14:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NPNk/3I10b3T1Om8m4rFSpTGN45EBfHva5EdLh30bhw=;
        b=bwXw7IyZqKB5d5yaY5pSfSQdLI00sNpf2ool5ArOlK/lOrbfkMwd+cyAlfPRLSodLJ
         ooTwOL7kBU8Nf9+QBeT56GF0uB0met3btemUs2clPoN8ANF9zLZyy+zLdFu5akI+ncsP
         G0aXUv7FsWK7odSyJELhcX+GhOeZN24liptkkFflP+7LYHQ+vRZX287Pknwrd/CiwW8a
         /KvWjETBMsOorOMTZXr/3WYe/FFgpDSCrvGt/d5jFOe4uDgAfGlUwBDviMV53SUocFRm
         oM4rx6sFK1CbyvNHmRPkd5geSquMtFbRQEtYFxXouGpuxyzh0LiGdXE31PHWzJYEea4b
         4SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NPNk/3I10b3T1Om8m4rFSpTGN45EBfHva5EdLh30bhw=;
        b=Dj9f+3coHc9eunKHtYYpwciHrYkekN14ZWh/VLH5WTQJM9jkyCge5CcRaFBhlYUdjd
         w+k3UKMKFEShT7qsMLqGqDUoOIILVlFeYU1skdTocgQ/rh0c3feGdROtrYiKUwFell3e
         +HzGcAIrppnJhJI532svT+9F+FI0PSDxEdyIcshx6qru4o5SfrUc+tpcn6DUkg4OPped
         hMYX2EFoJb9eB8M7yvwPcMlfLdsKMlZG1LxuefWq0d6f+4w3tPpV4TXSBwlLP455HQ6b
         RO5EYTCDRfvA2WHa1XFMqvbWQmub2vtM494y59lZqTx/UtFuxl5vIzt8rxmjAXXodA9L
         nylg==
X-Gm-Message-State: AODbwcAoUMKGhdlA4LHcN67FlqtYD6yr/koiEdz02lVu5bS4+Ar9hNso
        KmemhAJOU+d5HT8r
X-Received: by 10.99.126.92 with SMTP id o28mr680937pgn.63.1494539407289;
        Thu, 11 May 2017 14:50:07 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id r90sm1829863pfl.82.2017.05.11.14.50.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 14:50:06 -0700 (PDT)
Date:   Thu, 11 May 2017 14:50:05 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] C style: use standard style for "TRANSLATORS" comments
Message-ID: <20170511215005.GN83655@google.com>
References: <20170511204334.GM83655@google.com>
 <20170511212012.6782-1-avarab@gmail.com>
 <20170511214125.GB21723@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511214125.GB21723@aiede.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Jonathan Nieder wrote:
> Hi,
> 
> Ævar Arnfjörð Bjarmason wrote:
> 
> > Change all the "TRANSLATORS: [...]" comments in the C code to use the
> > regular Git coding style, and amend the style guide so that the
> > example there uses that style.
> 
> Hooray!
> 
> [...]
> > --- a/Documentation/CodingGuidelines
> > +++ b/Documentation/CodingGuidelines
> > @@ -256,12 +256,12 @@ For C programs:
> >  
> >     Note however that a comment that explains a translatable string to
> 
> The "Note however" isn't needed since it's not contradicting
> the previous point any more.  This can be an entirely separate item:
> 
>  - A comment that explains a translatable string to translators
>    uses a convention of starting with a magic token "TRANSLATORS: "
>    [etc]
> 
> It might even make sense to remove the explanation of TRANSLATORS
> comments from this file altogether, since they're intuitive to use.
> A more common place to want to learn about them is po/README, which
> already explains them.
> 
> [...]
> > --- a/bisect.c
> > +++ b/bisect.c
> > @@ -995,8 +995,10 @@ int bisect_next_all(const char *prefix, int no_checkout)
> >  
> >  	steps_msg = xstrfmt(Q_("(roughly %d step)", "(roughly %d steps)",
> >  		  steps), steps);
> > -	/* TRANSLATORS: the last %s will be replaced with
> > -	   "(roughly %d steps)" translation */
> > +	/*
> > +	 * TRANSLATORS: the last %s will be replaced with "(roughly %d
> > +	 * steps)" translation.
> > +	 */
> 
> Nice.
> 
> [...]
> > +++ b/ref-filter.c
> > @@ -1251,13 +1251,17 @@ char *get_head_description(void)
> >  			    state.branch);
> >  	else if (state.detached_from) {
> >  		if (state.detached_at)
> > -			/* TRANSLATORS: make sure this matches
> > -			   "HEAD detached at " in wt-status.c */
> > +			/*
> > +			 * TRANSLATORS: make sure this matches "HEAD
> > +			 * detached at " in wt-status.c
> > +			 */
> 
> optional: could treat "HEAD detached at " as an unbreakable phrase
> for the sake of line-breaking, for easier grepping.
> 
> But what's here is also perfectly fine.
> 
> [...]
> > -			/* TRANSLATORS: make sure this matches
> > -			   "HEAD detached from " in wt-status.c */
> > +			/*
> > +			 * TRANSLATORS: make sure this matches "HEAD
> > +			 * detached from " in wt-status.c
> > +			 */
> 
> Likewise.
> 
> The rest also look good. This is great.

I agree with Jonathan.  I like having everything more uniform :)

-- 
Brandon Williams
