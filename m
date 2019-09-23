Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3EA01F463
	for <e@80x24.org>; Mon, 23 Sep 2019 21:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbfIWVr3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 17:47:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:50051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389663AbfIWVr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 17:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569275235;
        bh=467BgtaphlkFcHQVTDpm6eeZxkn0IawMcAQX7OvEuXI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gk0WYqRWy+GkUzz0vuizPgCv1JejG6czgXD6qB6PR0P0+Nju9KPK4bhJB6NLhIlcx
         E70qS/8/9t/dsdowx6RX2KtSBhZcyZgZwGVmmIYkoaMFmSOX/4hJx/myxp5OJtTE9i
         2uXFbTMgJW8o6o6brxE4aV6NOI6v7VxAjdJWw21M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1iEPrG0mxF-006uoa; Mon, 23
 Sep 2019 23:47:15 +0200
Date:   Mon, 23 Sep 2019 23:46:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
In-Reply-To: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909232335360.15067@tvgsbejvaqbjf.bet>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CEUcLk3Hkf+AdS6/Knb3QBJl6QtoYgGS+eyZ98elHdT/VgNOPWb
 o2S060iMVYE1bV8nyOPeYDYq70ErV5gFhqa26hAa63VFH73fBFSO0LRbxzR1eR3mx+t++xH
 I39kvd6LZ478fK0j8YfxCVxIRhsZ4oN+81hsO6LBfc7RaASBdd+IuHmtFOG0lRo723vbi/5
 jmDljOiCy1jM/NkpqNuAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mclr8giNVXE=:Yt62efYMB8Nel5UI+lN9po
 xLGV84HnjK3NzPxgD7A4euu3N0NIrBqMnO+LPxRwzeFEBxmbbLBs4KH9VsXLiiNCgIhob2KGF
 izwIKEBWrxUQWPNmbxZD3fOT5QAPab4NXMtRx3CZZBw97zMFxN1LjumEgCklOARyRJaG3uEHL
 TbSu2mJszBBSqJDBNU9k5yaVwtO2R8xrRHpIms1+Ij3QpSui4IFSwOiwL/g2COC6NnlVyXy4q
 x7XPTWo1JAX3ANoXBVq0mxHDuXa/h2zOpJhuasbxnRahAOAmq71nV1TqhktlQGvDwx0IHL+qQ
 /6aZ6vx65YwkfgROPmhmfTYp+bBgzvhlhNNhT3UGOwE20/etTZJ7MgWrgkWyFvRUzy98ZKgU/
 XaPkk3dgH1tUjvWGpHZ5h4p9+m0JqQCXIaZ+foHjglKLcPThdNKpApL1nF4V5C8BmlsrN7RaJ
 969xN4GuYeEzzFirevKIyY9M73e5RQwU9eVAuLBisb6ez88jT4z9ZCatASzoIIY041c3VP+hh
 04pXVUD8m25/Q2iI2XerWpO+4eOv1nKLhdiegnUuHFgWG+7IhXr2nqWgMrlkptCHOCmYL6hID
 KvNrBpec5jMn6FBH2AjmGVwr1wgMaT+xqolGALcz9A9/xi9U1QfZp4Fh30YDDW0tLh2Zy1xij
 11hrBLGFzfXT/hr5ZovP2eQWnPpafc5nPWiw1wuXST/IaTdjikdACmmhlQbarL5FOGzN1VgQU
 8RAYnRxVi9YMWCebt33djzvrCfMvfbMGmZBaC+OPDt1gVAiDm8JckFw6o9HR47dLwj9crTWqE
 0R69ms1IqxgrFNB8zsnaeBsUoezv3jM6En+XE2QYOv+UmcqukUA2+/bdeTayHwGg//DhfsiW4
 59h9CbZdCpTND7jkBUu1+qmsUfbprBfYVt1xsEBKK31/wyDn2JNy/nxeeI8lThneVfyLNjdlw
 4XaQtbI5E16M1In9Ga9uS/6/YERZAbH4p08WwV1fOUCBzg3BHYZYfUOC7B1MjqtcwK7kkPYbg
 7D+sNrgrHcnf0y4hl02WB0T7USeCDhIlPiiop7jOagvr7yZC7TE8Bf+YOXL4t4PwQTRdW5OgN
 8tlRbk53f9GirVJSJsiU3fJi0eBPmiunm+53/ls3HbWFP0nC676+BtnQn9RDHx2DM3cYT/R0P
 HB2Bv4KOffYP8FdVwz6CDUqrM869nrZN0VufsLWWoLJ6p28YxW9++BTeEAU2+zlUwKy6l4YCc
 p57HBjHpbe+LliqIJXe97qRAlKFkLcfogjIsd9j+eJZf/IzEf+iYAa3nuvBU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Thu, 19 Sep 2019, Derrick Stolee wrote:

> During the Virtual Git Contributors' Summit, Dscho brought up the topic =
of
> "Inclusion & Diversity". We discussed ideas for how to make the communit=
y
> more welcoming to new contributors of all kinds. Let's discuss some of
> the ideas we talked about, and some that have been growing since.
>
> [...]

Thank you for writing this detailed mail about it!

Ciao,
Dscho
