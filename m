From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 02:45:50 +0530
Message-ID: <CALkWK0m9karG=geF4KYapWJfit7zisiZ46cXNNzjh3+3yUpgVw@mail.gmail.com>
References: <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org> <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org> <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org> <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org> <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com> <7vhajeku7a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:16:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2Nf-0006aO-8X
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759240Ab3DJVQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:16:31 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:35715 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab3DJVQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:16:30 -0400
Received: by mail-ia0-f179.google.com with SMTP id l25so812528iad.38
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fSCHuT5pk3PrlOwAYlLMRDvqnY8TLYkqh9+kTlxu1XU=;
        b=FN/etZeFpKXKk2GmbgX18MONCjlD9TbSbtuL5r7JEcJT4xxN+s7JG4Z1ge2jD/NiRo
         Hrp4rxPTAPoW2h4AL1YSZKhIMzf3bg9nCU7ZEbPIC/6Xu1lPrc9Cp4Nn/oMGQuoOZJ4e
         xKT3njE0fkjKtrYjtlc+fXd3jsOyk2nj49zGabnqOaWhFZ5a5MEstlK2SR3jhKhnk0Kb
         r5UL5hx48RFJfQotzJMrHUP8S9meKp+T3ZcEJBfX3F0LN0CZhShitVyBdljlG9Wqflej
         66hzrC1I7JsKur0uYMGIT+GwJ+uVOXX489SVs1vjMh3t5ccK9gGIsBZbB2lXJVhE070P
         fonw==
X-Received: by 10.50.108.235 with SMTP id hn11mr2524839igb.107.1365628590158;
 Wed, 10 Apr 2013 14:16:30 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 14:15:50 -0700 (PDT)
In-Reply-To: <7vhajeku7a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220768>

Junio C Hamano wrote:
> On the other hand, a good thing is that the remote.pushdefault makes
> perfect sense whether you use the upstream mode or the matching
> mode.  I vaguely recall that I kept telling you that the overall
> default should be there and per-branch stuff can come later if/as
> needed, to which you resisted for a couple of rounds of reviews and
> I couldn't quite figure out where the resistance was coming from.
> Come to think of it, perhaps that might be rooted in the same
> reason of not thinking about users of "matching" mode.  I dunno, and
> I do not think it matters.

remote.pushdefault is simple; it doesn't open up interesting
possibilities like branch.<name>.pushremote does (I mentioned
branch-specific r/w access somewhere else in the thread).  Because of
my obsession with "current", I never think of the repository as a
whole but each branch separately tracking a remote.
