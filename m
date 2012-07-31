From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Tue, 31 Jul 2012 15:43:57 -0700
Message-ID: <CAFzf2XzC4Y1AhBV4BU5zZ411f=oVzoOyNA=e1L2eZd3bjyEgjQ@mail.gmail.com>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<19477122.a5lMBqWgns@flomedio>
	<20120730165502.GB8515@burratino>
	<2351904.F5IazNUWoD@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 00:44:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwLBC-0001aT-FP
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 00:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757Ab2GaWn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 18:43:58 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56374 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab2GaWn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 18:43:58 -0400
Received: by gglu4 with SMTP id u4so6680412ggl.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BbvzdGpdA1gsMU7/3UEuyi1d1TGbDlMuPvEYe0LbDO4=;
        b=yFA0x8uYiO9OnkNmlpabBJI6sPCPGwSUmEPoVMMjqBNGVgY7G830JMAVDsW1GDTNUB
         QNbrYS/z0yzOg6FAYYfZnlp41GG0/jQQrl6DKiVesFwn8Nq7rZF6R4ozz22snrpjHx1y
         NexGzLD1/0dnTj6xk1fZpRw7rH1KK7slfNtnRnQAbCyg2subCF5jyRdCPSwgkv8/A4kf
         /TRjWNcri9y8CCVzhqWigZNnXZmhOtxo8PBT/KwdBUr6fGsMrwtYyqbAn7FMDg8QrydB
         mGdbN76s6eBfSKwXlcor/w1Xb09nzSSxwLXKF4lgL88pGspKyKRTdf8SKhBOG2cWOdml
         fIsg==
Received: by 10.68.220.39 with SMTP id pt7mr48077397pbc.40.1343774637267; Tue,
 31 Jul 2012 15:43:57 -0700 (PDT)
Received: by 10.68.14.134 with HTTP; Tue, 31 Jul 2012 15:43:57 -0700 (PDT)
In-Reply-To: <2351904.F5IazNUWoD@flomedio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202688>

Florian Achleitner wrote:

> I haven't tried that yet, nor do I remember anything where I've already seen
> two processes writing to the same pipe.

It's a perfectly normal and well supported thing to do.

[...]
> Will try that in test-program..

Thanks.

Good luck,
Jonathan
