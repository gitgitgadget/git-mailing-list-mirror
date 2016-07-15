Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720342018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbcGOKtw (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:49:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:61930 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932505AbcGOKtu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:49:50 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M1RHp-1b4PKE14mX-00tVUV; Fri, 15 Jul 2016 12:48:51
 +0200
Date:	Fri, 15 Jul 2016 12:48:49 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Andrey Vagin <avagin@openvz.org>
cc:	Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] git-clean: remove fifo, devices, socket files
In-Reply-To: <CANaxB-y6XW7-ps1G2CB=N9CiD0VnSLhSer2nsf+2R4pm5TyswA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607151246190.6426@virtualbox>
References: <1468550579-9298-1-git-send-email-avagin@openvz.org> <ab717fc4-fd07-53d1-1a88-ceba6155889c@kdbg.org> <CANaxB-y6XW7-ps1G2CB=N9CiD0VnSLhSer2nsf+2R4pm5TyswA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+kRauS+Ignd3yfVKI79MPF70uOVK7H9cghepxxieM91g+nmv59p
 lj+cIpGX3GNJmeaaM6H5EDRbAnAZBcNnlKYa8QpzLOYgX0bdp8faUSZr+CdW2hGxsCpxEQC
 3gZOTR2Ek2w5ZxSELL8QuSpBp1DKS5KtszvCs3/3d+e3QNq+9+Bu9LZYmJQlrWOXARPMpUU
 BHJQw1TERXMjB0S/gosuQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:J1F6mXCzg9Y=:GkHtsO2lq9ROTGdr4MCMiv
 VuFDtcvU3oubi+DCVao8d+fU2nAPNpkVjnTPLmf2sKejwr8moc3YxOxx5/AcRrUZp1WU+GAH6
 ckWPD2l71FTq9OkRLJgNEvjGVGF1S80Cio6Qgu3fW8XZioFeuHmMaWSpmlENIhI15ssmAqlFO
 X327oNmcEy3X+4AyVkKWD7BWg1OTDTHMyNQspsSn1415vU1GdTTVfW/BRY+aItouFG9g9t9AB
 gQByMRYyvn1KfibV4cpp2UXGTRb8XHNcZ50UAcy9+YBSsH+SyyH0LvRQtI4XaD6xCVCnU5qSl
 LMxEqmiASnk3x+pU53dq4/cOmNnXMMfynyLJvXpkDmJsu1lFBaQl34Zy3wbrexLDe5QMsT13Z
 Rt1Ck3J1F7rlT+HCP0j2zIQ+7bj4VuIKh5T5Vc75+QsKQHtO3DXF/F6ZrJOapN1ACN9hWKBap
 /FJNAYZ1e7Ynu47oHyUMikcbuVjICirbNVU/hKPOCLCcqpQ41fw9hPM7s1r15P2K1diAuZdEa
 eK4wO44QdjrkiMFNbYPW/SWJnG2vGMZ3fZEexz8ndOagUbKtcg+DMQSzCkFzbLdxkz+xm3AUx
 ewr33qOpwFeuCTWIBg4PMCT6eaEf6favCU10FZJjen012NwP5Wrqk/YnRVuK0imme0XkOWrgz
 GjxfmBBFYsx5S9Y2jRG5dYl7nuu8+WhBORd05UuFF0Rjpnth3CQZL93jwedYYDnnQjAOnjs+h
 eEwiNePBBI+f5634w0xsfhe7lpd+tIATMd9OoZgOW3jJ0tcmMCBRipkwS6X39KYAfhoaRf/An
 J3jWoZc
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Andrey,

On Fri, 15 Jul 2016, Andrey Vagin wrote:

> What will be wrong if 'git status' will reports these [fifo/socket] files?

`git status` is intended to give you an idea what to commit next. And...

> What will be wrong if 'git add' will returns an error instead of
> skipping them silently?

... we *cannot* commit fifos or sockets. There is simply no representation
in Git's data model for them.

Having said that, I would welcome a patch that makes `git add` complain
about arguments that could not be added (and are not directories).

As to the patch in question, for the above-mentioned reasons, I think we
want to keep the existing behavior instead.

Ciao,
Johannes
