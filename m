Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1942C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD971206F7
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="EjW9QUAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404580AbgFXQHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:07:46 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:57314 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404280AbgFXQHq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 12:07:46 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 05OG7hsa008150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 24 Jun 2020 12:07:43 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 05OG7hsa008150
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1593014863; bh=Ji5RVyw2jKZSoGKV1Yh5h1GCJqDfruEx7w5qHHb7IBg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=EjW9QUAq9TO/XtiqEv9cLBtrzbbJa7bEMTE3/YCRgLyXePdKhRxjF7R0uWzSCUNMh
         snAhD0v8TpL0cHJdVu0gDTGbYReo4YjZHy5te3o4ITfWGo2yJlUB2EdHyUnI9NoAEF
         FirhqRyxBYZ6wzjBe/S1ZOZR1SDAhg8aPnx4clRJiGZhLSE43Va5sPKjaZQbDY1IW7
         +X48Uye90g/isIH43KR2RFdtVY/dEbxTLYr10MMS6WlQxlxyiXBxDIC3OP5QdzEzNs
         m56w1pquX0Xlg7nkQoTG0lqgsisjCPe9uQoACszGKRBP+feKhwtsuROtOISIdBzpF+
         7owj2XUnUrNXg==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Jesse Earles'" <jesse.earles@aero.org>
Cc:     <git@vger.kernel.org>
References: <BY5PR09MB4504218AEF2DFD593843A41EFF950@BY5PR09MB4504.namprd09.prod.outlook.com> <25d501d64a40$62991410$27cb3c30$@pdinc.us> <BY5PR09MB4504AD01DDA757120DCC79ABFF950@BY5PR09MB4504.namprd09.prod.outlook.com>
In-Reply-To: <BY5PR09MB4504AD01DDA757120DCC79ABFF950@BY5PR09MB4504.namprd09.prod.outlook.com>
Subject: RE: Are there MPU/SKU's for these products?
Date:   Wed, 24 Jun 2020 12:07:53 -0400
Organization: PD Inc
Message-ID: <262201d64a41$9e1cb720$da562560$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
thread-index: AQHSB2ADz8zCfa4zmKyiaoVbsYQIDgFzG6l7AmbZMXyo0aTFsA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That is our source code stock tag.

> -----Original Message-----
> From: Jesse Earles <jesse.earles@aero.org>
> Sent: Wednesday, June 24, 2020 12:06 PM
> To: Jason Pyeron <jpyeron@pdinc.us>
> Cc: git@vger.kernel.org
> Subject: RE: Are there MPU/SKU's for these products?
> 
> Thanks, but I was referring to if there was a Manufacturing Part Number or a Stock Keeping Unit number
> for this product. I believe we already have the unique ID entered in another field, so that part
> should be good.
> 
> 
> 
> 
> Jesse Earles
> Desktop Support Specialist
> EIS/IT Operations
> Digital Intelligence Systems, LLC (DISYS)
> The Aerospace Corporation
> 14745 Lee Rd. Chantilly, VA 20151
> 
> 
> 
> -----Original Message-----
> From: Jason Pyeron <jpyeron@pdinc.us>
> Sent: Wednesday, June 24, 2020 11:59 AM
> To: Jesse Earles <jesse.earles@aero.org>
> Cc: git@vger.kernel.org
> Subject: RE: Are there MPU/SKU's for these products?
> 
> The unique identifier for that version is: e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7
> 
> commit e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7 (tag: v2.12.0)
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Fri Feb 24 10:49:58 2017 -0800
> 
>     Git 2.12
> 
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> 
> > -----Original Message-----
> > From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf
> > Of Jesse Earles
> > Sent: Wednesday, June 24, 2020 11:43 AM
> > To: git@vger.kernel.org
> > Subject: Are there MPU/SKU's for these products?
> >
> > Hello,
> >
> > I am working with my software team on updating their internal catalog
> > with current and accurate info and am needing to find the MPN/SKU for
> > "Software Freedom Conservancy | Git | v2.12.0". I'm not certain if
> > there even is one as I assume this is open-sourced, but I figured I'd reach out to get confirmation
> before I make an internal SKU for our records. Thanks.
> >
> >
> > Jesse Earles
> > Desktop Support Specialist
> > EIS/IT Operations
> > Digital Intelligence Systems, LLC (DISYS) The Aerospace Corporation
> > 14745 Lee Rd. Chantilly, VA 20151
> >
> >
> >
> 
> 


