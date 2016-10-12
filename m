Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D9E207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 14:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755054AbcJLOIR (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 10:08:17 -0400
Received: from wp069.webpack.hosteurope.de ([80.237.132.76]:49500 "EHLO
        wp069.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754888AbcJLOIP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Oct 2016 10:08:15 -0400
Received: from app08.ox.hosteurope.de ([92.51.170.15]); authenticated
        by wp069.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
        id 1buJvE-0007Ss-FD; Wed, 12 Oct 2016 15:50:16 +0200
Date:   Wed, 12 Oct 2016 15:50:16 +0200 (CEST)
From:   webmaster@peter-speer.de
Reply-To: webmaster@peter-speer.de
To:     git <git@vger.kernel.org>
Message-ID: <1240187899.41938.1476280216470.JavaMail.open-xchange@app08.ox.hosteurope.de>
Subject: git branches & merge
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.6.2-Rev60
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;webmaster@peter-speer.de;1476281295;e27d5bfb;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.
I have created a release_x branch to work on a new release. The branch is based
on master.
Later I needed to create a hotfix_x branch to work on a hotfix. This branch is
also based on master.

In the hotfix_x branch I needed to correct an IP address to communicate with.
After doing so, I merged the hotfix_x branch with master again and made my
deployment.

Now in the release_x branche the IP address is still the old one.
I am afraid of committing and merging my release_x branch since I think that my
newly defined IP address (now on master) will be overridden when merging.
Am I right? If yes, what is the best way to solve this?

Thanks
-fuz
