Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE031FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 23:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941513AbcLVXFz (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 18:05:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:64981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934000AbcLVXFy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 18:05:54 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzoSt-1ch72u3p11-0154H6; Fri, 23
 Dec 2016 00:05:48 +0100
Date:   Fri, 23 Dec 2016 00:05:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] add diffstat information to rebase
In-Reply-To: <20161222221327.7354-1-sbeller@google.com>
Message-ID: <alpine.DEB.2.20.1612230003470.155951@virtualbox>
References: <alpine.DEB.2.20.1612222239390.155951@virtualbox> <20161222221327.7354-1-sbeller@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2pLGFg0Y/APNrpBYh9F7TJ6OIvhXEpLSTz94VSxVfWl1UJxodNz
 Me7md2V66Pneqq++kHg7FwdXtE1iB9wD/WqJyxpZ/acOOBivn1VkUCGfr5p2LOhGtCwcbIj
 r56F5Asen1lI5d6w1LVwO4y6kfs5gUq4MyFigMlLeDKLhl4MRzaifaRjbrXKPcPnO+zGENd
 hH8ZmCbCizEecOdrl/woA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uDo/TKulnJM=:zow5o/bqMTqR2FP5pz/eU2
 p8LBsVw6RtRUayXa81tWHNr5mXoDQSLETtqYf9fdCdyOyEwdqmjjWnqqmfV74S6+yMiIpdi3M
 kPjjAwKAbo1Qvoar+YVpLFvHoWJNip+Y5lEVEXF0UX03BFW4uge4TZONwrEG06+8zOxyfLquN
 YerNqi0/djYHs+duWMVJYTQK0pVxGFVHdRchBrKbTNUwqAORUKidWByLpZWShTKMF0uVwkgs6
 R14RDCl4amKuJnrj/WDpzXVQAuo+Xlr74ldTd31y5tP3CqedAs/Mve1Dve3FLWC3IlbLsrKjB
 kY05RoRO+5RYTp5QIeOueaHdcca5ZUOUz8kqCL/eN8UeUqAqFZEi3WsUM+ClkPdGP2VRSyeXo
 IPo/La7FpBLYq5bkii4gRPlaIB8RCqTmD3RvmP4fCDw819gLhCq+PI0OBvDazCawOm6TAzlNC
 9yIUEgTJLfgLfN9rNe9+zTD2JXo5VJxjWNA78mG46K5+nDnAkHUYOVxpl4pWTP3L+Uu1R9AtV
 txDff/y5b8PPX/sRexYVC4BseLpI5gDUNhiTSucxTKRXhDe5xWCStQN/ruF83z5o7PAOO3vG0
 Z3AdVVVOkYHGMjKmwdm9j09PQnAJXJ6fWfCIFYkAGftz/EWsIrmfoavKtaIfQxK9jmbMt3Wc9
 v+Yy4qeJBX484e3yuGP22Lkbzt+KbxP4TBF3ooMkRrKfIekuAXXuxi1Ly4PSTWIxfo2Tr5loe
 sthl5/w2txYw2bziD/I+LJFub7PGfdfFYMj4zRn71mxSWlVnK0+jTTGamLfzjZ071VsJ/5NYA
 akZlZWkUCLcTBQRJgrqgsnwyNNFDRXTH1sWf1efsjQ0lww4BydyRSvGQoaR/T3raqebccMF6Q
 xiY003XRnIDaeXLo4M2C7ottdazSiWo6aWeD7qg/BV03JzmX+XfR1sbr58pT6aO054BWLmAGf
 BhUfnoT3GwStiytoc94WGsM0T5JZVefB3925zwbCYCV4aRMsi87lrPm07gCUhX87scJg72QI+
 FJ4AN/i6lQt0RxBNNvTiIWI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 22 Dec 2016, Stefan Beller wrote:

> *Ideally* I would rather have a different formatting, e.g. maybe:
> 
>     $ git checkout remotes/origin/js/sequencer-wo-die
>     $ git rebase -i --new-magic v2.10.0-rc2^
> 
> which produces:
> 
>     pick d5cb9cbd64 Git 2.10-rc2                                    | Documentation/RelNo.., GIT-VERSION-GEN -..(+5, -1)
>     ...

That sounds more like a patch adding a new placeholder to the user formats
than a patch modifying rebase -i; by using rebase.instructionFormat you
can implement that "new magic", and the new functionality may even benefit
more obscure use cases.

Ciao,
Dscho
