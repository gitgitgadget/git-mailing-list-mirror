Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820451F453
	for <e@80x24.org>; Tue, 23 Oct 2018 17:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeJXBeA (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 21:34:00 -0400
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:60902 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727730AbeJXBeA (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Oct 2018 21:34:00 -0400
Received: from resomta-po-16v.sys.comcast.net ([96.114.154.240])
        by resqmta-po-04v.sys.comcast.net with ESMTP
        id Eyjzg5ipHAOBJF0BdgkGxq; Tue, 23 Oct 2018 17:09:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1540314585;
        bh=ic3YMwiL9Woiz7PEyeuDPMDlFEliWbTiZTzVIrh3aXw=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=OJSxAVb9GszavoYbQLrt+4RQ7Kms7YJzNIFFxqUWdr9UxXIStMeoZH7LA2kMTx5A3
         eT4+H38KkTi+xXG5CPYHf4J4N3jTrfB7R87UuYAMQKav86ZVG661ajKbnKzNKPSd2K
         0YGx5rHeYue++k65r7KPLluOTal7P758JQaL5D+hDG3d4EXJJBBWeGMSmDja8KBK3Z
         LPQm8EKPoLz8vTVRIekz0vcE6hfHhE+GD5QAlX6RuwZVCikK10nuBbpmtgiolBN9Sk
         kY+FRwS9YoUA7xmjXSmphDTZKQpAU5jp+yrWrKjBwnbXrO2r0SynKCiRDcZuZ3uFlx
         wql1wtJ5hfMZQ==
Received: from [2620:0:100e:913:4957:471c:6cae:55cb] ([IPv6:2620:0:100e:913:4957:471c:6cae:55cb])
        by resomta-po-16v.sys.comcast.net with ESMTPSA
        id F0B4gXy8V9UcLF0BLgvx6L; Tue, 23 Oct 2018 17:09:43 +0000
Date:   Tue, 23 Oct 2018 10:09:10 -0700 (PDT)
From:   Matthew DeVore <matvore@comcast.net>
X-X-Sender: matvore@matvore-linux.svl.corp.google.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        pclouds@gmail.com, peff@peff.net, jonathantanmy@google.com,
        jeffhost@microsoft.com
Subject: Re: [RFC 0/2] explicitly support or not support
 --exclude-promisor-objects
In-Reply-To: <xmqqmur5s1y9.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.DEB.2.21.1810231008050.28795@matvore-linux.svl.corp.google.com>
References: <cover.1540256910.git.matvore@google.com> <xmqqmur5s1y9.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CMAE-Envelope: MS4wfLuuAHFXjGs6vCNTCS4+rYdXWo4O3lIT+oaBWY225B5X0h0f3WEMKSNllrhREKsC04Sb0El90lTx2aWqmRyDj+h1Qjg1HD8zMEBDr566RCLrUfZ+k4jI
 4D51Y8RGkXd2zFxbNRkaOGLalsXXeI2afhSnu19nW94mNAv+us2kDk2a47kO43mdg8dWmKWfUXQ4mggMfJ+6KTUYOfstK1DlgZdUHfXkeU15/HLEUmF9d/Ih
 Wx/1k3BTntYfYU7FwHwbPIm19+5gKtJ++L9Y7NiNZ7pzcc8IrUjo7APNIidj4FEHudj2VMzMPmdOX5k4/ivjvxia7bio7rF0ipwhGI+0k8GH+CZN+Lc8GoEo
 1u+bbIGlSg8PIuZ5exgiEwPJ1g0y4FFII8zsDe4H0dXm7iirULsnx5HACoJlaQK/PfVc6Z89k4bNTarAk4E7TCoVYyebZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Tue, 23 Oct 2018, Junio C Hamano wrote:

> Thanks; both patches make sense.
>
> As the problematic feature appeared in 2.17.x track, I'll see if I
> can easily make it ready to be merged down to maint-2.17 track later
> when somebody wants to.
>

Great. Thank you for the review.
