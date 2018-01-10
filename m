Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 388621F404
	for <e@80x24.org>; Wed, 10 Jan 2018 13:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbeAJN5m (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 08:57:42 -0500
Received: from forward105p.mail.yandex.net ([77.88.28.108]:47902 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751062AbeAJN5k (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jan 2018 08:57:40 -0500
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2018 08:57:40 EST
Received: from mxback8g.mail.yandex.net (mxback8g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:169])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 9BD714082A99;
        Wed, 10 Jan 2018 16:48:09 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback8g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Nlr3kzblON-m8tCOimZ;
        Wed, 10 Jan 2018 16:48:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1515592088;
        bh=JU3dqGR1f8mMITkohPjTHrF4ktm1N7nBE2DiKDeARLo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date;
        b=dRpmiccBKQxQFTS8Oqye9jR2DHDfqpKNLeDSIPq9OHIy9OSzPg8vxdYr5k5Ipul5O
         cGYEG9JCqtbiA4XXvDCIVRiphiUbwpxKNZvo12GaOJAy0O90/jH103i9nUyNQP7imp
         qovUOxR4jAdt6vtT+DY4YQuKUqeEGOwLdKgeOIB4=
Authentication-Results: mxback8g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web42o.yandex.ru with HTTP;
        Wed, 10 Jan 2018 16:48:08 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
In-Reply-To: <CACBZZX5g95nTtA5--g8K29FjQ=dU3JLEfVXZjUs8J2Y-QCzYHg@mail.gmail.com>
References: <6962041489243945@web20g.yandex.ru> <CACBZZX5g95nTtA5--g8K29FjQ=dU3JLEfVXZjUs8J2Y-QCzYHg@mail.gmail.com>
Subject: Re: How to view diff when doing `git push --force`
MIME-Version: 1.0
Message-Id: <40271515592088@web42o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 10 Jan 2018 15:48:08 +0200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> At this point, no, but in the future instead of --force use
> --force-with-lease=<refname>:<expect> where <expect> is e.g. $(git
> rev-parse HEAD).

Thank you.

But I have found next command to see what were changed. 
For example if someone did forced push and I wanna see changes before merge remote

git log --graph --decorate --pretty=oneline --abbrev-commit --cherry-mark --boundary --left-right

But is there an option to view changes in amended commits?

See the last code post about unknown option  in the next answer :
https://stackoverflow.com/a/48149931/4632019


If there is no such option. Will it be useful to have it?
