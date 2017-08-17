Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C470C20899
	for <e@80x24.org>; Thu, 17 Aug 2017 20:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbdHQUgD (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 16:36:03 -0400
Received: from mout.web.de ([217.72.192.78]:63515 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752632AbdHQUgC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 16:36:02 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MMn1H-1dfO3I40Y3-008Z7E; Thu, 17
 Aug 2017 22:35:56 +0200
Date:   Thu, 17 Aug 2017 22:35:54 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [Patch size_t V3 00/19] use size_t
Message-ID: <20170817203554.GB31284@tor.lan>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:E5QDvSS4Z9ADKfFVaeSZ4vo9+83oWb6UFbZOgjIckLY0DrnzhLN
 12ulpbT79vbqpGFeEzXZW/0QegBno3wq1gD/5gWd0mQHVb2VlTs4pvNNKeY2Rb0gNmvGzlN
 e44Uc+1CYQUZw0hTPtSHeT7CWDnbd970SP2zi3egNuORLmpMwkfv6b3+WLnyZx3iaKduARQ
 HMR09YmxHc5A8TlpSbpcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RlHX096OXIs=:A+ey9yZOB0i3AoOhVEk/DM
 Jj+bj9lcO/wxTDiMeJk0+DTIYmD1wVym7vrjANJ/o+zyijJDS1BV/C8y1E+diNxOHAOkq77A1
 dDCA8gcD4B1E9TX0e7B/lKpwwIReVAnoWaegrW4QiUbif2gwROTibwlBZsCmiyWZhed13ITeO
 PYRv81HYxNHX12hPHRrgCtpQpWbuwgY25o7Y3EptYkUOY8SXOGrh2+CQXWLmgX/jReQ0WZIo0
 ZP4ym3Atpi7PhRekCw7KOl+g6RnhWXqkFbFLHPuXgVixYDiddxURPboI2aq7cjeyi2g6kUKjq
 ZChL+ABP4G+UoYIbgPMjWrwunRDLAifpKzuTLOFmHjAEEO71PCeFcSjbEfLngw00oDztsqH9h
 cvkoRAD2KdRno8LR0U2WMxXlpgCzEFDVZyA3Uhr8kdA0bvJbupWXl4IAtlF8zs6t86ZBtYEQD
 DilZPDdy4yEfHyMlA+3maQ5KnfMsJpd/ld/32dLi61fBWJiPBrwA75ojZeHpifqCz+M33nCGB
 WuejaqjQ07lXsYcxxMIKsicEFdWj5YOO1A193DXvrd0eCsS0eSgCBId4EDDc/egiuH9dh+h/w
 ObvRviycXOypUzUMz6cbZgoymrp7aKXn8A29qTuLRDQk9Dz17FaTYTPOTQuu5FUsHYHttiA4h
 DsSU9HBnR+7o3nYbPIOGKIqmuf4J2eyBj9VUgYYTAQEqzo66vQ8+idPYFhQ+dhJRqpDzSIa4A
 xP3gLGNd+Hvta3D3+4YY7I55HYBGmNEelyaal51FFN/9Up9C9CDIREjfYRCWCJg8h53ie4MES
 PyLLDkwVbwtNk5quL/EWvC9RpGiPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2017 at 10:16:12PM +0200, Martin Koegler wrote:
> From: Martin Koegler <martin.koegler@chello.at>
> 
> This patchset is for next [24db08a6e8fed761d3bace7f2d5997806e20b9f7].

I applied it succesfully, and run the test suite on a 32 bit system.
The Laptop reported one brekage in t0040:
t0040-parse-options.sh   not ok 19 - OPT_MAGNITUDE() 3giga

Beside some t5561-http-backend.sh (which are most probably not caused
by this patch.

The raspi had 2 deadlocks, like "git push --signed dst noop ff +noff"
or
trash directory.t5541-http-push-smart/gpghome --sign -u committer@example.com
Even this most probably not caused by the patch. (and the test is still running)

Well done, and on which platforms did you test ?

