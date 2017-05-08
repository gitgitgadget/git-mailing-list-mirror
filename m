Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D4731FDEA
	for <e@80x24.org>; Mon,  8 May 2017 06:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbdEHGax (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 02:30:53 -0400
Received: from mail.aegee.org ([144.76.142.78]:34525 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbdEHGaw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 02:30:52 -0400
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.aegee.org v486W87X025873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
        t=1494225129; i=dkim+MSA-tls@aegee.org; r=y;
        bh=fn283g9ec1hUYPpnKRRSJlJsjA8pCZxh8tcoBemv0bA=;
        h=To:From:Subject:Date;
        b=YUQYvoKesTqIKY6quGtKD3xbmKE4bxv4dl5HfO2mli5dm9D1h7ZdZAWoWFgCV0M+l
         6vHIXg5whS0Nx+Io3YV9Qp02qFeQxi79Gd5EC8Pp4fujH1NAg4wckk8e3kr2O5IVdV
         EUyFUaDbgyZ82MfDeXPs/qP/9uIU8amwnGlQRb3qu2kQyMRfl1AyCy9t18Orvaaho5
         AHtGAijycFbFhYhi753jLigH6LSRe4PQD1Pk+HtmdAaWvCvTqLwS1RHcMaE6qcqjzO
         x96O32jQMzRnbd7cPZJhgNkvGnBDCVvcyNsz06lCFWtlghH46nRn91r8Pqh+wTpfRY
         7Jr0hjgtNbTkW+Lt9o660cAblQrQM4f5lWMH0MP9DMy75XFP9xdA1iZeBfYDPmTl0R
         mNQYsrLZAM5SwKdZje+5ACYIn5wsuHYPvc0SQSth7G2/upC6+A8J7K33wkpBPehbfY
         IqyYKayW5aK0DQnyfTsGBNluS3nEQ2aRfHUdmx2EP8LeIK91En24l/tyGpPuHnSipX
         MahjeBEPhuEbDZJld10ZRKm9UDv23mjDaMetwj2/5aSB3vwb+6+6GX/LAGbO1HW753
         eucPl470Ez2eddrVfK05s7OaJbtv/aYpuA5asfAOXpX8jWzwqVq4STyz6A2Z3jeYu8
         DniD2JCGRz4ACR7Ox6XiQEY4=
Authentication-Results: mail.aegee.org; dkim=none
Received: from [192.168.178.39] (x5f74ea0b.dyn.telefonica.de [95.116.234.11])
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id v486W87X025873
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Mon, 8 May 2017 06:32:09 GMT
To:     git@vger.kernel.org
From:   =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Subject: git clone -b
Message-ID: <219f3882-ec66-5c36-a157-5b920a2e4d04@aegee.org>
Date:   Mon, 8 May 2017 08:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

why do these work:

git clone --bare -b 3.5 https://github.com/python/cpython A
git clone -b 3.6 A B
git clone -b 3.5 https://github.com/python/cpython C

but these not:

git clone -b 3.6 C D
git clone --no-local -b 3.6 C D

with git version 2.12.2.89.g49800c940?

Regards
   Дилян
