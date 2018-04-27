Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CB431F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759146AbeD0VD3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:03:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:59219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757592AbeD0VD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:03:28 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSp1l-1emhjD0F8v-00Rofq; Fri, 27
 Apr 2018 23:03:22 +0200
Date:   Fri, 27 Apr 2018 23:03:02 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v5 00/11] Deprecate .git/info/grafts
In-Reply-To: <xmqqin8e38wf.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804272258380.72@tvgsbejvaqbjf.bet>
References: <cover.1524303776.git.johannes.schindelin@gmx.de> <cover.1524650028.git.johannes.schindelin@gmx.de> <xmqqin8e38wf.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sM+RbXhNSkeh8NPNhHLIwR5LB9nYq+/MCLvk8j+0+T4dGTT2/A/
 JJL/ejGpzUhCCouN4G1Lv2urpgARW6RdAYSW56Sq7WEDuLP1zNaOQaX7y8faq25THijYWlf
 Kaa1T/zQ0A+vpX5wdvR2ywE/cjMRWnDbYsHYyMdgLPNDE6gdg7vJBKkDHN3YCPnxvkQhVAd
 C7dBbJE/3CAHvIRv4PR0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IcCAjMCFf8s=:8F+5RTZ0mPA4OnWQGOxfhe
 P5/hzNwSYkYx+5o9qsIi/QRPpgqZ24UrdBoCJbrtcTSn6cq7C42jUwsmsEqnvf0IsIV7UXKVb
 8Ms8MiMX5q5ojioibstW6JDI9I3E45cr7LwqiTL92vWTrkDKmlShZZML+VaYYWaVZYitzQaii
 a9mtzmf0vce/1rz7gTjHDifYEglbFVW+OD/nPuynuxAm+y9VDqJ2tW3cnHKgNgxFjUbPnEQ4l
 cSqzzTc8SJkOSCBW+qH7iJTDUD5JSGSo8FWx/3AW2W4U8bfuJyXCS4p4FN+3AYvrpDfxJI6RI
 fvnWKUoLo84F36X7964yf81/x9PncT5Fc/1FQCSuk0TWfkNVkMrBGtHpgDb8e4ZrvwqWg4p8d
 AZ0Z6Hl2L4ux6p2FrEwr2g00HtC8T5fXH9Z/FfHkK5Hs1aKK/gFNE+3v/yxAu02qEAAIFNg0n
 PHJiAcpvKzuiu67keBYTNFRSO9/HtKdK32Sozeg9JwL5bb5Dbs0/y1drrbacl59779P+ALmuR
 ElFRcuo3oNl79br9VYGOeCVggwu4NSIi/35jqegvdjDVxOQDn4voKGznN5tnXQoEAuhMFL2Yl
 qXyzJIkkG+8eRSfA6ynVWHRDb92JQ0cJ5JNZgwAkqUArLZe+WusxVdUN2nEYjRmbpQaSWnWsN
 +lMEaX4icyMTZNra3QS0Nj/IDjiWOzXdtAmbP7JMKFv7aKQV8TbjAtZ0HzObhLBzGhIhRs4q/
 NGR+VxPd4OGdXGR79Jzq+qnIeg9doohFUBSooCALJyuKupUX7P+D5SJU9RhGDa8IOIvnmWME4
 aBkRTX/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 26 Apr 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> >  -	if (export_object(&old_oid, type, raw, tmpfile))
> >  -		return -1;
> >  -	if (launch_editor(tmpfile, NULL, NULL) < 0)
> >  -		return error("editing object file failed");
> >  -	if (import_object(&new_oid, type, raw, tmpfile))
> >  +	tmpfile = git_pathdup("REPLACE_EDITOBJ");
> >  +	if (export_object(&old_oid, type, raw, tmpfile) ||
> >  +	    (launch_editor(tmpfile, NULL, NULL) < 0 &&
> >  +	     error("editing object file failed")) ||
> >  +	    import_object(&new_oid, type, raw, tmpfile)) {
> >  +		free(tmpfile);
> >   		return -1;
> >  -
> >  +	}
> 
> I know the above is to avoid leaking tmpfile, but a single if ()
> condition that makes multiple calls to functions primarily for their
> side effects is too ugly to live.

I changed it back to individual conditional blocks, with every single one
of them having their own free(tmpfile). That is at least clearer.

Ciao,
Dscho
