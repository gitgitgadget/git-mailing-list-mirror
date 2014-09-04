Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 28600 invoked by uid 107); 4 Sep 2014 08:11:39 -0000
Received: from Unknown (HELO cloud.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Sep 2014 04:11:39 -0400
Received: (qmail 30678 invoked by uid 102); 4 Sep 2014 08:11:21 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by cloud.peff.net (qpsmtpd/0.84) with ESMTP; Thu, 04 Sep 2014 03:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbaIDILK (ORCPT <rfc822;peff@peff.net>);
	Thu, 4 Sep 2014 04:11:10 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:51234 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaIDILH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 04:11:07 -0400
Received: by mail-qa0-f52.google.com with SMTP id f12so8864284qad.25
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 01:11:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=beFpoi4+5Q2reGoKYupOnEXZmN8QLEIL6FuXCIpZ+F4=;
        b=a8H8l+L4WX/q2HKx1o93ROjOP4MVUb1kfEcS+9guZTgA2OrI8o+T6XciAMbzT7QZwf
         9AfBOqaFaVuxAZa2VZ2SZ6IO/ud6NPfpD4A//xK8wwHm0S0g+gNOSxXzC9Cj6xOdU4bN
         HW+7n6kOGgC8faSJ9xSQwAmgcA4RDe8bFhfjW9x/9SSLHVNwJjtkLddg5D7zBV770CJN
         AL1MBsR++/YFbu9+1+agJxCz0de29vHYyLYqXemN6X1Dx2v+fqkEQAz2FV9HSNSjZJWD
         D9fj/NNXEGYQOFle3kDjpMaWTSE3nXLluHnMqMPdthWHBxGn7tRAekv+DIxEkWezlP3p
         jWvA==
MIME-Version: 1.0
X-Received: by 10.229.136.133 with SMTP id r5mr4474694qct.31.1409818266494;
 Thu, 04 Sep 2014 01:11:06 -0700 (PDT)
Received: by 10.140.49.105 with HTTP; Thu, 4 Sep 2014 01:11:06 -0700 (PDT)
Date:	Thu, 4 Sep 2014 16:11:06 +0800
Message-ID: <CAHbSJRD=S4u=_Ke3UKfzaVdsPnjvkKf0VYBjo8sNjFXM32wKTQ@mail.gmail.com>
Subject: Can git detect and manage source file's extensional attribute by
 command 'setfattr' ?
From:	wangfeng wangfeng <wangfeng.v1.1985@gmail.com>
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi ,
    I know that git can cope with file's chmod. But how about
setfattr? I have tried to set some extensional attribute with command
:
####
setfattr -n user.t1 -v 1 testfile.txt
####
It seems like git cannot detect it. So do I need some config option
for git? Or doesn't it have this feature?
    Thanks very much.

Wang
