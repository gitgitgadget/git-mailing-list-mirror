Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D52BC2027C
	for <e@80x24.org>; Thu,  1 Jun 2017 11:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdFALL5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 07:11:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:59417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751475AbdFALL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 07:11:57 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lhwgc-1dkRZN1fTG-00nCvx; Thu, 01
 Jun 2017 13:11:43 +0200
Date:   Thu, 1 Jun 2017 13:11:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Kevin Willford <kcwillford@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 2/2] rebase: turn on progress option by default for
 format-patch
In-Reply-To: <CAGZ79kYns3CWS5acxGRk67mqdfBvPC=hngnNyovrOkjRRwhRCA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1706011311290.3610@virtualbox>
References: <20170531150427.7820-1-kewillf@microsoft.com> <20170531150427.7820-3-kewillf@microsoft.com> <CAGZ79kYns3CWS5acxGRk67mqdfBvPC=hngnNyovrOkjRRwhRCA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zjtAKgOWyevGQP9M3868O+80Zid8H7sy21qjTs/bxxUxqkjqVb6
 kgmSjnI06B5E/Kyz2xZPl2iHwzNpe1eyHthpZztSmON4ZKdVi3RR4V/64IgvwnH3hRaQ+rl
 7kWyA0HwfRGeYSb+AQm3jkvjrAKd/FN5n8fWKgwX0We0f2uu0AulOhdWDSCV2AY6m1Zbfbd
 2108Ael9/jcKzRRnLL7oA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:daZJeOYQfGY=:ebhNYwlEzT/KI93JJlRHo0
 Nb0zB6URREn81FWJXYwN1kfsT8zuAMLljH+fgtKc6uiyCs2qOKiEqMgL6QfE8femiWg5XQY2o
 Ptafb8Wz+60Kasc06gOC4QmYDFE8tQG9T371w+W/9ekRTRF4wHOXj7HhWG/u9/NSjNw6pVJoM
 Uep/ve9dYnt8vulyhASjFsbDBqVxq8mZLVQy58+T1p7iKUbK+dAt26gCX7p/qvozcVQLFqIGM
 Aqz8ERbvnQlfod8PSBFLyfyc4TSV0kQrNIhT/fG7kk4w34pOHjA12Zo6MdMzu7VbnaEGGUqWt
 2K6fXYD4dfbC+xhYCWGZyQkDpX+GuLFDovh8L0WTcGEG5kf03+hWIw3VwqMUIrU5MQCAnysGZ
 y3NS/cL18tG4Ux0WNAW6yjF8CW0bA6wbQa5AkB3JJPI3ooU/XM/a8lGTkyL6Hzto8m4hSTeqE
 fFtFtiEBLZNcBZQYGETcVM9itN4z93YhjfQM8hhaypsn5DVSu6X8L6nJMrKEy9ylwJQkWKX0b
 E7UfJxhhDNcbL0JRPMrg4rSLxu1P8XqmF3MkofEjPkYnOcFrJC5rhX4D7G+32WNXAD3EOMTZQ
 lUcyhGefZhmeQt8mtXKl44cKC7QoiY2aOYLGd+jp9HtWb+QLEaheBOW8ZAtEX1/9L2fS4ikZV
 VKhtXwVqeuNjcieWaMNPhtFstqtDZE5qvhMbE5f//lc6y30F7yD1rEf1+2zLsYys/VuYl+ZNv
 SDwEcqLHQDRrreNkUer1QMzAjcBPl/rCqrYdV54pR70nShFMqUFUazHM/k5zyUOZF6fRkJTtI
 bG/zvy7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 31 May 2017, Stefan Beller wrote:

> On Wed, May 31, 2017 at 8:04 AM, Kevin Willford <kcwillford@gmail.com> wrote:
> > This change passes the progress option of format-patch by
> > default and passes the -q --quiet option through to the
> > format-patch call so that it is respected as well.
> 
> This is not conflicting with Johannes rewrite of rebase in C?
> (rebase is a huge beast IIUC)

No.

Ciao,
Dscho
