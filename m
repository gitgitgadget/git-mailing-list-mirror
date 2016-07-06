Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444EF2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 16:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbcGFQLO (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 12:11:14 -0400
Received: from mail1.intellij.net ([46.137.178.215]:46533 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbcGFQLN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 12:11:13 -0400
X-Greylist: delayed 677 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jul 2016 12:11:13 EDT
Received: (qmail 28243 invoked by uid 89); 6 Jul 2016 15:59:54 -0000
Received: from unknown (HELO ?172.31.0.244?) (Nadya.Zabrodina@jetbrains.com@81.3.129.9)
  by ip-10-79-47-171.eu-west-1.compute.internal with ESMTPA; 6 Jul 2016 15:59:54 -0000
From:	"Nadya.Zabrodina@jetbrains.com" <Nadya.Zabrodina@jetbrains.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: git patch format for rename
Date:	Wed, 6 Jul 2016 19:00:17 +0300
Message-Id: <F58A6A72-4AE5-42FA-843D-66FF809FF1A8@jetbrains.com>
Cc:	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
To:	git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
X-Mailer: Apple Mail (2.3112)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

could you please explain to me why  ‘rename from & rename to’ information is added to git patch? 

Here is the patch created by `git format-patch`: 

    diff --git a/before.txt b/after.txt
    similarity index 100%
    rename from before.txt
    rename to after.txt

Is there any reason why git can’t recognize and apply rename-change which looks like this:

    diff --git a/before.txt b/after.txt
    --- a/before.txt
    +++ b/after.txt
    
or even like this:
    diff --git a/before.txt b/after.txt


I’m implementing a program (with an IDE) to create patches compatible with Git and want to have better understanding of the format and possible issues with it.

Thanks a lot in advance.


