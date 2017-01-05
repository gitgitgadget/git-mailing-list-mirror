Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FEB71FEB3
	for <e@80x24.org>; Thu,  5 Jan 2017 10:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968751AbdAEK2o (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 05:28:44 -0500
Received: from boxbox.org ([176.9.18.141]:56336 "EHLO boxbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752418AbdAEK2m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 05:28:42 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jan 2017 05:28:41 EST
Received: from [192.168.1.10] (aftr-37-201-231-205.unity-media.net [37.201.231.205])
        by boxbox.org (Postfix) with ESMTPSA id 526E11B5C002;
        Thu,  5 Jan 2017 10:09:57 +0000 (UTC)
To:     git@vger.kernel.org
From:   Stefan Schindler <stsch@boxbox.org>
Subject: core.sshCommand and url.*.insteadOf for submodules
Message-ID: <17f2724d-7001-203e-f0b5-cf586703a41a@boxbox.org>
Date:   Thu, 5 Jan 2017 11:09:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello mailing list,

it seems like that the `core.sshCommand` and `url.*.insteadOf`
configuration settings do not apply to `git submodule update --init`
(and probably related) calls.

Is this intentional?

My scenario is as follows: I use 2 SSH keys for GitHub, for private and
work-related repositories. My default key is my private key. So when I
clone a work repository and try getting the submodules, `git submodule
update --init` fails. This is also the case when setting
`core.sshCommand` and `url.*.insteadOf` (useful for substituting
"github.com" by some ~/.ssh/config'ured host).

Greetings,
Stefan Schindler
