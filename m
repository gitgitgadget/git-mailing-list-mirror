From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 13:15:28 +0530
Message-ID: <CALkWK0k+rsh-Ft3=+Fz2DkV5btdLg-bCJzJCKxgxMyNcmpj++w@mail.gmail.com>
References: <20130410202456.GF24177@sigill.intra.peff.net> <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net> <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
 <20130410211824.GC27070@google.com> <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
 <20130410212911.GE27070@google.com> <CALkWK0m=iDw+N0zcfEEt1jzFD4wOOzLgyBWNyc=HZ+xLe5SBLw@mail.gmail.com>
 <20130410215658.GC6215@sigill.intra.peff.net> <CALkWK0=Y-pO3+g21PLCWOxx+M-7fSmp2FedMBtZ68PWU_TOHDw@mail.gmail.com>
 <20130410222334.GC6930@sigill.intra.peff.net> <CALkWK0nvTisYCFjxwuGaBbWawwBahzeBHZ84rFkUYL8sjJuxvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 09:46:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQCD2-0000fS-JN
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 09:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759647Ab3DKHqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 03:46:10 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:32945 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab3DKHqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 03:46:09 -0400
Received: by mail-ia0-f170.google.com with SMTP id j38so1199705iad.29
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5vbolhSljIzKr2l1YPuHUitJHVCLFotzU8Rss//fYS8=;
        b=oqdgPL3hwIZsgwVW25cDXRwSEywZq1fzQ38uAvOlJKag//dWON1UAhWg/0MsF1d8xp
         MQb5bH/4OylR+usK8r4CypX6ksjz6tSOyXuCDZjZaPjDwB3g7b+sZKm5d0t5LDxOmY13
         QiG53CCuPNGvR9FrDN5GGy+vF7yPDUf1gWEp0aDw/qXhTNcNUAEADcFLOEN7RfUrE7nH
         uIDX6ylvAEmqOElbw+Cflwn1JZ27nnUpFvF0Vp+VwYyn4r2TFQeRE+V5pMCzPkEpOV1u
         /S2LdzripmUv9/06H2PYLNlFrmON1hvYkIbviLT9YXqCWWD0j0FAHp4Rax4hfdY/rjZU
         7R8A==
X-Received: by 10.42.50.202 with SMTP id b10mr3304203icg.7.1365666368648; Thu,
 11 Apr 2013 00:46:08 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 11 Apr 2013 00:45:28 -0700 (PDT)
In-Reply-To: <CALkWK0nvTisYCFjxwuGaBbWawwBahzeBHZ84rFkUYL8sjJuxvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220832>

Ramkumar Ramachandra wrote:
> - branch.implicit-push-next.pushremote set to null**, because I will
> never want to push this branch.

Currently, I have a hacky workaround: I set
branch.implicit-push-next.pushremote to a remote that I don't have
write access to (ie. origin), effectively failing all my attempts to
push this branch.
