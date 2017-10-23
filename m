Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 290461FF72
	for <e@80x24.org>; Mon, 23 Oct 2017 11:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbdJWLBw (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 07:01:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:50814 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751268AbdJWLBw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 07:01:52 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHXd2-1e3H6M3r1I-003NVB; Mon, 23
 Oct 2017 13:01:47 +0200
Date:   Mon, 23 Oct 2017 13:01:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 4/3] t/Makefile: introduce TEST_SHELL_PATH
In-Reply-To: <20171020225340.6qgybldewi7knxvz@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1710231258451.6482@virtualbox>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net> <20171020225340.6qgybldewi7knxvz@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:L7hhZrIU4iyP9Kv2FJ/GMlB30iXvvUeAAtFisbWoDHxu09Byzlp
 /ArpdDT66hUhj6KNDk+ZyjgbjDGke5uD3s0tAVAyw0pyFQoO2HoJBsLOBHwQqLHdfvWWpbn
 eJh8xqUE0Rq9a645vACFdrp1js6hEBVla9GFUn8J4RtqIV75BMZtBAynRZXQoUmED5QDPgG
 0yP5Mnmss/gQ+/YEeKEzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cYFPnkivQfo=:3AbKHZqMjF2nmCRouMs+Xc
 m8S4KhrqQSii9BJRB1wQdLqE5a3ZEKBjWUlApDsMQFc0Rf7n+zDBsOgnYHehND3VMSuGUU0t6
 V23/7kHXYIHNMpxRrrBRg17EnHwr69aRJu7oBK8rhUeFGyFj2+oCnnu0dNRgN76U7o/9LwqGm
 AaV7u9/kqXrfjJ+fFjEn02dzclm1KND/OlqLu9x2SdqGy8qZZPGeLj+OA7tOjZNeYJqZ4lzS0
 yTEwOGMPvB2EYqHIgWOAnyYArY7S/3DizsULsqUEEv+65c+xFAxduPZKmcoJGN1Tyhtpl8Hl/
 qXCxmR1pRSYMkCSU5MN2znNvA8ZI8OTFDSnKz02SWuTzxL3fVDSMjwOU9SdHaxPtGvH5hiNZh
 P5pzunT+Vq8oUtFeh72MqFHLcOmiQIhwC1oqb1WDi5ox5MvWjmR3C8q5ruLzL+jVtwGmy0krH
 cHOOg9oPrWzavDjWpmWxwDrY4sApdsphjzAr8ofCrDSf51ahBnbc7e92/gNqv1ZhuKDVLIkkM
 BhxIaeP9Sj2eUHabgKKUWg2xiehuiqmsk9qZJc63L7UROxhPIz56FQGhMEbr7eCSxajBV9gci
 eEuoiLElNzBwz5CqE2WD5+Qu8QontPDXnKhbdQbQRy5wxW46SC2/U2lza8LEVoOf01wRmH+Yb
 Tj3fTfzbK8KSyTBfBQwzPVk9gVUFiOP/VKc8hUFmnCoRMkSuJjNq8cHSXQ+LJ/8gJ7wxBkRlr
 Hn7yPyugLLgBmKtPjllCNtxDLL+G6Mrv4LGCXIbumdkNiaiujfzu7CWOuXAl1foRhQ/Drl2MM
 1KAxIUvCvFzSIyjEOinWEzQm7+grwGM/bwrD+CA+iim55ZPAMqZiVayglefsT/htIL2vCRm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 20 Oct 2017, Jeff King wrote:

> @@ -2350,6 +2357,7 @@ GIT-LDFLAGS: FORCE
>  # and the first level quoting from the shell that runs "echo".
>  GIT-BUILD-OPTIONS: FORCE
>  	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@+
> +	@echo TEST_SHELL_PATH=\''$(subst ','\'',$(TEST_SHELL_PATH_SQ))'\' >$@+

Do we really want to force the test shell path to be hardcoded at runtime?
It may be a better idea not to write this into GIT-BUILD-OPTIONS.

Or alternatively we could prefix the assignment by

	test -n "$TEST_SHELL_PATH" ||

or use the pattern

	TEST_SHELL_PATH="${TEST_SHELL_PATH:-[...]}"

Ciao,
Dscho
