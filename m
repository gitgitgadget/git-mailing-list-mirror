From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 00:12:39 -0500
Message-ID: <CAMP44s3XXzGtVQx8x-56iFQ4ph9VOrzoBczpy-xqXKdiRxRU3Q@mail.gmail.com>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
	<20130609174049.GA1039@sigill.intra.peff.net>
	<CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com>
	<20130609181002.GC810@sigill.intra.peff.net>
	<CAMP44s0ky7ad3cGBQs0DNht4Uo4MR08VrNx+PigcNraDP76CLA@mail.gmail.com>
	<CALKQrgc5K0U2qCHjjzgxw1=70FbmHdokU3H0tfB_=+7gDVNzsA@mail.gmail.com>
	<51B4F6CA.8020807@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 10 07:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UluPZ-0004YL-VK
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 07:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151Ab3FJFMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 01:12:42 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:54010 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab3FJFMl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 01:12:41 -0400
Received: by mail-la0-f47.google.com with SMTP id fe20so5234110lab.6
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 22:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vpn4SsS9DB7UC4gBZ4Az97TKDOXqv/WzzX143uJJtbc=;
        b=BCY9wQUspWCy9rXuQ23XgPARXpjMIkHvMCB4SSPOngFr0X2SOBKkNLnbVJqGOnNfBf
         2B+KcTCyOL5yBR02tPUUUxI+34ycUR/4GmAuqND+6n5eEFwsHuJjXzcS0K+VnN+Q0+5P
         /IJ2Xta2A6AinWMoKOZEoFN6tJd4gTLO0NLsWO5M5/xL0XCkfmLBH9Xa6gPgvguX4gKA
         4Xy6SKSoX82wkPAKp2R0z5UGKWrSeLdgm2bS6trhAUW90jnedawIl4cx1K9VsjdhBHtt
         OULKVsl0UjRWpPdVvhYLPWvCscKkRXVtCmPUoFZOmgRj7P+Q2Og45aOpz1ec3t+ncvms
         8Hmw==
X-Received: by 10.112.16.163 with SMTP id h3mr5680450lbd.85.1370841159592;
 Sun, 09 Jun 2013 22:12:39 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 22:12:39 -0700 (PDT)
In-Reply-To: <51B4F6CA.8020807@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227235>

On Sun, Jun 9, 2013 at 4:42 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

> Felipe, I wish that you would devote a small fraction of your prodigious
> energy to the very difficult challenge of feeling empathy,

I do feel empathy, the problem is that you make the assumption that
other people are like you, and that somehow I like the same things as
you; to be treated nicely. I don't.

> understanding, and respect for the other members of the community.

Respect is not automatic.

> But
> if things continue the way they have, I personally would, with sadness
> in my heart, prefer to forgo your patches in exchange for the more
> important benefit of a more collegial (and therefore overall more
> productive and sustainable) community.

In other words; you prefer to talk to people that have a similar mind
than you, and avoid doing what the project actually needs; code.

I wrote tons of code that help the project. And you avoid that because what?

Can you put the needs of the project about your personal need for
others to be nice towards you?

-- 
Felipe Contreras
