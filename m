Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8824EC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDAA205C9
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgD2TcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:32:06 -0400
Received: from elephants.elehost.com ([216.66.27.132]:50521 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2TcG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 15:32:06 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 03TJVlab070531
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 29 Apr 2020 15:31:48 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Sergey Organov'" <sorganov@gmail.com>
Cc:     "'Ivan Tham'" <pickfire@riseup.net>, <git@vger.kernel.org>,
        "'brian m . carlson'" <sandals@crustytoothpaste.net>
References: <20200429130133.520981-1-pickfire@riseup.net>        <877dxyo1k8.fsf@osv.gnss.ru> <xmqqk11yw0r9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk11yw0r9.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH] branch: add '-' to delete previous branch
Date:   Wed, 29 Apr 2020 15:31:41 -0400
Message-ID: <03f601d61e5c$d32d6380$79882a80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQID+ys99Aw5+dnxkKeldQJbrqFEJALos1EMAlDyxEGoCvWVkA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 29, 2020 3:28 PM, Junio wrote:
> Sergey Organov <sorganov@gmail.com> writes:
> > Ivan Tham <pickfire@riseup.net> writes:
> >
> >> Add support to delete previous branch from git checkout/switch to
> >> have feature parity with git switch -.
> > ...
> > Is this short-cut /that/ important to create yet another confusion?
> 
> I do not think it is that important, but I do not think "cd -" is so
important,
> either.

I wouldn't mind a switch - to the previously switched-out branch rather than
supporting this for delete. Alternatively, what about a switch --push and a
switch --pop like something out of bash pushd/popd.

Regards,
Randall



