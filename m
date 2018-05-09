Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22561F42D
	for <e@80x24.org>; Wed,  9 May 2018 11:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933849AbeEILEv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 9 May 2018 07:04:51 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933685AbeEILEu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 07:04:50 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MLnrn-1fG5uw2YAV-000uMP; Wed, 09 May 2018 13:04:45 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id CBBD164A45D;
        Wed,  9 May 2018 11:04:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ym0FhF5-wqMq; Wed,  9 May 2018 13:04:27 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 29BEC644671;
        Wed,  9 May 2018 13:04:27 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Wed, 9 May 2018 13:04:26 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id CCBFF804D2; Wed,  9 May 2018 13:04:26 +0200 (CEST)
Date:   Wed, 9 May 2018 13:04:26 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Paul Mackerras <paulus@ozlabs.org>
CC:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/2] gitk: improve handling of submodules in the file
 list panel
Message-ID: <20180509110426.j34467s32pjm6ipb@pflmari>
References: <20180509110031.wg32inxpbb4w52nc@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20180509110031.wg32inxpbb4w52nc@pflmari>
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180509-0, 09.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:SzHAYQWd/wRKeE8QKsxpLP9wtuzvP6VsfKa/cYK+Z6cI5lEQtBv
 OaUYWbB2JsUvBvGDDTZSoRgsniPHbp2ccCtTDJqSiVrcZZMaPHXvc6aBoTdkyL8OHg3KlgH
 jpMqyaDRhfTzavQ3QJ5FS8wu4J/H/jkUW8LTtjwYk978BTMO4FDMNySI3QsjpVu9RDhTk10
 nuSEIIBlNSICcqArBQMDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o6HX/9EKkp0=:Umkro1kzN7edcE9RevooDX
 +UbMzQWQKlo9v6EyewUbRNt0cVQiliHn8nLEYk6SI78JKdSinyzKUY7xAUBg7lgH0aTNl2eM8
 yi4w+yA/k+FZ8/AQwx2U7Cf8unIe4YVk/SQIMx8TEyqn+OmIO8ogCXyLbFo6oDnXF2c4RKf9m
 TwSWtpzGefDQnhfefTRfDsCtdG1+QXkj+bqiriXnLQk2sQ8nByp895aeo5zByiGe8Azzuc9NW
 SEPkNhw7C68KPs/klgNiTUAbCfP3AdIec6F/F/d8PO8ZXZJCzSIw3v0OV6d1a8iJZnLqbDE8n
 HAu6VKWDOVpG3rbpnN5uNMNV0ECwtXyEOTSWrHIjdGB1ECvPaRtrSKO0wwoibGmoLLpKrAN89
 ZVFcCq+UyQj1zIP+5ju7ZxlnZEYFkQ2sJYNDBs/xdH1rzIIhC1HM5Zv31dzWAfnyn92EbIVL+
 fOxkCtUahizZ+ccXA0sRWsHrTPd6BxsJpZsEyI/vobwbhyBvU8gq8HRY90K01T/EzI4oGzCkW
 KP0l6y6H+4URFTS3NlhzfvR86oQ25E+iHt0EZVOC3WZR6o7i4R3aG3CZEkHqKO8qyVXotgLRm
 Z1CaBULgYyUD0sUKtdjuhWt5LxxTjkOUqUl54wZsAKXHQKuj6lXkaUORnVGsyomNAWbW12cB1
 BvPdkbHnp/IJChcuUeWyr6MG7sys6am3Pi7sYTBpX+YnNXrsfBSC3H81wdQllLhUg6Xo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for broken threading... I'll have to work on that.

---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

