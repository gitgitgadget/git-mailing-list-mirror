Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D89E11FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 18:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeANSVD (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 13:21:03 -0500
Received: from elephants.elehost.com ([216.66.27.132]:23116 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeANSVC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 13:21:02 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0EIKx3c099408
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 14 Jan 2018 13:21:00 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Philip Oakley'" <philipoakley@iee.org>, <git@vger.kernel.org>
References: <20180114164529.10120-1-randall.s.becker@rogers.com> <E2F9FAE97F7D4B49A5A644FC796A9AAC@PhilipOakley>
In-Reply-To: <E2F9FAE97F7D4B49A5A644FC796A9AAC@PhilipOakley>
Subject: RE: [PATCH] Remoted unnecessary void* from hashmap.h that caused compile warnings
Date:   Sun, 14 Jan 2018 13:20:55 -0500
Message-ID: <002801d38d64$6e62efa0$4b28cee0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLT64Z5+adlU8BW/+joOIaH6CfVUgI5uQnjoWEjvWA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 14, 2018 12:25 PM, Philip Oakley wrote:
> To: randall.s.becker@rogers.com; git@vger.kernel.org
> Cc: Randall S. Becker <rsbecker@nexbridge.com>
> Subject: Re: [PATCH] Remoted unnecessary void* from hashmap.h that
> caused compile warnings
> 
> From: <randall.s.becker@rogers.com>
> Subject: [PATCH] Remoted unnecessary void* from hashmap.h that caused
> compile warnings
> 
> s/Remoted/Removed/ ?
> 
> Maybe shorten to " hashmap.h: remove unnecessary void* " (ex the
> superflous
> spaces)

I amended the commit fixing the typo and cleaning up the comment.

Thanks,
Randall

