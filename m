Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32396203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748AbcGZQIJ (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:08:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:58927 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755358AbcGZQIG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:08:06 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LlV71-1aqow21oql-00bHYH; Tue, 26 Jul 2016 18:07:45
 +0200
Date:	Tue, 26 Jul 2016 18:07:32 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff Hostetler <jeffhost@microsoft.com>
cc:	git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
	gitster@pobox.com
Subject: Re: [PATCH v2 8/8] status: tests for --porcelain=v2
In-Reply-To: <1469474750-49075-9-git-send-email-jeffhost@microsoft.com>
Message-ID: <alpine.DEB.2.20.1607261806590.14111@virtualbox>
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com> <1469474750-49075-9-git-send-email-jeffhost@microsoft.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ou3PMiGY3mfc0nYdtwaGayswt1Phtf3hJ8UaIdTxjG/1u+zHio5
 3cHNmETj8QKrnU4hIy8Q9lFPABJJgaVKo4zdj1o+GDhU3OLF1A5ctX4Bn/Y0xs8sr7gba0Y
 1nyPk0cY8UVl6z931qFMNwYO55lClMRTSap6Vg/di9oIyIW6/w0e1agy2Mi6/M9mWiWrUeL
 9g7fouHqTINl0cuMNSxNw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:eobyIdTEnjk=:yPaxUpVckIQTYDGytQ8Axb
 +cvF5HrwRsE8zxys+wwfIUhq6AUgZ3kzO7fvfF7copyRupfzoixj//CS5B++NcchN2ipOO9re
 m04pZNIJ+OQNats3nxTRNLJcNzdTOa+UbgI9B3Yfiupe3CxPc6gKSQW5nD2BWF0OXrmvTHydF
 ZEarNO5zKWZjiWIlcu1y1s32NolR4goFQsWdfEgc/c3bAVVKOesMfVAXy0CEIq7bpMHB8q9nE
 jUd7sJuGnOai+jcjiO9Zj4EUE6XmeY4s0IkCz9cJX3VUkX6Yws8extKYn8cTCk8R2ub65dFSn
 QkV+P7TQ+a941nJ0rO+9pi7473uNLDikxHih2hXhVOyO1HrybV+jZhaJDRSj2xPgOtlG/UMCS
 ZRepoT/nDQ4S6m1OC1AFsC0+GjS9vtTVWb0jfVyrEvgE/WVpwSbKpKX/VUvOBruvJ80VcX4Mm
 NjMBHlp3RyVIMBXGHMTBFVanOWXFEzMHzQAP8h5RlVkP0J9Pu2tmfQOdQwkP+NR92SOzw79Ei
 a7SuIsN9s6iEd6mFcUoJPDvdxTjC+DN87b+/BnIiruw/6G6jE+zQQs2lDtKtRTrtDrzV2Rxp3
 YQuc4tEODP5lBYN/+JJYB7qakz8DwHZpEprXfIZ9hc3YyuFPyNXvhv/eodDv+w3R79jKNMahA
 ncWlsI63kf//Nk9AmI1NG5dcE8SqxNxWKqltnfNYarHBgB7dFSJHO8LJ/+4HIaiXJG/W5mHoc
 3ZCk0Zfw5iW5XeCt0YdajNcr/vffjGWnYTZR4Hr6jnyGs6QVr1t5802HrqvPH2gcRnRPKrc07
 5aBSYHK
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Jeff,

On Mon, 25 Jul 2016, Jeff Hostetler wrote:

> +##################################################################
> +## Confirm VVP output prior to initial commit.
> +##################################################################

s/VVP/porcelain v2/...

Ciao,
Dscho
