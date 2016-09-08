Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391EE1F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 11:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966479AbcIHLEG (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 07:04:06 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:38543 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932372AbcIHLEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 07:04:05 -0400
Received: by mail-it0-f43.google.com with SMTP id c198so73031041ith.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PaMLm66h5qJoCI36JTZY3XNsw1WoKSzIVLDyz2Y1WWU=;
        b=cgcr1mgDF6Lp646l3a+djGIV2Y9JdiH/OU6Z5bKuoL6f4mTVlS3/r8/oxlZd5biTkl
         pb3Tr//yDApXPwheX/RFFlFAEe10pk5E9hCbnqgTLkBO1aAItCqZ5+mXeXfACiYcVzDa
         BbCNx/tBZs+X5QDD0O8gHqycLSWk3dqh3twAYgFo9QyoXfoD5TnPBYMAGLJ4suXG+6pN
         TlCx34N6mMsnC+TmgLL+KpBc2VeuuGwbQAvCnUSVUtZbect2OyHctMr2HaMFy7ieSHG0
         F75Fg21j11TJtPwRAWjDRTW3qS1VQZ+IA8z+ZsyNLxycwixp5kpAoLUp2YiHeuW9NC6R
         DlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PaMLm66h5qJoCI36JTZY3XNsw1WoKSzIVLDyz2Y1WWU=;
        b=bVCiIriEjlvyN9aZxsZOCU5f0WH5VhZESby8EHCZ2KLIYWUfwShVnZNb2DCFo1uGoj
         PUK2dFiHevmPMc/COPHFydaY+ij4U0UUt1LU/P21+RZFpt7/s5gZHpvQVgyGlGUWOsgq
         lz+Lx4Q0a++Xt5iXF+nsLlUxCtqhih+djLPQSefTj+Su7Jwuf/kzNXFqXznS7+iG94QD
         wl3t1fV0BLssXT/sjGfo72rErvzhJU6a5g2D1g6LXmlO0DNEgqEo2aUJRaxwisQu7Fai
         veodgWCovRvYCgGF6CN5/M1iDi7QUffecxc/bkHxBpZfb0ypLB7NPF8o+O7w1u0+oDMM
         do4w==
X-Gm-Message-State: AE9vXwPSvVhn/WDdqqMZbI6W/v7HrJBK537K1oQIzNDpeuFyH4H70ckoolUIse8UsQC6TezxtGP3kjLTV3B2Cw==
X-Received: by 10.36.3.76 with SMTP id e73mr14860397ite.42.1473332644167; Thu,
 08 Sep 2016 04:04:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.40 with HTTP; Thu, 8 Sep 2016 04:03:33 -0700 (PDT)
In-Reply-To: <20160908012553.q2aubze4qggfzjxz@sigill.intra.peff.net>
References: <CACsJy8BF_mnSUcEeH=RBMyfh8RrQGJ4dwm_svsC4TciJtECn_w@mail.gmail.com>
 <20160908012553.q2aubze4qggfzjxz@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Sep 2016 18:03:33 +0700
Message-ID: <CACsJy8DW1-EsfgGkbnD3LgiygAu2JV9vs_8e+oQbenXERUA6hw@mail.gmail.com>
Subject: Re: "fatal error in commit_refs" from pushing to github
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 8, 2016 at 8:25 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 08, 2016 at 07:49:12AM +0700, Duy Nguyen wrote:
>
>> I got the message in the subject when pushing to github today. Yes I
>> know it's github, not git. But according to stackoveflow [1] it's a
>> local problem. Which makes me think, if we know exactly what this is
>> (or at least roughly the problem area), maybe we could improve git to
>> catch it locally in the first place (and because other git servers may
>> not have the same protection as github).  Jeff maybe you can reveal
>> something about this "fatal error in commit_refs"? I'm sure it's not
>> in git code. But I would understand if the answer is "no".
>
> The short answer is that it's nothing to do with Git or the client; it's
> GitHub-specific code running on the server that is outside of Git
> entirely.
>
> The long answer is that pushes to GitHub don't hit Git directly these
> days. They hit a proxy layer that speaks just enough of the Git protocol
> to relay to N separate receives spread across N replica servers[1]. Those
> receive-packs take in the pack and verify it, but don't actually update
> any refs[2]. Then the proxy layer runs its own set of policy hooks, and
> speaks a commit-protocol to each of the replicas so that they all agree
> on the new ref state. That last step is called "commit_refs" internally.
>
> So this is really an internal failure at the ref-update stage. There
> _should_ be a reasonable error message, but I think "fatal error in
> commit_refs" is the generic last-ditch fallback. I'll pass this along to
> people in charge of that code, as we should be generating a more useful
> error message.

Hmm.. I'm interested in this because the "fix" is from client side. I
did "git gc" and "git fetch" and the problem was gone. From this
description, I suppose C Git sends a good pack (phew!), but probably
with some stale ref or something that upsets this this last stage.
It's hard to make a connection back to either gc or fetch. Maybe gc
does ref trimming or something (that should probably be done by
git-push as well). Oh well.. maybe next time I see it, I'll get a nice
and clear message :)
-- 
Duy
