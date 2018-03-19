Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E9C1F42D
	for <e@80x24.org>; Mon, 19 Mar 2018 11:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933063AbeCSLYf (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 07:24:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:56013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932804AbeCSLYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 07:24:33 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgqEs-1eIVvz0dL4-00oBbE; Mon, 19
 Mar 2018 12:24:17 +0100
Date:   Mon, 19 Mar 2018 12:24:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Matthieu Moy <Matthieu.Moy@imag.fr>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org
Subject: multimail/p4: issues identified by lgtm.com
Message-ID: <nycvar.QRO.7.76.6.1803191217410.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0bCDNflgm+EsOK8EmMLUxJNk5m8v9XflTSJCDOui7gjqIShu2M1
 lEj6rcSl2+asbqHI/HK+0A5tzguuY122MXav25E0YBScLWizMq38TyQjyaz8tW0o7X7fTgs
 fmEGoY3UArV/eKjfVMSfO6fHBf0mFJXn7Ccx+dqfD2+wGor46fov6gD2GjICJMjNoL60mVc
 AlgHbskH6tq12CrKDBiTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LEi7ggFAado=:iXZhcx2DtQj2Pv3V8AWveQ
 HvFf46HNOHyrSsovbicLVdch2683TAunDlGqcyOlHKWfSEXLm6E6I3ego1GTuQZwBVw097b8h
 YcsmxYRzmZY1bjWVtdijya94Car1hRD4Af8I5twALkVuuw0coInmCyHVQTk38Q1fstfGubFDO
 WeuWkx+mBwEKh+31TbYRxNnsqGGGFsGjf+i1Chkz2Ubon6efkprxW06BGI85KQxEjcZ/SN9BU
 0GzxJ8lXresfnKEwaki3BppJDLbfq7vLNry54TZvaVG0HIr94/ahbghhcO+qYLt1k4PT/4Or8
 thFJwT70iOrfBEJlxAt2vHfUwSsiVgEMQsNjY5+fIJh3CGIDaPi1tqlfdu7ZCfl5apiWQQYJr
 xCaMZxL5ipTBDa2Mzv5RC78KxNRCGDtz03vqozDaAt+y1KzchFV6PY8p73OUhqrBKYCHgKplz
 e+4u6f0rAE4FC8h+lioQ7GY1xT8RdUWGcY62Qpf/dtV6pLIoSnSe2EW9L2C/FndgEK+y71Wu6
 LJhlanwNXMhm+oEm+78mwdO/XajhcEa2eNBUnc7mpN7BM6oT+cthkJJCQAQMUE9FQfOtz1LXh
 biT7mIbYcSMn6xa2TmsuhdM9U/kOy5PazquGwS1f4cg7VuIJAtLWj4xUGFfbK6h5WYuP41Q9i
 Tw0AT0Jicl8f3S6x7GhpzWtI2wDX3NCmLMpfz4TKC0Cc8j6CQ1C+OtBnCZfnq9AmW31kQWjjR
 +4D+0dsB/ualKLF+rDCr/lHWYIYqzHj7pTg1svFmM9n0oR7vRaj/gGFZUnPmPno6k/lWUqhnG
 wPNCNVcqX0xLExeAjGtQCxMKMyPMLM96NpqUMyleJ1pFk+ibfw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

while Coverity was down (it still is not reachable for me, but I guess
that's just because everybody and their dog wants to catch up on a month
of work delayed by their outage), I tried to find alternatives, and one of
them is lgtm.com. Their C/C++ support is not generally available yet, but
there have been a couple of issues identified in our Python scripts:

https://lgtm.com/projects/g/git/git/alerts/?mode=list&rule=py%2Fcall%2Fwrong-arguments%2Cpy%2Fcall%2Fwrong-named-argument%2Cpy%2Fexplicit-call-to-delete%2Cpy%2Finconsistent-equality%2Cpy%2Finheritance%2Fincorrect-overridden-signature%2Cpy%2Fmissing-call-to-init%2Cpy%2Fmultiple-definition%2Cpy%2Fredundant-else%2Cpy%2Funinitialized-local-variable%2Cpy%2Funreachable-statement

From a cursory look, it *does* seem as if there are legitimate issues
there that want to be fixed ;-) But then, I am far from a Python expert,
so my impressions could be completely off the mark.

Ciao,
Johannes
