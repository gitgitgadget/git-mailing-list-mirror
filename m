Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6674B1F51C
	for <e@80x24.org>; Mon, 21 May 2018 13:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeEUN7C (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 09:59:02 -0400
Received: from elephants.elehost.com ([216.66.27.132]:29662 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbeEUN7B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 09:59:01 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w4LDwGZ1042661
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 May 2018 09:58:17 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Robert P. J. Day'" <rpjday@crashcourse.ca>,
        "'Git Mailing list'" <git@vger.kernel.org>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain>
Subject: RE: which files are "known to git"?
Date:   Mon, 21 May 2018 09:58:09 -0400
Message-ID: <000201d3f10b$c3bfd660$4b3f8320$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHoqLTBUSHbyQiB0/OS40su5exHlaQQxYBA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 21, 2018 7:19 AM, Robert P. J. Day:
>   updating my git courseware and, since some man pages refer to files
> "known to git", i just want to make sure i understand precisely which
files
> those are. AIUI, they would include:
> 
>   * tracked files
>   * ignored files
>   * new files which have been staged but not yet committed

You might want to consider git metadata/config/attribute files, hooks,
filters, etc., that may not be not formally part of a repository, but can be
required to ensure the content is complete.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



