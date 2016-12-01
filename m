Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4761FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 19:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759871AbcLATf2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:35:28 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35421 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759828AbcLATf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:35:27 -0500
Received: by mail-pg0-f54.google.com with SMTP id p66so98168881pga.2
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 11:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kgwIiZ7I31JOGRBV8tYGyp6Hs/BMTIAf0YJtqOcCPoY=;
        b=EkgTlLY36IvMInBY4NlIuStoWJ8eAYCfH5tN9AOvuDGh8J+Wu5ywkINNBp1Y84fuJn
         KKgv/ZxARhfjBZrrAzf5Bjc2LHaG0ayuPYH2CqWyI+RndIXMO721tY/c9i7ERUJBrI9D
         KR1H0eIHYHDY/RqUj0FIBisXYn++YKizE6QcLYlhMKbFL0HVOrPWgHKAn0q2i90CYvEr
         okHja9jry8e0VbeihV8eXCvviA/+jqu1s0T67yRmgMQJBtBIyUf6PCTQw553TTN0eeAH
         yeUuJyL+Mu6tw2kkF9yKMvsiPISRjxePp1JtwK7KXBCI4Z5/exDmsCTaJe4cp5bNMFE1
         Snww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kgwIiZ7I31JOGRBV8tYGyp6Hs/BMTIAf0YJtqOcCPoY=;
        b=i4d8o15V20ZsWJua81euPSkZtdF92IxRkQjD4Bp3CdqfHAQq7PdmPQpHo3WsZmDS53
         WFpCuL9/jTkizY6jWdQjlgtFtvndoc3zkK2rMLzjCgqZjAguD+FGtoGCx6pYExFY3952
         ZnytCHNYaQkTtrTtk5sR60ZZ/kaUHFdzJLC6B2VFR3YUp5+/kXlVKQbxRLCCjKy6npBx
         +CfsVUKdVnLNZS3/Fdh87rv2KUco6tS7bkUex6dTXhNRTgGBqR1yoVqKXdSE2xiNiIx/
         hvndMwqaV8hIeN4QNztjoRJKxI6TMhj0wIHEI6kAYvMRJ+YtNVLdpMdmsJO9Bqq7YIKB
         ie0w==
X-Gm-Message-State: AKaTC02m3zp19c3+hdr0qRKxfxvD5dS9tJDifHqjgk1xAwEei6B2FM+0VZkIBgjnQL7WxU/8
X-Received: by 10.84.214.150 with SMTP id j22mr39368192pli.81.1480620926116;
        Thu, 01 Dec 2016 11:35:26 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id 140sm2111062pgg.0.2016.12.01.11.35.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 11:35:25 -0800 (PST)
Date:   Thu, 1 Dec 2016 11:35:24 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: bw/transport-protocol-policy
Message-ID: <20161201193524.GC54082@google.com>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161201083005.dui572o4jxsqacas@sigill.intra.peff.net>
 <20161201181415.GA54082@google.com>
 <20161201192055.44mtvtacyhpbqbqu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201192055.44mtvtacyhpbqbqu@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Jeff King wrote:
> On Thu, Dec 01, 2016 at 10:14:15AM -0800, Brandon Williams wrote:
> 
> > >   1. The new policy config lets you say "only allow this protocol when
> > >      the user specifies it". But when http.c calls is_transport_allowed(),
> > >      the latter has no idea that we are asking it about potential
> > >      redirects (which obviously do _not_ come from the user), and would
> > >      erroneously allow them.
> > > 
> > >      I think this needs fixed before the topic is merged. It's not a
> > >      regression, as it only comes into play if you use the new policy
> > >      config. But it is a minor security hole in the new feature.
> > 
> > I agree and it should be an easy fix.  We can just add a parameter like
> > so:
> > 
> > diff --git a/transport.c b/transport.c
> > index 2c0ec76..d38d50f 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -723,7 +723,7 @@ static enum protocol_allow_config get_protocol_config(const char *type)
> >  	return PROTOCOL_ALLOW_USER_ONLY;
> >  }
> >  
> > -int is_transport_allowed(const char *type)
> > +int is_transport_allowed(const char *type, int redirect)
> >  {
> >  	const struct string_list *whitelist = protocol_whitelist();
> >  	if (whitelist)
> > @@ -735,7 +735,7 @@ int is_transport_allowed(const char *type)
> >  	case PROTOCOL_ALLOW_NEVER:
> >  		return 0;
> >  	case PROTOCOL_ALLOW_USER_ONLY:
> > -		return git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
> > +		return git_env_bool("GIT_PROTOCOL_FROM_USER", !redirect);
> >  	}
> >  
> >  	die("BUG: invalid protocol_allow_config type");
> > 
> > That way the libcurl code can say it is asking if it is ok to redirect
> > to that protocol.
> 
> I wouldn't expect anyone to ever set GIT_PROTOCOL_FROM_USER=1, but it
> does behave in a funny way here, overriding the "redirect" flag. I think
> we'd want something more like:
> 
>   if (redirect < 0)
> 	redirect = git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
> 
> and then pass in "-1" from transport_check_allowed().

I don't think I quite follow your solution but I came up with this:

  case PROTOCOL_ALLOW_USER_ONLY:
    return redirect ? 0 : git_env_bool("GIT_PROTOCOL_FROM_USER", 1);

Which should address the same issue.

-- 
Brandon Williams
