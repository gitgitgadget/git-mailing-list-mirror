Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0851B20373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754334AbdCMVo3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:44:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:56503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754311AbdCMVoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:44:25 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkgAG-1cDO3p25lU-00aUOX; Mon, 13
 Mar 2017 22:44:01 +0100
Date:   Mon, 13 Mar 2017 22:44:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v6 03/12] Prepare setup_discovered_git_directory() the
 root directory
In-Reply-To: <xmqqr320rk3z.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703132243320.3767@virtualbox>
References: <cover.1489098170.git.johannes.schindelin@gmx.de> <cover.1489435755.git.johannes.schindelin@gmx.de> <8d8be2b095afb215f5bf0e0bb7989c9c9ab3f471.1489435755.git.johannes.schindelin@gmx.de> <xmqqr320rk3z.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aoKPpRFrMfNRMDdVb/QEwkGiOiH7BHAV7Zy58FU5KCfAgQE4Gil
 +3OV3rKRqLQf71VFgt1lgD6Rk67UciLg/5T4gzTM4WYwhRZ6WIU1iIjOpIcXitiIjsMvoye
 qdml99B6pFaqaX4LiXRrD2c6OYeEjwvrB2Gfm1Qg2fnkJKPVXBZBgYMI0MLFg1ov5zqycK5
 /PuVez19dLhqNENVJaljw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FZFU7w6B2KU=:FaM7cGPonTknTcvXmOErp2
 s4Yy1jTxSJ3edmZLJA1xSForQi+7qbcySN+wc+OzN/TUIx4UCaEe/TzcTmIf5QpDX7aZXy5Sp
 bAlUXM2IWjDlHDA2DshYoN+yjki/QYIj9LNsfzzjeFMqvK8x7wTEDWY8OyqSjCnn2sxuTWlR5
 Ow4+1Pi9A+CErW6yc8LWDSn8SrDtBjkagbneKM7aGUjfcN5yBcIKnRa9N/tkzcTVHIFCYUIL1
 +uv//tCzEaITHCoI2bBNAYWZySFEdhR3phDX2YD0XU9OWt278x434oN0prf+7kmRQ6LGveZrn
 2XToKT2dKJD8Rn4MCQ4anUhZlGAKdL197ThZ81U+kKTDjEEPyAI9n1bTvz3pHBE+BnrADqaSa
 oKlpQiYhGpeDueeB4KzFxtc6RWXGYLHTp3FO667ZxfZt7g69HgjM7N8CklwoT56wz3Ey2gfcp
 QRRgYeogIqcCy+5cjNg0Ta2QuYv2Ubs/fwAGiYSZ+hmp3Y/OoWEtUJClesW3aQxF321Vs8jhQ
 1hMpcnjsRnA6CfekaGw0aoCp6gSf5rhQWasqT38yvlbP/IoUiHwhBIGAflcMSOfHcZ7fPXJVR
 hgERxaa68/N8K9IUeJUoXxgC1eqztiOi5VRZf7+WIQ+1tUt46BVuDO2val705AjO8Kx8QsFmR
 RRy1mW7s9CoN72MSsIcBeBPiGREUmgwvpfL/dodyK4nfSMBtfbryxlprEEXyPAPmEXy0JWpRR
 jNo9mhSODgPxUE2+4JqN5eFzPJw8NjG8zeqPm3PdCrBD8W7YWRXdb0OXLTqmQ4vST389YlQj5
 U+43a6b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 13 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Subject: Re: [PATCH v6 03/12] Prepare setup_discovered_git_directory() the root directory
> 
> I do not think you've changed this title throughout the rerolls, but
> I cannot quite parse it.

That is because a "for" is missing between "the" and "root".

Ciao,
Dscho
