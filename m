Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30711F461
	for <e@80x24.org>; Tue, 20 Aug 2019 17:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfHTR2B (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 13:28:01 -0400
Received: from rdnemail.bankofamerica.com ([171.161.147.155]:36225 "EHLO
        bankofamerica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730330AbfHTR2B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 13:28:01 -0400
Received: from txdmzmailmx05.bankofamerica.com ([171.180.168.230])
        by lrdna0myxepmx02.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7KHRwEX004968;
        Tue, 20 Aug 2019 17:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bofa.com;
        s=corp1903; t=1566322078;
        bh=qDcFIZoaIrfDwHVuW1e13GetaW3fjq4C0cOKt43XMU0=;
        h=Date:From:Subject:In-reply-to:To:Message-id:MIME-version:
         Content-type:Content-transfer-encoding:References;
        b=iXLvUGxvbDLQ/HxGNewgT5yn8Uy0CnOfZViBfKwjDPGFvlvqxjhCEbIfTgFRT/7e0
         qz2r+1LvUiZfjOCcnVNVulPUso94jYnxUpHHKhqPkqgePYX+0WEcLxStN9Jt04BLl5
         JjXv4ffndfKOxmxNZQGpuXaUXdNrCMt6NStuuNRQ=
Received: from lrdna0n4xepmx12.bankofamerica.com (lrdna0n4xepmx12.bankofamerica.com [171.206.154.16])
        by txdmzmailmx05.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7KHRvr8009497;
        Tue, 20 Aug 2019 17:27:58 GMT
Date:   Tue, 20 Aug 2019 17:27:56 +0000
From:   "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Subject: RE:
In-reply-to: <CAOoiaAP_dOjrqSA--DcWxE+6nb4FY1GCn3+QKZnC67LHo+xn8w@mail.gmail.com>
X-Originating-IP: [30.245.13.45]
To:     "'William Baker'" <williambaker54545@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-id: <103df39d418946ddaa366b73176e9c72@bofa.com>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Content-language: en-US
Content-transfer-encoding: 7BIT
X-MS-Has-Attach: 
Accept-Language: en-US
Thread-index: AQHVV3wBWMJyUn5LuUSJHYt6QbZvpqcESX0w
X-MS-TNEF-Correlator: 
x-tm-as-product-ver: SMEX-14.0.0.1158-8.5.1020-24860.000
x-tm-as-result: No-10-0.078100-8.000000
x-tmase-matchedrid: cgbqQT5W8hfuo96mfIBuopzEHTUOuMX33dCmvEa6IiEIhX6eoWEDQN2g
        iq5xRdMLP1EDunecK1f7uuADRDIwrEfy6yl+57XwPnKakSId+fAx/k92L7R8tsHx9l2YYLoQERq
        adVpIfz0Y80LYc3JB8eTRiBqsg0qJuvnFMeyIlFnHsv3gEadaxBtPDNiPbNC6myiLZetSf8kir3
        kOMJmHTBQabjOuIvShC24oEZ6SpSmb4wHqRpnaDl4eVOjwUr9l2uq3lVdu1Vw1bZAPX5VrqbxZz
        H19R+xO5hP6Ky5bhdVo7yUGR7IYts/Bb51cg1jR4V8uPbu9/DICxtOPzlBwFDWe/rF557XfKdR/
        U4tRr/DYSvnsojaQCBClUEUt1OUI4+XAJZXbs2s=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10-0.078100-8.000000
x-tmase-version: SMEX-14.0.0.1158-8.5.1020-24860.000
x-tm-snts-smtp: E7A9D1E2AD03ABC9283F667842047019ED7547C4C6A573774D9B5CE0C975C93C2000:8
References: <CAOoiaAP_dOjrqSA--DcWxE+6nb4FY1GCn3+QKZnC67LHo+xn8w@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_07:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No, not like that.  See here:
https://git.wiki.kernel.org/index.php/GitCommunity
The email address you send the "subscribe" message to is NOT the mailing list itself.
What you just did is send the words "subscribe git" to everyone already on the mailing list :)

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of William Baker
Sent: Tuesday, August 20, 2019 1:23 PM
To: git@vger.kernel.org
Subject: 

subscribe git

----------------------------------------------------------------------
This message, and any attachments, is for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at http://www.bankofamerica.com/emaildisclaimer.   If you are not the intended recipient, please delete this message.
