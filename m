Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF2541F404
	for <e@80x24.org>; Tue, 13 Mar 2018 00:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeCMAtn (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 20:49:43 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:33317 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbeCMAtm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 20:49:42 -0400
Received: by mail-pl0-f48.google.com with SMTP id c11-v6so10365519plo.0
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NsOwMVgUMpo/am0VO5seOn5IpkeZIAc/Sr1/YA059ZM=;
        b=KVyKF/0/dhuzsoI/pZgJMB1CoEc0+Tsf0Y4MC0YtFw+4DvNtRHIqPfDNIOwS6PHmTG
         wPBRHbmAzx5mTE0kW4DNztMBO9ha2VSolg7v3R+brM5SBJVlN9zj1b9tCyShMnsQo6JC
         5PQ8hTIY/VEP0L4edEAoc6Ohin6wbTxrgY0p3Zh3WP/RcuwKD3LRUpWjTuVELZL6oRWb
         ZFUQC+5cZbgMUbEepTpDMzUB610S9dGCrQeoT8B+k+FrLXz4qHqnO+ijrqJMewPBHI/0
         DGOr0StGGn1UjpvW2iCwrGxy7CrNZJYu3byzMjReEn7dQjv0/rq8zlwmJwCrf/Li+XWV
         gH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NsOwMVgUMpo/am0VO5seOn5IpkeZIAc/Sr1/YA059ZM=;
        b=VBnC9zsiacG7nNcjDlTjZytGOMXld8IQyZjczXnxLK2jplgnemTlIBm5t03hei+Yv6
         YPkKJyKFWMPODpcgEPXC21JtYTVBtVhcaVBxYdiMpFo5ois0mXDac6x4el1LQ/XhY4Yh
         SHvxXbtKLuTJS/fYZXwvfOorO4P4oju77qLeHx/fVs6xstNIMxT7/4Eo8DVtyqWr70hW
         odeyTA45s2ZaySE0UXdhkDhpJJriTo8LNi2kbeUnjudj3xa3mZJdWaJWOGIhPRGs2Lhy
         dc1ajNhBdWI1IUOOHelFPLeWZQRPhUnPGbBAmO5V1SSZbePwr8YG643w+f74vJ+mZ8/i
         KzLw==
X-Gm-Message-State: AElRT7GLYuupNgfNUejxyojKxdKkqJ2Ihs8xT/M8H97bgTNAn8Gf+fvx
        AXbMbi45EAAtqSagekxvs2k9qw==
X-Google-Smtp-Source: AG47ELvSr1FDst5xjT1ThPzUzcdgEDmQ0nOsyvdrL/dtb6nK0dPFbq9abyPrTc7s6IVAx6e705T9cQ==
X-Received: by 2002:a17:902:7598:: with SMTP id j24-v6mr9933630pll.1.1520902181887;
        Mon, 12 Mar 2018 17:49:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id y5sm19160334pfd.85.2018.03.12.17.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 17:49:41 -0700 (PDT)
Date:   Mon, 12 Mar 2018 17:49:40 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jonathantanmy@google.com, stolee@gmail.com,
        sbeller@google.com, johannes.schindelin@gmx.de
Subject: Re: Git Merge contributor summit notes
Message-ID: <20180313004940.GG61720@google.com>
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
 <87efksqe3p.fsf@evledraar.gmail.com>
 <20180312234037.GE1968@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180312234037.GE1968@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/12, Jeff King wrote:
> On Sat, Mar 10, 2018 at 02:01:14PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> > >  - (peff) Time to deprecate the git anonymous protocol?
> > [...]
> > 
> > I think the conclusion was that nobody cares about the git:// protocol,
> > but people do care about it being super easy to spin up a server, and
> > currently it's easiest to spin up git://, but we could also ship with
> > some git-daemon mode that had a stand-alone webserver (or ssh server) to
> > get around that.
> 
> I don't think keeping support for git:// is too onerous at this point
> (especially because it should make the jump to protocol v2 with the
> rest). But it really is a pretty dated protocol, lacking any kind of
> useful security properties (yes, I know, if we're all verifying signed
> tags it's great, but realistically people are fetching the tip of master
> over a hijack-able TCP connection and running arbitrary code on the
> result). It might be nice if it went away completely so we don't have to
> warn people off of it.
> 
> The only thing git:// really has going over git-over-http right now is
> that it doesn't suffer from the stateless-rpc overhead. But if we unify
> that behavior in v2, then any advantage goes away.

It's still my intention to unify this behavior in v2 but then begin
working on improving negotiation as a whole (once v2 is in) so that we
can hopefully get rid of the nasty corner cases that exist in http://.
Since v2 will be hidden behind a config anyway, it may be prudent to
wait until negotiation gets better before we entertain making v2 default
(well there's also needing to wait for hosting providers to begin
supporting it).

> 
> I do agree we should have _something_ that is easy to spin up. But it
> would be wonderful if git-over-http could become that, and we could just
> deprecate git://. I suppose it's possible people build clients without
> curl, but I suspect that's an extreme minority these days (most third
> party hosters don't seem to offer git:// at all).
> 
> -Peff

-- 
Brandon Williams
