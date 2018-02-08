Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5817A1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 14:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBHODn (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 09:03:43 -0500
Received: from mx4.wp.pl ([212.77.101.12]:32621 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbeBHODm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 09:03:42 -0500
Received: (wp-smtpd smtp.wp.pl 15720 invoked from network); 8 Feb 2018 15:03:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1518098620; bh=42oZPApHgqanAHUa7lxpQuwnyMRWgbkO4y+fr+oyH3g=;
          h=Subject:From:To;
          b=wVI2GVKLDqgQcUM2aWb1w/7kU07RiyCFVVILwcHWvssVj6PQqI7hW+o72zT7L16Am
           w0Zk8cQM014s1aUYMCQAr5JgZ/4TnYf72HF0zQjFbSDa1b6PtVsDLmFU5eH05R+7Ar
           zdJU+VHD/ntsY7ofCV0ElZwkGD29+s6cbYVzK//M=
Received: from public-gprs351598.centertel.pl (HELO [192.168.0.102]) (borucki_andrzej@wp.pl@[37.47.4.175])
          (envelope-sender <borucki_andrzej@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with SMTP
          for <git@vger.kernel.org>; 8 Feb 2018 15:03:39 +0100
Subject: Automatic parameters completion
From:   Andrzej <borucki_andrzej@wp.pl>
To:     git@vger.kernel.org
References: <29b0272d-7854-592d-5e1c-3a4f0d347bd1@wp.pl>
Message-ID: <131f3b0f-0002-2823-d64b-ffd16fff8dfa@wp.pl>
Date:   Thu, 8 Feb 2018 15:03:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <29b0272d-7854-592d-5e1c-3a4f0d347bd1@wp.pl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-WP-MailID: e579cebb457861405b45a427b8a993f6
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [McNt]                               
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have Linux Mint and its terminal besides usual completion (add file 
name when type first letter and press tab) also can complete git 
parameters. How is doing this? Bash knows git or bash has special 
interface to completion and git uses it?
I want in my Linux program apply this mechanism.
