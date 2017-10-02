Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37EC202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 07:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751016AbdJBHuJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 03:50:09 -0400
Received: from mail.lcube.de ([81.3.26.173]:34368 "EHLO mail.lcube.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdJBHuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 03:50:09 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Oct 2017 03:50:08 EDT
Received: from [192.168.178.40] (x4dbea4b0.dyn.telefonica.de [77.190.164.176])
        by mail.lcube.de (Postfix) with ESMTPSA id 01F7A4EE057
        for <git@vger.kernel.org>; Mon,  2 Oct 2017 09:40:29 +0200 (CEST)
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Andr=c3=a9_Netzeband?= <andre@netzeband.eu>
Subject: cmd.exe Terminal is closing when cloning a repository on windows 10
 (64.bit)
Message-ID: <5aa837bb-04ae-d80d-3a91-53d06fd7456f@netzeband.eu>
Date:   Mon, 2 Oct 2017 09:42:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I installed git for windows 2.14.2 (64bit) and was trying to clone a 
repository from a command terminal (cmd.exe):

git clone https://Netzeband@bitbucket.org/Netzeband/deep-speeddreams.git

First everything went well, but after the repository was downloaded the 
LFS download started. At this point the terminal window just closed and 
I was not able to see anything related on the terminal. There was no 
error message.
However several git processes (and git lfs) were running in the 
background and downloaded everything for the repository (all lfs files).

The same happens if I use the git-bash.

After switching back to 2.13.0 with the same settings during 
installation, this error did not occur again.

I'm using Windows 10 (b4 bit) which all current updates installed.

Best regards,
André

