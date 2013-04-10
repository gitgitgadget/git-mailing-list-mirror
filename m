From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 03:36:10 +0530
Message-ID: <CALkWK0=xzXu4_sh+7k0u-bb-=GNVSR9hq58QJsHiBZKRzfgh_w@mail.gmail.com>
References: <20130410200548.GC24177@sigill.intra.peff.net> <CALkWK0mEe+p3RX2tamW8dmdY_eP74Rdh_pZDRDPNfzX0TOKQCQ@mail.gmail.com>
 <20130410202456.GF24177@sigill.intra.peff.net> <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net> <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
 <20130410211824.GC27070@google.com> <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
 <20130410212911.GE27070@google.com> <CALkWK0m=iDw+N0zcfEEt1jzFD4wOOzLgyBWNyc=HZ+xLe5SBLw@mail.gmail.com>
 <20130410215658.GC6215@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 00:06:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ3AN-0002JR-HK
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 00:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763325Ab3DJWGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 18:06:51 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:48598 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab3DJWGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 18:06:50 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so1237893iec.13
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=iem3VNxzUrqvXAHtA7klGbS7BCSbUu850d28gPxr9v8=;
        b=d7JdhQBeK3AbJmDagb3BAGETAwwLIT2Ex4oP/YEducen0vN/lO91+cH5GgjfSTaCvN
         5Y5bzFPd1Y0yxNCq+b7Jkv970XjqqT5Tw6q7JWOw2pvT2t5pKE79O5309/U8w+Js93gN
         2XJb5ej1xiKnmJuej0iS9JnISebIVM/JBLZlx1pFsG5yfOoQgxDzVCnKLr7qGPPLNRe0
         R46Q7jBIiW23zSxzdBL6TLzelozwiSDBQER/nwVGwBpV6dzzbthq3Lp3GYHlib4E6IPu
         D3thMtDaPPk8jYqcaxOrovgPMSKnjINI2hIn3jSWLVK3CUzAXerMLqTTrwDg7QtN10UW
         tTVA==
X-Received: by 10.50.108.235 with SMTP id hn11mr2624659igb.107.1365631610586;
 Wed, 10 Apr 2013 15:06:50 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 15:06:10 -0700 (PDT)
In-Reply-To: <20130410215658.GC6215@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220784>

Jeff King wrote:
> It's not that it's not potentially useful. It's that it may be
> surprising and annoying to users who did not want that.

... but this is a new syntax, and doesn't break any existing
expectations.  Why are you imagining what users will expect with a git
push -- master next; that hasn't been invented yet?  From "matching"?
 But we've made it very clear that it's going to change soon.  Users
can still use the git push origin master next; form as usual.  In my
opinion, this new syntax is incredibly useful if users set pushremote
properly.
