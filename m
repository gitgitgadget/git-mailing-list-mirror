Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D837AC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C7A2072B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 19:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgAPTzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:55:01 -0500
Received: from elephants.elehost.com ([216.66.27.132]:52278 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730342AbgAPTzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 14:55:01 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 00GJsuBm012356
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 16 Jan 2020 14:54:57 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Andreas Schwab'" <schwab@linux-m68k.org>
Cc:     <git@vger.kernel.org>
References: <005801d5cc8e$7ae618e0$70b24aa0$@nexbridge.com> <875zhbmbg3.fsf@igel.home>
In-Reply-To: <875zhbmbg3.fsf@igel.home>
Subject: RE: [RFE]: git submodule commit push
Date:   Thu, 16 Jan 2020 14:54:51 -0500
Message-ID: <006201d5cca6$d3dbea20$7b93be60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG+DP6kHNSgOyzT1Un0umyZonaCMgGw6ClUqA+sA3A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 16, 2020 2:46 PM, Andreas Schwab wrote:
> On Jan 16 2020, Randall S. Becker wrote:
> 
> > I'm finding that I have a frequent need to commit and push submodule
> > changes because the submodule is currently subject to a whole bunch of
> > changes. The submodule is pretty deep down in the java path of a maven
> > project - so 7 directories down from the git root. It's a bloody pain
> > to constantly change directories to get down there and back up to where
I
> am working.
> 
> You can also use git -C <path> ...

Yes, and I could also set up an alias, which I did, but it still seems like
submodule operations might be made more convenient from anywhere in the
parent repo in general. Just a suggestion for discussions.

