Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE3F42023D
	for <e@80x24.org>; Mon, 22 May 2017 13:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757253AbdEVNEA (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 09:04:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:61881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbdEVNDq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 09:03:46 -0400
Received: from virtualbox ([95.208.58.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPE7E-1dHCpy0wbo-004RFh; Mon, 22
 May 2017 15:03:26 +0200
Date:   Mon, 22 May 2017 15:03:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [WIP/RFC 00/23] repository object
In-Reply-To: <CAGZ79kbvhRzjbfiUNuc364tM8j1TpNEtGt6rtfG2h9Y=v4TVHw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705221501540.3610@virtualbox>
References: <20170518232134.163059-1-bmwill@google.com> <CAGZ79kbvhRzjbfiUNuc364tM8j1TpNEtGt6rtfG2h9Y=v4TVHw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oJyAxks5N0OPvEaAgEFI4pCxjVXS7Gei0rFqvr+TWVVRSh+b55L
 MkCsHQTngmt8AEGfRmuddnxX3OnSzl6f5lIT7oRf4/xiuHWvPABZyiME/UFeawVYbxqNNyL
 SKdivYTV/lEAil+1Yc0/yNcqnztsT4OLP/BZFYvEjEEeDhW9HFSopDhdYE06EVcB53HDAVF
 fA7a5lA5SmhZLIg7VgP5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fBbcOt+2kjc=:90X35UWMFIJ7tEhMJ//JjI
 lpNU4TtTlHYwwTKIzFYUcvJRMC45+Y/x2n2WfqoOwXXuKcOrYZlGF2ZCIwUMRyyhGdbAIlxZm
 LfvHrHmfZRcnL5GvsnbVt25d//c24OvAPn3BaoQ8cJcCsl/+nTlwoChA+PocmdiJvGowS1ErP
 1VekN0ORMSThIMPjZP330OmNs+YYDuqr8Jr3B1AGBMa/GgJYl4dIvo1SF/IP55fzLzafzPMcl
 qhWA6b3u29WtKUWr5RPmemf3qYabI0eYMvhzttEciv8H08YdPo8JhFb0lky5PZW/2nOJxMsZY
 KH1uLh1bKwPYLHHZWDWlqhannLVUsFa2MkOgElG9yQAaQEcWI71O0SuPI0G9tVPhR/4UZ31Vc
 sSYAbsyY9ZTNwX8fAtfeow04VfWKejLz/OZSePOV8meOG1sI/rf5ZBQ+Mro3MYHQRhAt6td0U
 nkjyEbH8gB32eE42c8rKNXiM4VGMHiRhoVMzjMn0NinQTLHHzrsjy8CqvuRfJqSF/uYmVZAk+
 5y1I2hcNsXUkbYvpzxPCg3Dn/WrksXnx1PKAfDnH7xNM49htLjt4oTfqTaW+3VXdXbatLAuPJ
 cnO+0n/MqrtH9/TVuykFmEsHJqVsjxUsjUTkGdGaCSUc5t7CgddiIopgSJYNuMLVFupzEDK4g
 Jkk/xNBykE1UuqcX4rRonLhGWMb5tYGwoew348pS1tcZbFj02OakbQ+9fnjaY/atG6GJ7k724
 e4nUxG38jvX+MUHLLMoqLUhMKejiReQmqIwYg8IXaVIFaLTbkd4VnxIoPgKuBeDRTb9cijM0Q
 0Bv4cSG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Sat, 20 May 2017, Stefan Beller wrote:

> On Thu, May 18, 2017 at 4:21 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> > This is still very much in a WIP state, though it does pass all tests.  What
> > I'm hoping for here is to get a discussion started about the feasibility of a
> > change like this and hopefully to get the ball rolling.  Is this a direction we
> > want to move in?  Is it worth the pain?
> 
> I would be really happy to see this series land eventually.
> 
> The introduction of a repo object will deliver performance at a higher
> level, such as
> * (remarked by Ben): enabling of threading
> * submodules do not need to spawn processes
> * I would imagine that developer velocity will go up by having less global state
>   in the long run.

* avoiding really ugly hacks such as save_env_before_alias() which are
  even incomplete, as git_dir is not reset upon restore_env().

Ciao,
Dscho
