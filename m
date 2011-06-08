From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 8 Jun 2011 22:23:36 +0700
Message-ID: <BANLkTimtxESnZ23tRBYYVN1paUmNOhdPyw@mail.gmail.com>
References: <20110608093648.GA19038@elte.hu> <20110608203433.61e02ad8.sfr@canb.auug.org.au>
 <20110608125242.GA32745@elte.hu> <BANLkTiku_qvn73cUDBT=OxY-3jR3raoOhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ingo Molnar <mingo@elte.hu>, Jeff King <peff@peff.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>, git@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:24:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKcC-0005z7-3M
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318Ab1FHPYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 11:24:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51340 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab1FHPYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 11:24:08 -0400
Received: by bwz15 with SMTP id 15so507186bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=oaGSmy9vbFzu9jR1B+EYBFfjhYZzVA1nPRz7ael8kZg=;
        b=dVgRvqTWogWKk/RmZXLq37pSwh4ayLN7D98vbNMlQ9rNgvR6Otp2kMgyRZHzzuLYtj
         c+3Pb4TwjQSS/xeSCZG8uutuwMY4m+3JUn2FA7IQVqtknz02OyTLPVhHULlpT3s8cgYa
         mtJ1M82vKCP8oPV8VrAR/kehIgIsJ2NlbLCgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=VaoDcAHWbwmFP7h0icLv1iaq4daXJSVZDeilqjMpsvHi8apAVf15U74X9O73pWs/vc
         5w1hiUi6OnZFNc75H6aL1cR1dvyCWRKOJdCOIUJvha5yyl6WCTJBcWjmRrFlJxgo6zF3
         J0v/MZjlEUUcYiRg6MR1hkZLmiDz/ZYIIhhR0=
Received: by 10.204.16.198 with SMTP id p6mr812148bka.143.1307546646377; Wed,
 08 Jun 2011 08:24:06 -0700 (PDT)
Received: by 10.204.50.150 with HTTP; Wed, 8 Jun 2011 08:23:36 -0700 (PDT)
In-Reply-To: <BANLkTiku_qvn73cUDBT=OxY-3jR3raoOhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175384>

2011/6/8 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> [+Peff, Duy, who seemed interested in this]
>
> On Wed, Jun 8, 2011 at 14:52, Ingo Molnar <mingo@elte.hu> wrote:
>> So it would be nice to have more separation for remotes - right now
>> they do not sit still in their sandboxes! :-)
>
> Sounds like the "tags should go in their own namespaces in git 1.8.0"
> [0] discussion? :)
>
> [0] http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=165837

A lengthy thread. Does anybody remember the outcome? Was Johan's
proposal OK and only waiting to be implemented, or is there still
unanswered questions?
-- 
Duy
