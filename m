From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 03:02:08 +0530
Message-ID: <CALkWK0kkzc04uFqLb1gsrUDJ1Thw_LGzNkPq6oz_d3+xXs8cHA@mail.gmail.com>
References: <20130409231332.GZ30308@google.com> <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net> <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net> <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net> <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <20130410195256.GA24177@sigill.intra.peff.net> <CALkWK0nAMVKuDg4wmwujkpNxAF9zxQEdsZXyUzr+w4zVpWDCzA@mail.gmail.com>
 <20130410202105.GE24177@sigill.intra.peff.net> <CALkWK0nfJezWbd3+VfA+DMqUNbekSJJJ539AmhQT37kkap_qeg@mail.gmail.com>
 <CALkWK0=UacRnjWJJCtJttk4W_8cbTXQbpQTDJ2+45S9CxXXzAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:32:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2dS-0001lb-H3
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934753Ab3DJVcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:32:50 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:47438 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab3DJVct (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:32:49 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so312492iaf.32
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sedfuxD5h4tg07422CaWgNCfGZRG75lUXJdM6Z5kyeg=;
        b=0fq+qA+jDoqbUVINzFJECdB5xL3OTVDP/tTlCtooaBp0ty+ooAP8clXlaLKiRBf2ZA
         skVzOUh+QibFIqtA3Rd0cFvw8c5SUi5dgmjkBj4GNS18/+xgOUyuZNsWIKv6eCfgHY23
         RvhuFDkYxriIgW3KA1W4w3gAxuWoIc8yxYSaFV+gA4fTegdcf0OyCoFtjSw2Y1ZYvQ+2
         AlaC4qiniLU0xuqnJBFOwkmTAxhAGd3857TyQL/bnsHhJZ6d7MONInEQJ2YKfOYMrjwX
         jzs2Sk3SwmU1zjf1xnMRd8ndyjSZVAX4Xrlk6PVJe2HCtXzuuC9w/xPkJJr/3DDxpm7w
         u3mA==
X-Received: by 10.50.119.102 with SMTP id kt6mr2775156igb.12.1365629569406;
 Wed, 10 Apr 2013 14:32:49 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 14:32:08 -0700 (PDT)
In-Reply-To: <CALkWK0=UacRnjWJJCtJttk4W_8cbTXQbpQTDJ2+45S9CxXXzAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220777>

Ramkumar Ramachandra wrote:
> If we're going to break "matching" anyway, let's break it fully.

Wait, let's not break anything.  Instead, let us invent a new
push.default that does this ref-to-remote matching, and make git push
-- master push-implicit; consistent with that.  Then "matching" can be
deprecated as usual.
