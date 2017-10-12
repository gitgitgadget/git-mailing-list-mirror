Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F15D20372
	for <e@80x24.org>; Thu, 12 Oct 2017 23:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbdJLXSH (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 19:18:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:52992 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751631AbdJLXSG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 19:18:06 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0QLp-1d8Cm544SL-00uXuf; Fri, 13
 Oct 2017 01:18:01 +0200
Date:   Fri, 13 Oct 2017 01:18:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: is there a truly compelling rationale for .git/info/exclude?
In-Reply-To: <alpine.LFD.2.21.1710061337300.14079@localhost.localdomain>
Message-ID: <alpine.DEB.2.21.1.1710130116430.40514@virtualbox>
References: <20171006061434.Horde.16MqZ-fejqXm6BLpL7prK1K@crashcourse.ca> <xmqqmv54v5h6.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.21.1710061337300.14079@localhost.localdomain>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KMGOBroAflHzHR29PIOexdCFJ23GvDdoZ0km9S9in/N9JtcVf2s
 UXEs5wnojzrAILVUi58Oq2IvasgXQGnDgNli05pacZdglpWE6Rf7uEWn36vNw2vxsB38EKb
 yvl5Uptj9nr6vEu9Im0YpCgyqHSLrnGErzlHAMqsuDz1mofuNgtkv9fwM73CyA4aI7r7Nhc
 73NxLuiZGuGcQt6blbflw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M/JmUiyUM9c=:0ZKIQP16wkNwhWD2q3s73/
 Mtl1uHuJGnAunfuiApuHh9OjgzVNgw5fbz7NlEBEqJ7u3hBMoBCq1NfU1Zt8NFyxHkMX9BiLU
 pxvpzrqcM/KnGMP4JEIhCKzX/8Br+PxqbxVvdIXcO9nrwvZ5HM1WcED0mRHXCGS8YfsKQM4Qi
 aWHn5Oilzh9UmbhjK9VinPPH+/066zG3TNX1KKJtGtsvPGDvehj3TZ4nR3Yc42n7rMRIVauhq
 9ovG9igtkuANbBr2duFVr5lxaFgQ56k1br0GkKPMPYjxQ/KXUpWAlitMJ+xiNpmgIWvKEXuM9
 IZ/QkX9icnLfEDwGvKmsHPwK4s0UzH2DoDZrKH7oshScqdcRxQAllIu0t2ILy7er25Oyyt16j
 MKMzg+kpaUb3AbVtk6c0FkdvKaw1YDNSM/kyEZOfTqMXZfzztpVe/sJFU7UzcS17wUw5vOSTG
 BuUE0BlxOl5kGQeMeTvSlKreIdFHUXgIeaBTA66mrCQ3KKVYCH3pATPpG5dWSE2NUyBosxKRI
 swKrcLS87lmviCM25v9BxgzZrp1XECcgTW1fMH4hKGq9FqWGUbElidBzHLnqFVtplCcCSiyr/
 eISnhK5p5ZIlg0LBf5IV8Ssb3wcjhGt2Jpq0eF2RzSwL931LSLUAkJMf2P+Xf5gFzcNsstnJP
 2FDKMHKdZY/E3WICps5w/AZfJuCk8o6s9Zn4vTHNR6BoH/wUm2EhrnEP3+tj94i7fC+5NEVK6
 mleejlKIgSfpMn/J3rMO6Emg6V4mo5eMgsnQJl+0Pqcuz0zip8y6Eh6lO23F3J8WpMUi+eTVj
 2/bF3quBNW6uJgbU0d4ZUlK9XU7k4kIlEomEp6fQf9hAeYZeMM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

[who I had to cull from the To:/Cc: headers, as my mailer consistently
told me that there is no valid DNS record to route mail to
rpjday@crashcourse.ca, which *is* weird.]

On Fri, 6 Oct 2017, Robert P. J. Day wrote:

> On Fri, 6 Oct 2017, Junio C Hamano wrote:
> 
> > Don't waste time by seeking a "compelling" reason.  A mere "this is
> > the most expedite way to gain convenience" back when something was
> > introduced could be an answer, and it is way too late to complain
> > about such a choice anyway.
> 
>   perfectly respectable answer ... it tells me that, between .gitignore
>   files and core.excludesFile, there's not much left for
>   .git/info/exclude to do, except in weird circumstances.

I use .git/info/exclude to keep worktrees in subdirectories of the "main"
worktree.

That's not really weird. It's just something few people do, but that's not
the same as "weird".

Ciao,
Johannes
