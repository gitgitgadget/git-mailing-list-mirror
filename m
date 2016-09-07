Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB0620705
	for <e@80x24.org>; Wed,  7 Sep 2016 11:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938654AbcIGLfT (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 07:35:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:58845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934982AbcIGLfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 07:35:15 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Mgt3g-1bUJRf1q2C-00M510; Wed, 07 Sep 2016 13:35:11
 +0200
Date:   Wed, 7 Sep 2016 13:35:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] t6026-merge-attr: clean up background process at end
 of test case
In-Reply-To: <1953cc16-7577-16dd-fe7e-f557e7a74f58@kdbg.org>
Message-ID: <alpine.DEB.2.20.1609071334340.129229@virtualbox>
References: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org> <alpine.DEB.2.20.1609060909420.129229@virtualbox> <1953cc16-7577-16dd-fe7e-f557e7a74f58@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Q1Pmxu2uE/O7brscyy6znoc1VFwZ9ch8kpdEdDflonQ9fBxqCTr
 qhWd888vWP+SI/6R1qRIzdtqa4E5ZEfnzEML8TRxJRV+gGW9SoaiapxImi7pmE7J+ZI/Czw
 8xVb0isZfPUU25q9qEguF1EMKUf2Dq96avqcxAbr5Eu9gJl5vc0PAN6HXP1oAgKmO5okcbf
 5aHoShFyrD4EHVxa+wc5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NJG0sG/zAYY=:KSzz0QN1TEIHpg6L5iQMCP
 7GFhIglG5OEQ8L8EtfEiugt9C6OVTkp9ZUciIpp+IjlYNoHhgzb8s9DedsAdVQBg8R+EB14cq
 TxXdueB/1s+DNCq/9br5WW6Wf7L9jUZjfhcIOxTqOd4jf6TxWQrk2cWmdIiU3WtfeViHibHuN
 Gacb8VuMJMGsbx+DGlraJCvDwI5yZ3BzgOwV/msGymMskyT5ujkTu5ZU8O3q/KPckEEb+WRp8
 5kHoOr9DMfD7vq3xQus9GjJYyWczKb33rYK/A6FZvDevuW4+6Ojs8HcSgxMIMwOl8A5Ma7JPm
 z5/by+zjreVCjaPlpryGbT46ZTGbczVHHIl+a5E9w/OlV1zur3kkjEQ6FcN9fDr60qod/tOvM
 4hypf5h2w3jkg2kP4Uy53MlIlFQLAoy/cjuRZvpUMzZ3sP8zJpudCUjt97hR1STMFHMxaKEP9
 zjdICzIUP6VCIhwOQXJaUgshoSn6aEWvGgPYEzHEdmQ7LSOR2LsggaTc1LboXswSO7YAg+XO7
 jJG1kblRYrAuYpjh1b9GrpJWhpwhBP2AzX0V8LDcqfTEJLHgJ21SuMVv9EgJyMYHH3KeqJrUM
 OiUnG/LrEiA67gdNqnbpHlobkvse1oxh1HrxBDOH5BWo5mEWAxUyJ4ifMeuGjJu4U/2LiYPQ7
 X98Bs+BTHZTmi6/Fmqk+lUA29nu0P/y719qk+3rzr1jXvI7CAbo3wAz2X0yfs+RyUbqg5h45g
 oWi2mWfHab5eNRqqVhs9iAFREW4AIGUjwV+95739Md0bJa6csD8GMqKZgHfZ7tqee2qolN9lh
 fx7ccgo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Wed, 7 Sep 2016, Johannes Sixt wrote:

> I did not extend the sleep time because it requires to change the file name
> in the same patch.

Yeah, I was just concerned that maybe we would take longer than that
second to finish the test. But I guess I am just too paranoid here.

Thanks for the patch!
Dscho
