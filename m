Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DEA41F406
	for <e@80x24.org>; Tue, 19 Dec 2017 16:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbdLSQQW convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 19 Dec 2017 11:16:22 -0500
Received: from mail10.clearstream.com ([194.36.229.253]:8451 "EHLO
        mail10.clearstream.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdLSQQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 11:16:21 -0500
X-IronPort-AV: E=McAfee;i="5700,7163,8750"; a="3136116"
X-IronPort-AV: E=Sophos;i="5.45,427,1508796000"; 
   d="scan'208";a="3136116"
Received: from unknown (HELO FRPGBS03.oa.pnrad.net) ([172.20.221.250])
  by cinkc039.nw.lan with ESMTP; 19 Dec 2017 17:16:19 +0100
Received: from mail pickup service by FRPGBS03.oa.pnrad.net with Microsoft SMTPSVC;
         Tue, 19 Dec 2017 17:16:19 +0100
Received: from frpdlpm01.nw.lan ([172.20.221.130]) by FRPGBS03.oa.pnrad.net with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 19 Dec 2017 17:16:19 +0100
Received: from mailp3.deutsche-boerse.de (unknown [172.20.221.130])
        by Forcepoint Email with ESMTPS id 97D3FEC07B9932492BE6;
        Tue, 19 Dec 2017 17:16:19 +0100 (CET)
Received: from FRPEXCH04.oa.pnrad.net ()
          by mailhub.deutsche-boerse.de (V2)
          id vBJGGJDH021600; Tue, 19 Dec 2017 17:16:19 +0100
Received: from FRPEXCH03.oa.pnrad.net (10.250.16.251) by
 FRPEXCH04.oa.pnrad.net (10.250.16.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1261.35; Tue, 19 Dec 2017 17:16:19 +0100
Received: from FRPEXCH03.oa.pnrad.net ([fe80::dd2b:f5ff:fe75:fbcc]) by
 FRPEXCH03.oa.pnrad.net ([fe80::dd2b:f5ff:fe75:fbcc%22]) with mapi id
 15.01.1261.035; Tue, 19 Dec 2017 17:16:19 +0100
From:   Jakub Zaverka <jakub.zaverka@deutsche-boerse.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: difftool uses hardcoded perl shebang
Thread-Topic: difftool uses hardcoded perl shebang
Thread-Index: AdN4ynjtgQyTw2MFQ5+aXKvEwXrtnAAApmkQAAXJE+MAABGxUA==
Date:   Tue, 19 Dec 2017 16:16:19 +0000
Message-ID: <4d6ef097827c434e8c2474fec1e1b9c7@deutsche-boerse.com>
References: <f5d4c8e7bceb410a95a34a8cce4c31dd@deutsche-boerse.com>
 <xmqqpo7awvbe.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqpo7awvbe.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bjprotectivemarking: <?xml version="1.0" encoding="us-ascii"?><sisl
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema" sislVersion="0"
 policy="5e216652-7cb1-42d3-a22f-fb5c7f348db5" origin="defaultValue"
 xmlns="http://www.boldonjames.com/2008/01/sie/internal/label"><element
 uid="id_classification_nonbusiness" value="" /></sisl>
dbg_attribute_name: 
dbg_classification_id: 1
dbg_classification_name: Public
x-originating-ip: [10.250.0.103]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginalArrivalTime: 19 Dec 2017 16:16:19.0366 (UTC) FILETIME=[B41EA460:01D378E4]
X-GBS-PROC: NH7GXT9RhmXy/d1QnTSi3WRPVXIg/1BHplLkRx9xCSE=
X-GRP-TAN: FRPGBS03@8B01F5413825477993F2D08C3B5E1A06
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please disregard that line, it just a mailing client attachment. It is completely irrelevant to the matter. 

-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: 19 December 2017 17:13
To: Jakub Zaverka <jakub.zaverka@deutsche-boerse.com>
Cc: git@vger.kernel.org
Subject: Re: difftool uses hardcoded perl shebang

Jakub Zaverka <jakub.zaverka@deutsche-boerse.com> writes:

> The below email is classified: Internal

Internal to what?
-----------------------------------------
Diese E-Mail enthaelt vertrauliche oder rechtlich geschuetzte Informationen.
Wenn Sie nicht der beabsichtigte Empfaenger sind, informieren Sie bitte
sofort den Absender und loeschen Sie diese E-Mail. Das unbefugte Kopieren
dieser E-Mail oder die unbefugte Weitergabe der enthaltenen Informationen
ist nicht gestattet.

The information contained in this message is confidential or protected by
law. If you are not the intended recipient, please contact the sender and
delete this message. Any unauthorised copying of this message or
unauthorised distribution of the information contained herein is prohibited.

Legally required information for business correspondence/
Gesetzliche Pflichtangaben fuer Geschaeftskorrespondenz:
http://deutsche-boerse.com/letterhead

