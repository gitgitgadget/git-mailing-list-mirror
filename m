Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0E9C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 02:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbiAKCUW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 10 Jan 2022 21:20:22 -0500
Received: from elephants.elehost.com ([216.66.27.132]:17015 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiAKCUV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 21:20:21 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 20B2KK35001965
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 21:20:20 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [BUG] Re: Git 2.35.0-rc0
Date:   Mon, 10 Jan 2022 21:20:15 -0500
Organization: Nexbridge Inc.
Message-ID: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_00F0_01D80667.9A0979A0";
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGsANR0OT4W4IUHkHguGppHXx6wmg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

Git 2.35.0-rc0 is not portable:

uncompress2(uncompressed + block_header_skip, &dst_len,
                   ^
"/home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/reftable/bloc
k.c", line 213: error(114):
          identifier "uncompress2" is undefined

This is not a POSIX compliant call.

--Randall

