Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C30281F453
	for <e@80x24.org>; Tue,  2 Oct 2018 21:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeJCEhB (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 00:37:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:51333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbeJCEhA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 00:37:00 -0400
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Le5bY-1fOCjP3JhU-00pvi4; Tue, 02
 Oct 2018 23:51:31 +0200
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Le5bY-1fOCjP3JhU-00pvi4; Tue, 02
 Oct 2018 23:51:31 +0200
Date:   Tue, 2 Oct 2018 23:51:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Michal Fita <michal.fita@schneider-electric.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git 2.19.01 on Windows crasesh during GC
In-Reply-To: <AM5PR0401MB2484A080D36571F2486B9609C4190@AM5PR0401MB2484.eurprd04.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.1810022350240.2034@tvgsbejvaqbjf.bet>
References: <AM5PR0401MB2484A080D36571F2486B9609C4190@AM5PR0401MB2484.eurprd04.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XpFX1LrkqH0bgqEq5q8+f+nkudD8YEdRE7n1shJFpe/gbQpjKx6
 9r/4BfQeZnvjhN4i4n4q479FH9uYw1CythcqKnFxWffCgGDoFzaF7lOowBLU1T+7iGQGoUo
 WrAMOCUVhVM9nNFPYvcE02/qDyq3CMGUevxxsiKq4qnVXObMs3+pbAlg2xqEqCwi4FqXeU0
 FqBhACsGpDnKC28h+y8sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RuHvSFoout0=:X/R6okIOJPp7kUW9L3NqL+
 lyf0e8oM0db4/JHrCw5BavIU5B6b7gxI7X6ocVphCFrGVEl5E4BL2iTGZr/rIPXUfWpM7Ugv7
 PmneM0Yu752I+anT3Qd+93asZJ+0OI/jQHihPy7pQWWjnGpjyZYwYcPqP0Cd2/qPTi4HivW5/
 0olLOwsZTwK7vEx4NjL5ZRw5B4st6cVpx02W7WroB0AZ8V2/a5bsr5R7lJuYMavQZWzGzfCi2
 Yo6U9hLzdKLoQLaolFW+AVHhruRhKI5gexb86+0dOw8pha3FdI9jPWL9e4Qo6eVFqz5YPC2SB
 1mcfOPkr6slhjkr23gKubSzsRRAgjJyzj70vnGeo8iYEs897QcyaEqJr6CVwoT9LxmOO3ghL1
 ifbZlf2eoeRmaZuY2YThxbnfBypoDr0qAVtOMu3SQGfuV2NOsDgMF7vgnDhev2/SqyZz2h3oD
 I0JdIuMi93DIcLX/wH8p97qoe8SR+I8rFgu2OK7Kc+mwbIAX3xKeLBSBsJToaRKKXTOLLhwUO
 /kgYANUENL6ZezXOqq3N+ZcJG3s0IRyGUis0ucsdZRbblgGNSADlgmUtdlXrVlroTjW1u8W1h
 h6obrR3TPMU6pjAvKOQTc+6pPd4D8pheNXYNlAUx6+lDaHOTXYyOMpGUIopMRhsIxEPakn89Z
 nR/BJIZSZsC7qK36nleIlClIVAKjl98ugY1okjP/EPxdgypMqzp7NLDHX08v5kP8jHu83u3pM
 L3xd1rdKvS8PktONA+rIVp6d1yCtdaurawDN33LjYFiOYGpAuRkOiRlw1bW3jyvG5m9D/ITFi
 nu87HzXH47ezrAtCCZWNpMrpIO/zvv4XBtJPzXXqduz88VQVTs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 14 Sep 2018, Michal Fita wrote:

> Problem signature:
>   Problem Event Name:	APPCRASH
>   Application Name:	git.exe
>   Application Version:	2.19.0.1
>   Application Timestamp:	5b980bc7
>   Fault Module Name:	ntdll.dll
>   Fault Module Version:	6.1.7601.24117
>   Fault Module Timestamp:	5add228d
>   Exception Code:	c0000005
>   Exception Offset:	0000000000032964
>   OS Version:	6.1.7601.2.1.0.256.48
>   Locale ID:	2057
>   Additional Information 1:	335e
>   Additional Information 2:	335ee83054d6c615e4a7142c362e3dd4
>   Additional Information 3:	5184
>   Additional Information 4:	518485c5adbc52c624cc6890056919a6

Sadly, this is hardly enough information to even start a wild goose chase
of a debugging spree.

Happily, I *think* that another report will help you, too:
https://github.com/git-for-windows/git/issues/1839

In short: please test with a new snapshot from
https://wingit.blob.core.windows.net/files/index.html

Ciao,
Johannes
