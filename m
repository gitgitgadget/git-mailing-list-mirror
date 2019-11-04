Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EFDE1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 14:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfKDOWv (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 09:22:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:58777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbfKDOWv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 09:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572877362;
        bh=NhOfX5fBOMHq17n5upEk1tpSU3iUpxyns8NxrWojzOc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=B3X7sKcy3uiHlEPVntCITNInbE73M808A6Nj+FfHhFJEEQLy39XIAFIsNYuyIdK+r
         o8FmJZyQlxg5903E/A+evJU9od6O4Y4NYUH+YxOox1G74s5NLfB3pgkAu/Q9KHi462
         nNpBXtfdWQKuXYAxIET0SF849giEVb3l84X46okM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.3.68] ([89.14.244.142]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bfw-1hs2vM26ve-0182DV; Mon, 04
 Nov 2019 15:22:42 +0100
Subject: Re: Windows Git Status doesn't see files on WebDav, everything else
 do
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <6c355683-726d-c497-d5df-bb7f8ea770d2@gmx.de>
 <20191027175850.b6le5r3jf3cxtnah@camp.crustytoothpaste.net>
 <fb194341-f7b6-d036-95f1-441c0cb59ed0@gmx.de>
 <nycvar.QRO.7.76.6.1911041326480.46@tvgsbejvaqbjf.bet>
From:   Ingo Wolf <ingo.wolf@gmx.de>
Message-ID: <2883e199-bb7d-e323-d3eb-ed8da85cc54a@gmx.de>
Date:   Mon, 4 Nov 2019 15:22:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1911041326480.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: de-DE
X-Provags-ID: V03:K1:aYauimGa9lNFXUzOJRsRKf8lRIMIG3yDsLCHIaf0VhH/HMpAxnP
 7Ivf4nte3i4GWAIBFCW8c0DjNxK9PYC5niUZR/sBnB2MjfsH1MseXrIjMlDkBZsYZpoUdff
 2Q/4Gg0lYKdhIjsaBXzJof8boCZrkJQ8tnzLlIx9J7e4WboFD+9Ke57HObeGVV0da8ecRoo
 LIH94Mx3qd/B7zIUUSirA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J78hyuq8lLU=:Mqyd8ORR1cZNi4ve7X9kLj
 RC6VWYqEOQd473LY/Ly7+Y20WrvdBxkV5+5Sf2UdquUeuIgPBkKA6lZBqAtLqQjQmCQpyr7Cr
 3TAhVUZoIAqAz2C+eNSKn5jEnr1m1cPOuWvdy+sASD1ge3Y3HqPBfXCbJXVDSF1L3LMk+GbEz
 XhCPChODFCQK1YzpjlysCG0Wintwgi+b8Kj0YilND3aMMe/hPNOsSVCQOPUIa/trxxjWfuGAG
 gvMdgXbxvEZfP/FbyBQYD8+1KvGdDATEN3Yt5A1q6k4KCDjpwfqcfCOglfpm2+5he2gpSrTmK
 B90SN7xI9M0PWLt+cJ5teFPCs1349XbDcoyc0jIH8IUy0e+cTkKqoAaUsIs8ZFQhWTlt1ILcW
 s5kVc5ZC/QutECCXGoD6lWrz7x/0fqQx9ifWphe2yF7Q5M26sy/6p3hqKqWOV3cxYku7Yfkbt
 418Re6KjWO2MlnO9SPqS4DW0OB3TFO0dGlJXTDrIIRsCKDGnXUzyV1CnCBEB5mA9x+IndFhGj
 V1WD31xs/GruV6QZXSd2agoXflugo3KN6X+1C8GMihmRnMBJZ54WCgcRJNVaovCdzQIh2RnTj
 zei2QoP7lJg+4FhgqhqTVdLciop4hET2x/Alm1r/1sy82y9uwpD2qqZFyhi4HRdUo/hXQ5Pbm
 GRz0Cd4p268etIG7gxBSfwT6jwNNBShMVzzF1LE/OId4JXEb76tTWEB7i6k/fFEADLa9yjR07
 PE41kduGpDgzdy+dWdUpDdP6w7Q0lMVnnCOLWx1b7GhecCt5OX6BnatAN2r1/iem94rsI1842
 D1d41psjEr1J7sBFjbu6YmpWZE2rOMhWyE5CLMtdT5TX7ylxyysnsNcLqnI19GSI4MnTc2Hw/
 runO+lxQOXp9itWbaKuMBs0i5BQjyXo1nuYLnPm8uATOU6N4ldKkXaxpqAEpmaOwHa1JHnNAO
 tNg/oUp25pOkMaMlD2R6kYRFH0Kj4ExCYYThXoFSGcwqO5CJo9/H6XfpCFQfEVdKfivECuXA+
 TEAlscxmzsQLrP6RCH4fyXGN0tCWtxGP4bH/9cfBsWkcGJWW6AvhzpjYIIDS62LKKk7BhA6Kk
 Iw4rNsB1DLMW5E/shKLRQhRqFUmLnsCbhGxf5ZAkmyMvTSao3lnr7SQzwP/kgYJW0vuAqZfEY
 ElJdT6bXh+cseuVhBDlkKGR24Yad9ARWS90wl7hDnN4piMd7k8LKGDIJnDdSu/XL9V4/xBsz5
 /cAPYRh0oULSuuVLzos9ejh9eHfeIeGT6ZqlvFSlrkYjwl2ktCBUX7MBOUPg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Am 04.11.2019 um 13:29 schrieb Johannes Schindelin:
>> Settings recommended by brian haven't helped yet.
> That is an _awfully_ succinct answer. Terse, even.
Was that an awfull answer?

I have to tell I'm German and may be have no feel for some language detail=
s.

Or may be as a man just in general.

Do you read that answer different then I've tried brian's settings,
still not working,

does somebody know other settings I still can try?


