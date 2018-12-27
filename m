Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA9B211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeL0QBl convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 27 Dec 2018 11:01:41 -0500
Received: from elephants.elehost.com ([216.66.27.132]:15839 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeL0QBl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:01:41 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash ([99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wBRG1bdk041764
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Dec 2018 11:01:37 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Derrick Stolee'" <stolee@gmail.com>,
        <randall.s.becker@rogers.com>, <git@vger.kernel.org>
References: <20181226230523.16572-1-randall.s.becker@rogers.com> <efa03ee9-b84f-5221-d811-1ccda9132007@gmail.com>
In-Reply-To: <efa03ee9-b84f-5221-d811-1ccda9132007@gmail.com>
Subject: RE: [PATCH v1 0/4] HPE NonStop Port Commits
Date:   Thu, 27 Dec 2018 11:01:31 -0500
Message-ID: <000101d49dfd$7250ed60$56f2c820$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHP6M3TTaFeK+MquD7CewJFvBAGhQKjjVUYpYcMG0A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 27, 2018 7:13, Derrick Stolee:
> On 12/26/2018 6:05 PM, randall.s.becker@rogers.com wrote:
> > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >
> > This set of patches is a distilled version of the minimal set of
> > changes to git that will allow it to run as client and server on HPE
> > NonStop NSE and NSX systems. NSR systems are no longer under support
> > so references to them have been removed. Each patch in this set is
> > independent but required for correctness.
> >
> > Randall S. Becker (4):
> >    transport-helper: use xread instead of read
> >    config.mak.uname: support for modern HPE NonStop config.
> >    git-compat-util.h: add FLOSS headers for HPE NonStop
> >    compat/regex/regcomp.c: define intptr_t and uintptr_t on NonStop
> 
> These patches look correct to me. Just one question on patch 3
> (git-compat-util.h: add FLOSS headers for HPE NonStop).
> 
> I'm not able to comment on patch 2 (config.mak.uname: support for modern
> HPE NonStop config.), but it looks to be wrapped in a platform-specific 'if',
> so should be fine if you are happy with it.

Thanks! Please go for it, with v2 3/4 that should be available now. This will radically simplify our life on maintaining the port.

Kind Regards,
Randall et. Cohorts who know who they are.


