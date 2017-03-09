Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A2B202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 18:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932614AbdCISN3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 9 Mar 2017 13:13:29 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:49006 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754853AbdCISN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 13:13:26 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Mar 2017 13:13:26 EST
Received: from [131.246.194.95] (helo=wpa-8376.kl.dfki.de)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.84)
        (envelope-from <dev@joernhees.de>)
        id 1cm2BD-0005mU-CD
        for git@vger.kernel.org; Thu, 09 Mar 2017 18:48:47 +0100
From:   =?utf-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: git commit --interactive patch-mode no longer allows selecting files
Message-Id: <8C99B562-9194-4227-B40D-F64BBECEEE38@joernhees.de>
Date:   Thu, 9 Mar 2017 18:48:58 +0100
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
X-Df-Sender: bWFpbEBqb2VybmhlZXMuZGU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

i'm not entirely sure if this is a bug or intended (couldn't find it in the changelogs though)...

Before 2.12.0 a `git commit --int` / `git add --int` followed by [p] for patch-mode, would allow a numeric selection of the files to patch hunks for (this behavior is well documented all over the internet).

Since 2.12.0 the numeric selection is skipped and automatically drops me directly into hunk mode (Mac OS X homebrew).

I would see this as a feature if only one file is changed. As soon as multiple files are changed, i often have the use-case that i'm in some bigger change, but want to quickly fix something in other files. In those cases, the new behavior forces me to `d` out of potentially many files, just to quickly commit some small change :-/

I already tried in several repos and without ~/.gitconfig .
Are there any config options i'm missing?

Best,
Jörn

