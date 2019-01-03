Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E85B1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 08:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfACICb (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 03:02:31 -0500
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:40479 "EHLO
        8.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfACICb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 03:02:31 -0500
X-Greylist: delayed 1199 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2019 03:02:30 EST
Received: from player711.ha.ovh.net (unknown [10.109.146.86])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id DA1BD36788
        for <git@vger.kernel.org>; Thu,  3 Jan 2019 08:22:49 +0100 (CET)
Received: from RCM-web4.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player711.ha.ovh.net (Postfix) with ESMTPSA id 9B0601375F50
        for <git@vger.kernel.org>; Thu,  3 Jan 2019 07:22:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 03 Jan 2019 08:22:49 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     git@vger.kernel.org
Subject: Re: git-send-email warnings & process dying of signal 11
In-Reply-To: <1e4ac3d5-f6f5-bcce-2f09-0519934289b9@milecki.pl>
References: <1e4ac3d5-f6f5-bcce-2f09-0519934289b9@milecki.pl>
Message-ID: <19f3c27ed059f5556131b3e0d2faafce@milecki.pl>
X-Sender: rafal@milecki.pl
User-Agent: Roundcube Webmail/1.3.8
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
X-Ovh-Tracer-Id: 13279144976459402973
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrudejgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-01-01 23:45, Rafał Miłecki wrote:
> Hello & Happy New Year!
> 
> I've recently switched from openSUSE 42.3 (perl 5.18.2 & git 2.13.7) to
> the openSUSE Tumbleweed (perl 5.28.1 & git 2.20.1) and send-email
> doesn't work for me anymore.
> 
> FWIW it doesn't seem like a git regression. I've manually installed
> 2.13.7 in my new OS and it also fails.
> 
> It basically fails with the:
> Warning: unable to close filehandle __ANONIO__ properly: Bad file
> descriptor at /usr/lib/git/git-send-email line 812.
> Warning: unable to close filehandle __ANONIO__ properly: Bad file
> descriptor at /usr/lib/git/git-send-email line 812.
> error: git-send-email died of signal 11

It appears to be a problem with (my?) perl. I've tried reporting it:
https://rt.perl.org/Public/Bug/Display.html?id=133750
