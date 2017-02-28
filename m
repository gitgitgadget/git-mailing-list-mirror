Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753302022D
	for <e@80x24.org>; Tue, 28 Feb 2017 11:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbdB1LGz (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 06:06:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:58843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751728AbdB1LGs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 06:06:48 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlV4F-1c8mEQ49EV-00bOLL; Tue, 28
 Feb 2017 11:49:30 +0100
Date:   Tue, 28 Feb 2017 11:49:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] Specify explicitly where we parse timestamps
In-Reply-To: <xmqqh93fmemg.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702281149120.3767@virtualbox>
References: <cover.1488231002.git.johannes.schindelin@gmx.de> <12b60c14dad15e3252e314771b3fe369305bbfc5.1488231002.git.johannes.schindelin@gmx.de> <xmqqwpcbmfai.fsf@gitster.mtv.corp.google.com> <xmqqh93fmemg.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:j+6gYOhFEg6QcjWEwppejUyS6vMYty17MpYdYpkvtdXkBr7HscN
 vXHRiLj0DdctjWO6vjbMQkjS7CNQFnZvzzN+utlyIqZEKa/uvnXwtX/12RxralHT5fNyIgc
 wrT3SvVAVp3eJVpK9J2UTL3Q8AjFAmzDYD4273Hw/zmUyNL+/bMmrBvO3giyYj0lpvrZBQH
 6FC1zgpDbBRnUPN2OgKrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:It9JTzyhrcI=:i+WqpVIe47E+sv39RqTDTk
 qUKHhvmuxlBEdcU5lCyvj1tY9bPJ7vptcyCpcGEL1CO9Qgl2/p/32GblxxPrZL4rMNJGyY/sX
 D6rYLkBM1z4wOXz1jFDoLu4Pijihpbj4baW9WbUABFa36sxQ+L1xnmFKJ/i6ScjaZFQoj5dT9
 WZibdUb8VwbZXWNCRq5KH2r1etGJfszqzK7ioZQIrutKjuD+gbl34UgKF+s+JmVIFFW0bJ44i
 Gw13vuinzp1Jqqg7po9Eqoe32jgd5Zlw29zxGrAA74VXEWmaGqhPN2xPl3pgpx6NDPnBbD2R9
 mBC9LupgLZMYFkaefz2sllw4ZeHfp+MSZxaLJx7gsJ/RqpRX+qbGslZhX/jM6MwZvebLwJfG5
 IGHAIiFKl8+ZTlSLaul28KOJOE1CCwiSR4I5Oc4S33w68VVUHsouLm5o21i8R/7YHTxlMIJRA
 Min1KCRjLQSUN9GiPzxqDfwmhT54oy4m//2w2j8O+R3Q8ZdoxFOYXd5tfyU/6MCtpuTSAexvo
 ScIkpYciDhLaROYQJ6+pqlCfkvephWVcofoc8WmOctsVUgGwTrJu+s1oK796dYjhxxOyGuxzf
 ChBTfbpwD/M0oUPnLZOSFwCPothVCZGqocKK12yyYG6PCbPp6pIeYXNAjb8Clw6zu+vFnUWLM
 h4G0KAye5VAS2WqIly0eNtvbxmqysWS3Mm51eeIzbFNoke7e/zbkbGtEL/9590AHleifGHD8y
 W5AUtUplwTTqq4JSvOibIfz2tRulPk/uXjAaFtuqxTIFQw0/g9JtGClKTBcYwpiCgX3o1zfVp
 S2VGcBVjO+kcXxP/V6eOUhYjjuuwt0iANLpMqmWse6XCWFeRujpi2LgOpUWn04t2q5JhrDQMp
 TZdt7Lw0L2znZ7thVcsCqAP4uZar7RnDFQqJYTNr3LbLN29ASVunJu0qEpyXkq3076hmheLIV
 VgYVrTy+exSiiQIy8pkl1ylsZpKx+hHyzRtZGPmMEJIemeEUS8iseuioLnznU4dXFtyVhgd/T
 E7M1Oo9lewZs6M+gGPEu9H1smCqhtW9K9hqJ+9KB+UTM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 27 Feb 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> -	unsigned long number = strtoul(date, &end, 10);
> >> +	time_t number = parse_timestamp(date, &end, 10);
> >
> > This hunk does not belong to this step.  Everybody else in this step
> 
> obviously I meant "the left half of this hunk" ;-)

Obviously ;-)

Ciao,
Johannes
