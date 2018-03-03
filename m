Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200951F404
	for <e@80x24.org>; Sat,  3 Mar 2018 14:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeCCOWL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 3 Mar 2018 09:22:11 -0500
Received: from elephants.elehost.com ([216.66.27.132]:23293 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeCCOWL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 09:22:11 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w23EM4Cr061835
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 3 Mar 2018 09:22:05 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy'?=" 
        <pclouds@gmail.com>, <git@vger.kernel.org>
Cc:     "'Eric Sunshine'" <sunshine@sunshineco.us>
References: <20180303033918.15751-1-pclouds@gmail.com>
In-Reply-To: <20180303033918.15751-1-pclouds@gmail.com>
Subject: RE: [PATCH 0/3] git worktree prune improvements
Date:   Sat, 3 Mar 2018 09:21:56 -0500
Message-ID: <002601d3b2fa$ff6df240$fe49d6c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFFfQpmgu8o94Yllw79o2IlTbccBqTa+NBA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 2, 2018 10:39 PM, Nguy?n Thái Ng?c Duy wrote:
> This is something we could do to improve the situation when a user manually
> moves a worktree and not follow the update process (we have had the first
> reported case [1]). Plus a bit cleanup in gc.
> 
> I think this is something we should do until we somehow make the user
> aware that the worktree is broken as soon as they move a worktree
> manually. But there's some more work to get there.
> 
> [1] http://public-inbox.org/git/%3Caa98f187-4b1a-176d-2a1b-
> 826c995776cd@aegee.org%3E

I wonder whether the OT thread discussion about branch annotation may have some value here. For some repositories I manage, I have received questions about whether there was some way to know that a branch in the clone was associated with a worktree "at any point in the past", which, once the worktree has been pruned, is not derivable in a formal computational sense - there may be specific conditions where it is. Perhaps, if that line of development moves forward, that we should considering annotating the worktree-created branch to help with our pruning process and to identify where the branch originated.

Just a thought.

Cheers,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



