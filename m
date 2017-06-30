Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2209D20209
	for <e@80x24.org>; Fri, 30 Jun 2017 09:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbdF3JJX (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 05:09:23 -0400
Received: from zm-mta-out-1.u-ga.fr ([152.77.200.56]:43053 "EHLO
        zm-mta-out-1.u-ga.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdF3JJX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 05:09:23 -0400
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.58])
        by zm-mta-out-1.u-ga.fr (Postfix) with ESMTP id 7EF41A0329;
        Fri, 30 Jun 2017 11:09:21 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps1.u-ga.fr [152.77.1.30])
        by zm-mta-out.u-ga.fr (Postfix) with ESMTP id 7A938E009C;
        Fri, 30 Jun 2017 11:09:21 +0200 (CEST)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 7146F125EBD;
        Fri, 30 Jun 2017 11:09:21 +0200 (CEST)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     =?utf-8?B?0KHQtdGA0LPQtdC5INCo0LXRgdGC0LDQutC+0LI=?= 
        <s_shestakov@playrix.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug with automated processing of git status results
References: <CAM1TZMGXiDpzt3uhpDaE41KR8GWyjMq=+Mcvz5Zrj0EffNrGrw@mail.gmail.com>
Date:   Fri, 30 Jun 2017 11:09:21 +0200
In-Reply-To: <CAM1TZMGXiDpzt3uhpDaE41KR8GWyjMq=+Mcvz5Zrj0EffNrGrw@mail.gmail.com>
        (=?utf-8?B?ItCh0LXRgNCz0LXQuSDQqNC10YHRgtCw0LrQvtCyIidz?= message of "Fri,
 30 Jun 2017 09:00:14 +0300")
Message-ID: <vpqr2y1u9j2.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (111)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Сергей Шестаков <s_shestakov@playrix.com> writes:

> I understand that we can turn off core.safecrlf, but it's
> inconvinient.

Note that you can do that without actually changing the config file:

  git -c core.safecrlf=false status ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
