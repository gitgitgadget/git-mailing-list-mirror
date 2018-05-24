Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B527F1F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971281AbeEXTuN (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:50:13 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:42067 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971278AbeEXTuK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:50:10 -0400
Received: by mail-ot0-f180.google.com with SMTP id l13-v6so3390312otk.9
        for <git@vger.kernel.org>; Thu, 24 May 2018 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mbycR6O1EhokjKYtNoOElNCho6UVLdcLvCM84m63Bes=;
        b=OJGVsYh4DdNPBobXG4/5x5sSEh9k5KjbAmgt0fjWAvn2fPyuHsIsCbFXMq7oUHaPcI
         B3uNNzCewixFWxPSFwPcwlDHTNBi10JsoBtlxqI//ymFdqEGhjQN7kVYVuJue6XxjzO6
         RMPIA/3WQvtUuttMZ6jZQPKIYJOoWJzR1Os70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mbycR6O1EhokjKYtNoOElNCho6UVLdcLvCM84m63Bes=;
        b=Dx/zqMz+NCN8jEVygORyfObxGe0u99iC21NN615y9oWgR+2x6HzmcCm6ipm2P5e2jt
         0h2uEL5sbEL1Xx/UHOgmMFyh6EKqJPF841vg513W2cluiXgdCByzSudt6LKSZccJfGmt
         jr0sdEnfdUHl7Coud6j0WlMh8ypybhDp86ErdgkFLWvcEcaveTE5R3YaoDlwiEsonVkM
         bg61Yd/cZdD+H1bJaKp8Qq3eE8A8+D8FvNNMw2PLg85F4TXepK4JE5mvAkGvJ0zC6kv2
         1I5st8RobpLjo9+QmvoIlSF/EWfZ/dkE7QGFdzljwTHmwivgZrPx11ZknDD76138jOmo
         ntbA==
X-Gm-Message-State: ALKqPwdoV1GXcpSC55vxMz73V4K395ofFY2jvwslYUGK9TGtV5R9xb3K
        hl1iK1xFRgqJyzZsX4E+WBJvPqzfXX97SOpysqMbIQ==
X-Google-Smtp-Source: ADUXVKIluLR+AGiXeldQ50D0Z1H6aLoaPJIKfb1TNCg9LrRxW22TRh13OZRTkXoPlZiYTYPNg3eAFZD+USX0MuLGr2k=
X-Received: by 2002:a9d:2909:: with SMTP id d9-v6mr1384125otb.229.1527191409649;
 Thu, 24 May 2018 12:50:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3c57:0:0:0:0:0 with HTTP; Thu, 24 May 2018 12:50:09
 -0700 (PDT)
In-Reply-To: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
References: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 24 May 2018 20:50:09 +0100
Message-ID: <CAE5ih7-MbHLjK+GaxpfAZgkyuzN=OWs0wsLdKTXLK64CeFe0_Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2018, #03; Wed, 23)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 May 2018 at 01:02, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>     http://git-blame.blogspot.com/p/git-public-repositories.html
>




>
>
> * ld/p4-unshelve (2018-05-23) 3 commits
>  - git-p4: unshelve: use action==add instead of rev==none
>  - SQUASH???
>  - git-p4: add unshelve command
>
>  "git p4" learned to "unshelve" shelved commit from P4.
>
>  Expecting a reroll.
>  cf. <CAE5ih7_jgrTXv25hYqoq=95H0zArbJAeQO3gO_TRpyLHGfTWUg@mail.gmail.com>
>

I've sent a rereroll which contains the various fixes, and removes the
extraneous verbose print change (since that's being covered
elsewhere).

Luke
