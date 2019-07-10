Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A8C1F461
	for <e@80x24.org>; Wed, 10 Jul 2019 18:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfGJS7l (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 14:59:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:51629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfGJS7l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 14:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562785176;
        bh=bFiCPxYlCbgqWzpbUzkNenbCz4CetxbGTZlYtimK6hw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AF+ALRfjBftWjo/MGB6CIJF8DkpAvtDwDUNdaJjHM+1lvHhiHSXebtRyc2OjIt7AO
         Cp6o4bv4tohfH904/a1wPU35g9cGn/QlpbMew+fNVCLQTUzyXE66v0LFezRIqET8is
         x0Z+iF7QtUbHNuLHbIi/T/jG+jfuagg/yBHTT/+c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MO7im-1hoZ480mM0-005be0; Wed, 10
 Jul 2019 20:59:36 +0200
Date:   Wed, 10 Jul 2019 20:59:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jl/status-reduce-vertical-blank, was Re: What's cooking in git.git
 (Jul 2019, #02; Tue, 9)
In-Reply-To: <xmqq36jeva9e.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907102058360.46@tvgsbejvaqbjf.bet>
References: <xmqq36jeva9e.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lVKB6JpAsm/1G36HbrvwVgWo+QxVtIO36JuJI0muj5nT1txrwDK
 23qwfhbrgEOA2Sd18v21FdVj6IFSMATF0jE7DoS3GGfb2fYDSNbcZAOXdDa/xtbjBLa5dLp
 CY6QeQGtiRFuOKksYs5+I3FEf7N37gzNlcwvzIVnPcevK3pY1ASFufvThNCiSEjXnMFoNt4
 jcWrU6VsYQSZqGbJJqZlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P+YsKXB/r68=:jzxxUVA211D3wjTaBXuaBv
 GVUWzCTB6DtZikbU78BHJ6kWsdV7x9RhQ3noAy6mjYl9FE885ylk4EDkIaecdBEUDlNwSS0au
 zVTqatfBfxt62Qrmuoff3UJRrlxTenO2221h1qn48r/KKfqalsdNnGG8LBnY8NTt/owkwhd9H
 Zunq7j5BI1dW3qMMif27xliffcxAVlBTAWZuoaWEX43emiDCNUwpdc9szuV4BpQ6LNnygpvwb
 N0SlESGFl7+1ZOEz04rcB77tZJmgz3rSYQCO73IZHYVAU6T+B0gK8mHMF/VZsGKPTyLVB3+5W
 LpIT9224A8ajqt9e/7WpwQxtVWirlxPCWbTnHAqSMd6f5J97NftbtIlJepZI3C2DrfPhWIWUY
 fK80Zns45lTIXcJjn4CN9Ccto+OMPBh0iAvgw6JbHmwZOeZVav0DOkpE5ThZeAo7f0OdCirc5
 awIsAe3QEJTCDWvZyKbHhruU3LqHWlrgYSHYyH1gkdRxmeOw2wx9YjT4YPClXYI+IdJGNvY8E
 a9wFCsjeQiVrnU/tUzDVTf9+i+wH4rGPRUd0HFulADIX7Z32+9OMdQwkgn3bgueG5IIfOwXgD
 s/ca96l3fdLoHbkG+YvcmiLXQXF6GZ/7RSQnSbFSsanzB82LOU9zSLNIGa+I2KMvCeWWmLose
 uWdU1TehzhJOFjWrOP+5a5Hwmaoxy+povLfCgyVbhj2uKeTgMhpFtFFAu9a9eas+TJb4b2uJD
 C3GlDn3h9Z6pjhh/CCaY1hzvvDxTr53wyBwvHbzX99OaQoiW+3q2id+Sa1v1vBIT5syvDUdiL
 MhapWD7ryvzOV5EXVMz30XIhPVrzqQbBbCOO4fakNcYbJQUOZBTv/idBOMTVz6QeyZ7WbdwYl
 noZyNzsavUapgCtM9Ty8V8bkJqapG+9sbHAxjqs99hzGgEmYVGCob9ghP4uUP40yPz7/zJiJG
 3jhgMQg8op+PCQloipgwivXnRRXNyqwRZAu00IwpKCss8bZC4EtD6q0FcsAGQS7DbIdzHCYT6
 462leepMAztiyDWzuz7E2P3nrqf33wT4VqnZm2LkKiW42Jmhdt2jjcDW2tjdaDkVrhKk6uRrD
 /G/Ss+zqL7t7by82Z1i/QSG5BdYVgNb8jsi
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 9 Jul 2019, Junio C Hamano wrote:

> * jl/status-reduce-vertical-blank (2019-06-21) 1 commit
>  - status: remove the empty line after hints
>
>  Extra blank lines in "git status" output have been reduced.
>
>  Needs to wait on nd/switch-and-restore to stabilize.

Didn't that latter branch hit `master` already, i.e. it did stabilize?

Ciao,
Dscho
