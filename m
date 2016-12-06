Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C03220259
	for <e@80x24.org>; Tue,  6 Dec 2016 09:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbcLFJfN (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 04:35:13 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:33292 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbcLFJfF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 04:35:05 -0500
Received: by mail-io0-f182.google.com with SMTP id j65so643231555iof.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZNP6524M2qMutqAAWktn25h+Ixl01/K5DYGeTcmIJ+8=;
        b=IL6qHnfQZDHBzFOU+ju/USYCc9p2q+QlHcdwppq8GE2BmDX5w0ZmTlkmhw7gdKEtEo
         F67TzCNPEl6Blv8KRROml140chbuLvRWmhL3RIwHxOsK9nOIV5OtbO7MdBHq3vFqIw/D
         9C5/aBx3cwuF01zogFPoaT3v6a47b1jFaPaGuaGH6pIR6UuMNAcFMABDjmsx+t0Y47yH
         ZxcmiMJ7e6WCAtk5pQiaedwT3VPfvztECh8CeKDPK/Jd9jZ4F2EDWEczkbbIk/UgKb5B
         H3el6Jqfd9POB/BnXrI8pZ/BfnKp7CFL8Cv7zh1OAUAYWaS+uZU0wLpPaKbdlb7vq6JW
         cyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZNP6524M2qMutqAAWktn25h+Ixl01/K5DYGeTcmIJ+8=;
        b=TZLq8WMfG6aSzB/PPPQns9BCp8kYtMbO1ms0g/O6WHkQqdn03qukMJeI+PAX3gZamR
         CkFh8EdBRuy6SHEPmRErpKDvkpW5Jn1S5gXnE3uuH+04u0Mgd3nETbZa+1WtOC1mJwhS
         K6YXW+7jBtM9xqT1cvItaWmWUMc/NiBQiWbtIXxxBiLICpR3LfY++86zwt0eC0mWcbkJ
         lpB/IOrqs0IhLWwarVrJwIf56oUgPnQHRSY7rm158NuMHjp4aBxZ9qan/EDqTmRhPJmW
         FopIwm+1nlBDpMlghDq7SqhYexJNcsQv3U7S5ms1ms/W6eEwSmh08CDfbNEqBE5TnUG6
         WJgw==
X-Gm-Message-State: AKaTC01bNOYKChqCIyl6rrM1iFGCvRSctfkgRyBjluUfYbSSXzQoUj4XViWOR0/7W8FKCn5vCc/slsmBPipJ5Q==
X-Received: by 10.107.132.74 with SMTP id g71mr54130640iod.19.1481016881867;
 Tue, 06 Dec 2016 01:34:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Tue, 6 Dec 2016 01:34:11 -0800 (PST)
In-Reply-To: <xmqq37i25iy5.fsf@gitster.mtv.corp.google.com>
References: <20161204220359.30807-1-alexhenrie24@gmail.com> <xmqq37i25iy5.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Dec 2016 16:34:11 +0700
Message-ID: <CACsJy8Cy+iWw4NhR7B_fZhBMMYt2QxdMeFsC=++LLnrTLNWfKw@mail.gmail.com>
Subject: Re: [PATCH] clone,fetch: explain the shallow-clone option a little
 more clearly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 6, 2016 at 1:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I however offhand do not think the feature can be used to make the
> repository shallower

I'm pretty sure it can, though it's a waste because you should be able
to shorten your history without talking to a remote server. But that
no-remote shortening is not implemented yet. And you probably want an
option to check with remote anyway to make sure the part you cut out
is available there, no history will be lost.
-- 
Duy
