Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955C62047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbdHGR6h (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:58:37 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38291 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbdHGR6g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:58:36 -0400
Received: by mail-oi0-f67.google.com with SMTP id s21so1095023oie.5
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gs9S3SduafiofzupO4plugdI/92FL/FcaS5RqIIkMqY=;
        b=oZBuQjB6BQxFcTk3W0IbQb9wvLmmCFpl580ChzPlh9a/e69H5Uo+mmUHnDl5Eiki0+
         yAwpMUNOO5hy/db+ldQgGao/2iscuRfbetZVdqiuHvNjit+OhBRygztZKbskkZizJC/h
         J3KIc52//7PXkA0PnvQX9uW9UJSm8RGF+LbjYpSaMhN0k3f3w93k+utJrni847qVyHke
         SDq0xC8t6DbE24efiQNwac691tVOTu8SU65rcJBEEdkhfpVucalGNWDsW0JMRUcOr9zZ
         dapsTPqzGiKjrK3PPJFVnReGHUs57DPUnPa6obxGMC+U3lXTlI3chgf6vm3OVBI7Tq2b
         9OTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gs9S3SduafiofzupO4plugdI/92FL/FcaS5RqIIkMqY=;
        b=uhGhfHO3flcu2YnQyTK2wIP2W1wX2fvlLzNivRxszvFCEmB+Oq5syIU4sOYyFzCgrF
         XdRBN+iNPHSfFRS6/eaHS5GMTugkDy9Z29VMYvCXfYy/6wMWD5IXWYGKnD8s900Df3E+
         hjrJY3MDz3RwizCPiChwvNx/+kAwOBSy26087CPWLWSx2tizGW6HtedvY7a3aGpHF6Pw
         hiIQtnRZsGOi6HPBXyGRIEP85Ld8S5GOIBbOEqGQtXnbveOMn47cgNEz3H1plnvLUFkx
         V5p8/0QVxWWs6OvwXBBGC7VZS8ldCG/b53lZ80PECFMv8ksp9w9ySmSSd+k87va2OgyH
         hmsg==
X-Gm-Message-State: AHYfb5gDN58+FOuMowM7I2X0gKjzuJLSyvkgpnTyadhliOvY0l8Ov+bi
        GEVAF0JRGDfurRsKTBf9Yjyuc0UiPLL2C1A=
X-Received: by 10.202.225.67 with SMTP id y64mr1053123oig.159.1502128715519;
 Mon, 07 Aug 2017 10:58:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.139.81 with HTTP; Mon, 7 Aug 2017 10:58:34 -0700 (PDT)
X-Originating-IP: [2601:647:5100:4a0:16dd:a9ff:fee7:6b79]
In-Reply-To: <xmqqo9rrqp3l.fsf@gitster.mtv.corp.google.com>
References: <20170805064905.5948-1-mforney@mforney.org> <xmqqshh3qqs4.fsf@gitster.mtv.corp.google.com>
 <xmqqo9rrqp3l.fsf@gitster.mtv.corp.google.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Mon, 7 Aug 2017 10:58:34 -0700
Message-ID: <CAGw6cBvE-OJW0gSRCYOS5VT+Ff+eiCMdJg2A2rBi_HXFObdJRw@mail.gmail.com>
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/7/17, Junio C Hamano <gitster@pobox.com> wrote:
> Just to avoid possible confusion, the above is not to say "once it
> is decided, you are not allowed to bring fresh arguments to the
> discussion".  As Peff said [*2*] in that old discussion thread, the
> circumstances may have changed over 9 years, and it may benefit to
> revisit some old decisions.
>
> So in that sense, I do not mind somebody makes a fresh proposal,
> which would probably be similar to what I did back then in [*3*],
> which is at the beginning of that old thread.  But I do not think I
> would be doing so myself, and I suspect that I would not be very
> supportive for such a proposal, because my gut feeling is that the
> upside is not big enough compared to downsides.
>
> The obvious upside is that you do not have to have many built-in
> commands on the filesystem, either as a hardlink, a copy, or a
> symbolic link.  But we will be breaking people's scripts by breaking
> the 11-year old promise that we will keep their "git-foo" working as
> long as they prepend $GIT_EXEC_PATH to their $PATH we we did so.
> Another downside is that we now will expose which subcommands are
> built-in and which are not, which is unnecessarily implementation
> detail we'd want end-users to rely on.
>
> The "'git co' may stop working" I mentioned in my previous message
> is not counted as a downside---if the upside is large enough, I
> think that "we respawn git-foo as dashed built-in when running an
> alias that expands to 'foo'" can be fixed to respawn "git foo"
> instead of "git-foo".  But there may be other downside that we may
> not be able to fix, and I suspect that "we'd be breaking the 11-year
> old promise" is something we would not be able to fix.  That is why
> I doubt that I would be advocating the removal of "git-foo" from the
> filesystem myself.

Thanks for the history and explanation, Junio. I agree with your analysis.

I didn't know that git aliases invoke the `git-foo` path for built-ins
(I don't use them much myself, so didn't notice).

I also didn't know that it was supported to add GIT_EXEC_DIR to your
PATH to be able to call `git-foo`. I generally think of /libexec as
implementation-specific executables that a tool may call internally
(in that sense, whether or not the commands are built-ins would remain
an implementation-detail).

However, I still think the patch should be applied for
self-consistency at least (git-submodule.sh currently calls both `git
rev-parse` and `git-rev-parse`). Also, based on Johannes' reply, it
may still be useful for git-for-windows.

>
> [References]
>
> *1*
> https://public-inbox.org/git/alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org/
>
> *2*
> https://public-inbox.org/git/20080826145719.GB5046@coredump.intra.peff.net/
>
> *3* https://public-inbox.org/git/7vprnzt7d5.fsf@gitster.siamese.dyndns.org/
