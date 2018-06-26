Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18BE1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 22:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeFZWC2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 18:02:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:54271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeFZWC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 18:02:27 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3sy-1g3fpJ3aCq-00ev88; Wed, 27
 Jun 2018 00:02:21 +0200
Date:   Wed, 27 Jun 2018 00:02:22 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org, joel@teichroeb.net, gitster@pobox.com
Subject: Re: [PATCH v6 1/4] sha1-name.c: added 'get_oidf', which acts like
 'get_oid'
In-Reply-To: <4c1f71b067ac235c3003d58e1f3dfb07866be129.1529943789.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806270000180.21419@tvgsbejvaqbjf.bet>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com> <4c1f71b067ac235c3003d58e1f3dfb07866be129.1529943789.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fGr9bEtmMpp6OILTq2QetZfElvAlBwLeZMHb5cUWoLlt2WCKOF7
 TF0XNHcIHp+7oNiIjM37iWxSHOqIE6Mzf2zMjzQdAQSq3JNrBb7c9RkHuA/YsUIyKPh/n7I
 v0hhyxjXEjf4gtED+mP7iFryj9GMt68IosZab57saFQb4cbe+adv6O1YY2q4misufOv0d+L
 9LxZ5v6TkRyxlZm4sGNTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3M0UvHqdcUQ=:EnWE8cLYR9Pn30g1hK44+T
 aLOPhHkc2OZ0wbid7+YGTKOh4WJNODSbCzQvh0koCVtuowl4+ejbQiaYQJk44GIiWlUkiKYRY
 +2RMY0oa4mJvnQPDOSc4NDzSu+qPnS3S6a9AzsI+jSKJ3wAD0EzXNFQ9AKR0wKZ3r9he9Sqp1
 4ZN0RLD4BCEXKAzghRWjOYZqymOLxVhK5VYUUZ9tl/GeixJt7t/tdmJ2kR6lbbhMvdtSvZH6E
 81wUsHJ+fGbwiaz0Wl6JM/m7BrRslixr+KFJRTKcMT4B68D/jwsSMRYi3eOBmhZlu8FB1ezWN
 PB4CwlyRIONfE7nY6Hyc4kuNkaYtQmrKF46O/tqL/ebxqt3Jb74OovPIZoS2+mQVxeLHcqh9E
 vyKPHAjJ5V2mxqZythtpZufUNkpQWGvISUWpJHFbvhAahWoUFXUyh0ugvTXVkYk+ESbaPQRYW
 mgw3x7U3YhNXlSPgRMmgLZn9DPF18xal/vP4ygoNtwhL4inyzy+fHW0cycTWImBPtqHxYzKzR
 E842rQO3bWCVeXUFp2OtjHudjuF6MKQ04Mq0lqtq7y2g61yJKG/3DRkqMXEIz+uvu9YUrTA7W
 S9wuGinQ1+xgKOVE6/pcNA+tscFyfiLTCA/cx49HuhhGM5XeFM9qbKaOA5loPDkkWcXlVAfpw
 Jncb7dITMNp+r6WBPro5y9OaKAizPmcOuuBZHmmLcDGrbsxXAnUOaWUvfiYinRStm1S0uBEx3
 Eh1wOcAo9O03G6VGpMGqjSwRyBX3HwgiiKn6h8NJ0IqZZR4xflcELfDH9Sgsvf4GjyfHDPLLB
 ecY9ziQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

as a general rule, we try to keep the commit subjects in the imperative,
i.e.

	sha1-name.c: add 'get_oidf', which acts like 'get_oid'

On Mon, 25 Jun 2018, Paul-Sebastian Ungureanu wrote:

> Compared to 'get_oid', 'get_oidf' has as parameters a
> printf format string and the additional arguments. This
> will help simplify the code in subsequent commits.

Good. The patch is obviously correct, from my perspective.

Ciao,
Dscho
