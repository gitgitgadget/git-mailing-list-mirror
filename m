Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BF4E1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 18:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758817AbcLASOU (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 13:14:20 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34318 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758532AbcLASOS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 13:14:18 -0500
Received: by mail-pg0-f45.google.com with SMTP id x23so97537874pgx.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 10:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CrkMv+oT3KNhvDQyO3VQeb2t31mmld7ZTUunMkH6KCI=;
        b=fhLUPePtq3vG2CuKd/r1u4GBIFG4mRrc8L8+DEJx8QGsWaINdUUdxLq+m0cA57eJTL
         kyYyIpeEvSQEjHw/dXk/8/plUd6+QF/ptq1zvmj6X0u2Dg1/RVpiK9qmw8/fO+zUg3iD
         U6eRCvlAFNPSP22+8nCQr5DpU4+msEoqj0VG66gwYVRV28iIuStvQd/klTy0Iw5LEsMp
         NhqRCD5uhzm6Cd8PHZ4ydCv2vB5QS5jx6FJnUf1fe7tcpbZ2kvLbx629x5Mmsu3RrzfX
         EGhX0vaJoSYNC0EBdSveQvK0OR1EBL/Q9TsfH4jszS8sCntG2CqS5NduSCxuDPbupmSm
         lmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CrkMv+oT3KNhvDQyO3VQeb2t31mmld7ZTUunMkH6KCI=;
        b=gDkNrrVxVvddfqH6tMntfh7ae6zdh+70oRxvLsgPpOZCOmj/Sm67FK6de9Xv3tEyVR
         P9HSai550lBh5M3HV/iqe994phYbUV3PBpmvsgsPzpxYGbXUaE543R4YOQZYq7fGT0S2
         NGwwhYtfeDJp6QrDYEHSGyLUnTbKjAEXLq+NQe8ASPCAa7YXVlB5XRpNACJzX3+yjwV+
         +kHgmcO9uzE2vKYI3Secd5e+XfeGrzAu2aT2eqhmQSy9TDZb/Bu+TFw2InCmy7EVhfRZ
         yTn+WDoqyXpq8FPtKf/u3OvQnh3TixWnoqEl2unLZcu4pfm8I8ZAW6NH8RxNbHiB3i6C
         Cu7Q==
X-Gm-Message-State: AKaTC00rLsxHCtA23iNsn4MJDjkVwMnA7dXBzHiKolY3SCDSQ+cRkFpMt4vEeuhZDmt087ov
X-Received: by 10.99.139.199 with SMTP id j190mr71284896pge.115.1480616057408;
        Thu, 01 Dec 2016 10:14:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id n17sm1692207pfg.80.2016.12.01.10.14.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 10:14:16 -0800 (PST)
Date:   Thu, 1 Dec 2016 10:14:15 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: bw/transport-protocol-policy
Message-ID: <20161201181415.GA54082@google.com>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161201083005.dui572o4jxsqacas@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201083005.dui572o4jxsqacas@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Jeff King wrote:
> On Mon, Nov 28, 2016 at 04:15:08PM -0800, Junio C Hamano wrote:
> 
> > * bw/transport-protocol-policy (2016-11-09) 2 commits
> >   (merged to 'next' on 2016-11-16 at 1391d3eeed)
> >  + transport: add protocol policy config option
> >  + lib-proto-disable: variable name fix
> > 
> >  Finer-grained control of what protocols are allowed for transports
> >  during clone/fetch/push have been enabled via a new configuration
> >  mechanism.
> > 
> >  Will cook in 'next'.
> 
> I was looking at the way the http code feeds protocol restrictions to
> CURLOPT_REDIR_PROTOCOLS, and I think this topic is missing two elements:
> 
>   1. The new policy config lets you say "only allow this protocol when
>      the user specifies it". But when http.c calls is_transport_allowed(),
>      the latter has no idea that we are asking it about potential
>      redirects (which obviously do _not_ come from the user), and would
>      erroneously allow them.
> 
>      I think this needs fixed before the topic is merged. It's not a
>      regression, as it only comes into play if you use the new policy
>      config. But it is a minor security hole in the new feature.

I agree and it should be an easy fix.  We can just add a parameter like
so:

diff --git a/transport.c b/transport.c
index 2c0ec76..d38d50f 100644
--- a/transport.c
+++ b/transport.c
@@ -723,7 +723,7 @@ static enum protocol_allow_config get_protocol_config(const char *type)
 	return PROTOCOL_ALLOW_USER_ONLY;
 }
 
-int is_transport_allowed(const char *type)
+int is_transport_allowed(const char *type, int redirect)
 {
 	const struct string_list *whitelist = protocol_whitelist();
 	if (whitelist)
@@ -735,7 +735,7 @@ int is_transport_allowed(const char *type)
 	case PROTOCOL_ALLOW_NEVER:
 		return 0;
 	case PROTOCOL_ALLOW_USER_ONLY:
-		return git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
+		return git_env_bool("GIT_PROTOCOL_FROM_USER", !redirect);
 	}
 
 	die("BUG: invalid protocol_allow_config type");

That way the libcurl code can say it is asking if it is ok to redirect
to that protocol.

> 
>   2. If your curl is too old to support CURLOPT_REDIR_PROTOCOLS, we will
>      warn if there is a protocol whitelist in effect. But that check
>      only covers the environment whitelist, and we do not warn if you
>      restrict other protocols.
> 
>      I actually think this should probably just warn indiscriminately.
>      Even without a Git protocol whitelist specified, the code serves to
>      prevent curl from redirecting to bizarre protocols like smtp. The
>      affected curl versions are from 2009 and prior, so I kind of doubt
>      it matters much either way (I'm actually tempted to suggest we bump
>      the minimum curl version there; there's a ton of #ifdef cruft going
>      back to 2002-era versions of libcurl).

We should switch to warning all the time since this series adds in
default whitelisted/blacklisted protocols anyways.

-- 
Brandon Williams
