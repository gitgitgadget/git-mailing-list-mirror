Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC8F20195
	for <e@80x24.org>; Tue, 19 Jul 2016 23:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbcGSXcw (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 19:32:52 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36187 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbcGSXcu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 19:32:50 -0400
Received: by mail-it0-f47.google.com with SMTP id f6so103343506ith.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 16:32:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jrrtM5M/gQLj2qDoUXOXwDFgqPmZ8gGRaprguxhuTcA=;
        b=OhMQdKSGYPvTJmHnfFdP37o9iqUQy2Yg2ke6ZYieL/BBdgH+1WnlBQyzF2AP+Iy5lD
         nYcM35Ucs/e8Ce97TI5Ga3AhMHrhQ7FxqbcR1OJgAfvsJc8nWRpiU7Le4AcG8vq6qX9R
         tDtPWIaGS1gR55L3Vo4FnWQQIIx7jJipwnKUkBcRTGUs3tu8zzzc9k9TXYzIjS6wHu2X
         pcjVKLyvamlziNlC/IG+1C4pje/5aPplkxQdCeAJyFvaJfzGSGmLt7tAapjuOdPYAx27
         rVaU/9IiiQMIfk13/RCw2IK7YWLaTzRcXnV1GJtaZBiMFvT7TcFRpWlM+E4nsaNfxoVH
         Kdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jrrtM5M/gQLj2qDoUXOXwDFgqPmZ8gGRaprguxhuTcA=;
        b=WTsRCVe5nssxHGYd22ls8OLbsKEyGujLq/2pGBDog08SqKgydFHcQTMg/poOWHZyA9
         T5ExZFYm9exmc8lTmKHWJ9M8twk/osANSWnvuCji4fW5iCavLAublW9SA4Eb1Q6khsqB
         0Ld0kHfmQ0oaNYxgvICmkDQ8wXAxCWbJ9Lt5NH2q2OmeZ3HBV6DvFW0BIhREEYMYfbqE
         WbO8DAzwPWBvnWwtpFKdV8sftBYnhHDkK4AhwCfVykA6t2nq7kOwcSbffZQYBUheaD7W
         +LPBI/2VlnN+RobJkEGVGRuD5huNklp0AUamCx1z6CPl+aCzjevwi5JnTRfN/SHYS8bs
         hpAg==
X-Gm-Message-State: ALyK8tKjWUgJ+Y5gGwu+49aJoslc0ruhUM8JaZbyqyc+XVgLT8vw85PtaigOE2PjiDsHs5vqYEFRDsqtbOJuhg==
X-Received: by 10.36.34.14 with SMTP id o14mr7088091ito.11.1468971169806; Tue,
 19 Jul 2016 16:32:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.10.97 with HTTP; Tue, 19 Jul 2016 16:32:48 -0700 (PDT)
In-Reply-To: <xmqqoa5th84d.fsf@gitster.mtv.corp.google.com>
References: <CAOiOGAcqsdMD0j_ZUdvvGiA9Bd6bUmfvxziN06Rw81f_pO7cgg@mail.gmail.com>
 <20160716051800.GA2845@sigill.intra.peff.net> <xmqqfur6isyr.fsf@gitster.mtv.corp.google.com>
 <CAOiOGAfysmjBxcK-VwscLWBdun4rNsRs85p=foBxETvQw0J1Jw@mail.gmail.com>
 <CAJo=hJviMd3tWe_HUmh0M0Y2TOCwwrZX14hdyivPSYQ1ck052w@mail.gmail.com> <xmqqoa5th84d.fsf@gitster.mtv.corp.google.com>
From:	Parker Moore <parkrmoore@gmail.com>
Date:	Tue, 19 Jul 2016 17:32:48 -0600
Message-ID: <CAOiOGAdhMvMfDquviuZSJr12UXK-0Fjc8xWeNJc=Wgp1jYmS2w@mail.gmail.com>
Subject: Re: [PATCH] contrib/persistent-https: update ldflags syntax for Go 1.7+
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> the logical place to pull that information from would be ../../GIT-VERSION-FILE,

I agree. It would make more sense to build this to a specific version
or git revision rather
than a time. Perhaps that would be a different patch?

> So unless the "dynamic lookup in the Makefile" turns out to be too
> gross, we would want to keep the mechanism and just make it usable
> for versions before 1.5 and also after 1.7, I would guess.

A dynamic lookup of the go version would look for go 1.0, 1.1, 1.2,
1.3, 1.4 and 1.5.0.
These versions would be incompatible with the `X var=val` syntax. I am
not too familiar
with Makefile syntax for numerical comparison, but I believe this
would be fairly simple.
Would you like me to whip up a patch for it?
