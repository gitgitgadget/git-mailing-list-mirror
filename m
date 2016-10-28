Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F7D82022A
	for <e@80x24.org>; Fri, 28 Oct 2016 08:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941833AbcJ1Izk (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 04:55:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:53852 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936627AbcJ1Izj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 04:55:39 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MUUWN-1cPinE1Tf9-00RHUY; Fri, 28 Oct 2016 10:55:19
 +0200
Date:   Fri, 28 Oct 2016 10:55:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org, bmwill@google.com,
        pclouds@gmail.com, j6t@kdbg.org, peff@peff.net, simon@ruderich.org
Subject: Re: [PATCH] attr: convert to new threadsafe API
In-Reply-To: <20161027221550.14930-1-sbeller@google.com>
Message-ID: <alpine.DEB.2.20.1610281053330.3264@virtualbox>
References: <xmqqy41a8hxj.fsf@gitster.mtv.corp.google.com> <20161027221550.14930-1-sbeller@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hvRSNeBBedAbMfzaAcgCNKXyzYSVbuTLlhQrXBGqsjczEaF3pH8
 HswF25F3M+litAPJfx0OA/natQZm6UOSqYt8oKQSbIUv5Xij0usX3JibLPHvVOqA8igu4dV
 P5gkplNg1EE/f8kWkq+vJiC3PNyGeKQJ2bI7CR01UJGVr20TMmeb/2nSOG/f9eqS6p7CRuk
 xZ/xHI8m42hFBcWld5MjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ihvM7MaQadk=:zgoQXLXA4RyOvmqN+WYsig
 YeqfGqI2ns38W6jyRGLDCPX+E8nnpcAIBcZHloR7JzlKwca8DwqHkX3lkK/8wphQn5Qljdv2Y
 hrchUQumQo2s2KEM/5Q8VmiF0dksfFRdKX1x6u3beTXl3T5BrCj1NivdER3UEmqRnelnilEY4
 iIzRf4lrQjqpP13wl0XkS86zwYfnm2UcRwjQy8tw+bAWefYCQ9IbzxNjT4iE2xbh/+qK1jGaF
 EzGs8XtVXTLURmjCN6e4akkpcAgQaccK1sbJPnE9+q/LKkCf+G40NbPOEHtB8QPn71Diqc0ts
 yGaQhzxkhQbV3iZdKklXmYdsjwOjmQNFNWtfeYdSr/Mu8vsL3ibqsWTILaITTAlyeVIw/+RIb
 aiZ7XjW+Ics3HJKsqr0AmifnXODBuyP2DD/PaBm/2bONzLtj0dTCeU428z9saXo9BxPHx3kWy
 9iY5AaxzNHa7TI1eBLmnfXhm9t3xsTXv7a6xjKW+J5oS/e2Rkh8y+F0hkgGcaCQgXkifWsLC2
 qX1IcjudEdVrmak0VJPMy0ZTHnXdi4hLCFqwS7vx2QNAKWfF7ylQrNPqrhL+0W+bsfic8SQgQ
 xBcqEcnoLEee98N956dbWkuUsFGt71j9swc+z6Ycp955W0pAYtziLSQnw3eCoomku8r2hSq1m
 bROPe79T4RaGH9gw6aSv8sA5QJ4xhOo+tkvcSX3m1vh9h4jRPtl6LXdwNsYwi6RTVkgOrYwr4
 DfOEgCzYutTYOYSuXygNPtGsddl00AWQynASe+aYuwnOuYXVJn7ZVSZopz3BnrKFsGOASe186
 A3f+PZ1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 27 Oct 2016, Stefan Beller wrote:

> * use attr_start on Windows to dynamically initialize the Single Big Attr Mutex

I would have preferred that call in common-main.c, but whatevs...

Thanks you for fixing the bug,
Dscho
