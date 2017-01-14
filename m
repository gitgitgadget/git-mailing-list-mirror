Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23C620756
	for <e@80x24.org>; Sat, 14 Jan 2017 02:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdANCH3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 21:07:29 -0500
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:55100 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751022AbdANCH2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Jan 2017 21:07:28 -0500
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jan 2017 21:07:28 EST
Received: from resomta-po-15v.sys.comcast.net ([96.114.154.239])
        by resqmta-po-08v.sys.comcast.net with SMTP
        id SDf0cUfeqwySVSDf5czcqT; Sat, 14 Jan 2017 02:01:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1484359303;
        bh=PkjwCSWhCBwgFCCwY5OAs6PWKOSumDmv/b7FxkPcsO0=;
        h=Received:Received:To:From:Subject:Message-ID:Date:MIME-Version:
         Content-Type;
        b=DrDmf/lmGOq2tdud469OPNmccsQNutua+kTwHcFmV+IyySuEIcb0C/5g6J594AHKe
         E1lesRHF70TXZV1ozgieYoQSwu8OVKGqAPzrk9u683kS5DyJq7XsYFZdeJRik/pNZt
         I1BAnDmzfjSvQ4AJu/WCflbiWHWg3J3AyqxnZr/0Zcq07zzOQxVn+kMFeMFLPa/pQs
         kOkN7uHVDE0zGDsrK+JWWu0MCMUFTOXSqi7ogj53GYG+u7KPaM489CWoP/j7oeNXmb
         KAOciI0qDw97ZoCgxVAbyrGLJr8XPu1jQud681eALZp67mGFYYkzrepdtNwa18SAgw
         g79d55Ia9ZZsw==
Received: from localhost.localdomain ([73.35.250.55])
        by resomta-po-15v.sys.comcast.net with SMTP
        id SDf4ctxMUz1pFSDf5cUePh; Sat, 14 Jan 2017 02:01:43 +0000
To:     git@vger.kernel.org
From:   "David J. Bakeman" <nakuru@comcast.net>
Subject: merge maintaining history
X-Enigmail-Draft-Status: N1110
Message-ID: <58798686.5050401@comcast.net>
Date:   Fri, 13 Jan 2017 18:01:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060103060100010003050406"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------060103060100010003050406
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

History

git cloned a remote repository and made many changes pushing them all to
said repository over many months.

The powers that be then required me to move project to new repository
server did so by pushing local version to new remote saving all history!

Now have to merge back to original repository(which has undergone many
changes since I split off) but how do I do that without loosing the
history of all the commits since the original move?  Note I need to push
changes to files that are already in existence.  I found on the web a
bunch of ways to insert a whole new directory structure into an existing
repository but as I said I need to do it on top of existing files.  Of
course I can copy all the files from my local working repository to the
cloned remote repository and commit any changes but I loose all the
history that way.

Thanks.

--------------060103060100010003050406
Content-Type: text/x-vcard; charset=utf-8;
 name="nakuru.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nakuru.vcf"

begin:vcard
fn:David J. Bakeman
n:Bakeman;David J.
org:Nakuru Software Inc.
adr:;;1504 North 57th Street;Seattle;WA;98103;USA
email;internet:nakuru@comcast.net
tel;work:(206)545-0609
tel;fax:(206)600-6957
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------060103060100010003050406--
