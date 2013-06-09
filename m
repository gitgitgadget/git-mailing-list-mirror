From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 14:29:51 -0500
Message-ID: <CAMP44s3pAUi9G4BU39bMo5nJ+YyrJ0FS+UY1c5yJsu5+x0k7Gw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:29:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllJN-0004pq-Oq
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab3FIT3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:29:53 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:43552 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab3FIT3w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:29:52 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so834600lbd.18
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8uDAYoNTfOBC9nvCB280BpxS+glsT2tTrOGDhojE7sc=;
        b=mf42U+vUPi6KypPOZXwkNaK5sfaarlEKq3Q1UCMIsj+x4V5LNFMTLstecEON18QuW5
         DhVEnJBQU+8nOGyidaFhL/d0ZAJ8jUukM0VpbcqPdz1L+mmOmqgfdmCAb+ZPf7Qt2XHk
         /Y8KSpc11m9MwkbynKgUuHVpO8wfdbbOCQAtWM5XkGYwhmPrY2BLdzVO4kl7Hcn48jcp
         vRwwb7KQvf2uBssGoviLOk6e0ekZalBb1N6IwNVyo1F8t1HCW/lb8aM2eJvLY85qKF2d
         Dcsb5SCpUxCWpekSseVYA708zNs7bvlkUoAtcYAjRKAGipkMRaf10YrJK7Yi6PfXRDtu
         GBLw==
X-Received: by 10.112.16.163 with SMTP id h3mr5051679lbd.85.1370806191262;
 Sun, 09 Jun 2013 12:29:51 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 12:29:51 -0700 (PDT)
In-Reply-To: <CALKQrgc5K0U2qCHjjzgxw1=70FbmHdokU3H0tfB_=+7gDVNzsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227147>

On Sun, Jun 9, 2013 at 2:11 PM, Johan Herland <johan@herland.net> wrote:
> On Sun, Jun 9, 2013 at 8:16 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sun, Jun 9, 2013 at 1:10 PM, Jeff King <peff@peff.net> wrote:
>>> Go back to my 261 commits, show me one that is "unmindful of technical details".
>>
>> And you say this thread is an excellent example of your point that I'm
>> unmindful of technical details?
>>
>> It's not. There are no technical details I was unmindful of in this thread.
>
> Ok, I'll bite (against my better judgment). From a related thread, a
> few minutes ago:
>
> On Sun, Jun 9, 2013 at 7:46 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sun, Jun 9, 2013 at 12:32 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> So you would deliberately break a bisection on this test file?
>> No, this patch series won't be applied.
>
> Thomas points out a technical detail with the patch series, and the
> answer given is 100% non-constructive.

Geezus!

http://thread.gmane.org/gmane.comp.version-control.git/227109

There. Are you happy?

I dropped the patches that are not part of the series.

Who benefits from this? NOBODY. Certainly not the users.

-- 
Felipe Contreras
