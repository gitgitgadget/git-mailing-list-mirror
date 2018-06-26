Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF881F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeFZVpY (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:45:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:60989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbeFZVpX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:45:23 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRCCJ-1fjnZy3eet-00UdIw; Tue, 26
 Jun 2018 23:45:18 +0200
Date:   Tue, 26 Jun 2018 23:45:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 0/2] rebase -i: rewrite the edit-todo functionality
 in C
In-Reply-To: <20180626162143.31608-1-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806262344560.21419@tvgsbejvaqbjf.bet>
References: <20180613152211.12580-1-alban.gruin@gmail.com> <20180626162143.31608-1-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TJhKlcIL0dg1oNrHjI01VIDrmhSHrS9rfUvovX/+xh4rNPXDpk1
 Rr6K+BYbH+8TiOBNQ24H+C46xbj3FT2PRfujH8/mxQ4GhvWfbwjKZGAxYqVKnzgEYLm6dLA
 SH8egWuPUn5jSKYXdWnyaxyeXIFIORiaNAScGWpEeK/MOa7R0C+3AkPe/+TMtqDcEqeQmca
 hQ4OYsI13pTjCi1f6tgLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hiumqQJRoPE=:55uFI5MYqyDkvXSFTQmEr8
 FH0sYNP8B0ux3FL3ANuedlfLjgiF9I9C0Wzgbw0U9pAKPUFhfs2ahvtWnuX8+7lp/gI9bKBqb
 2jV9KSmzkYjzH1v9D+e1XQJis8XZ3iz+C15AIen9I1V5A1zMfRl4hfIbXbCYCnMUdZe3G/Km4
 ORe8XJe6U2NGNpXlsPnkazVSfqAxPfYSrn5ACmRbeGJ/xcGhoGh185V+DUysOKxcWfaEtF2bY
 wfWw8SuNChqvvof1KlhcysV3cppeI3nJTXWW9ka7WhOEDKG1hetcCvyV9jH865lWydw875r1Q
 79t3WB/mOPgLW8O1+DhrC2NhuWuEfwymaz75UmajCUifmwzdTz/rO+6YIsO+3YY2aytQXR5js
 NNdwfwYPfd5I8MRCeXm8G9k1XQnGvyqfOH9R7KDAtKjKJrQDXks9t+y4PPOuIvfZgB0dq5UJT
 ExZU6dBzvatofcyN8J2o3lPAjYqWAduoqzKHaxsbFu3u742TImaPWgCCmWNX1BitMXdUeciGT
 rtw1nQiQu7eLqhWVo8MO6Hy2B44jqnsJXmMc3ZzcvtmtUg60SsZ/FDBzMTu5TKeccs0YXzbnZ
 mCr/p8ry5N40D1D+3xMXqdNxV6ih0Qc18IwKqhQb6s8/BxlHKf+1+zd6hvLuL6lhmOisbHGVw
 tQhd8//TyYLMC+2AozOuMkNZpR6+X0i+YGlg10Gv3a/flfda6YgBqPxgbtYhtwWKlLkMYsA/Z
 kQuckNYkAlf9VkmAEB66xIhIKPhfYgmzUBfx1voZf0o3+5wEgmF1Quv1+vhv8+1QtDGQDnJ2Z
 omfsQ6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 26 Jun 2018, Alban Gruin wrote:

> This patch rewrites the edit-todo functionality from shell to C. This is
> part of the effort to rewrite interactive rebase in C.
> 
> This patch is based on the fourth iteration of my series rewriting
> append_todo_help() in C.
> 
> Changes since v2:
> 
>  - Moving edit_todo() from sequencer.c to interactive-rebase.c.

Excellent.

Thank you,
Dscho
