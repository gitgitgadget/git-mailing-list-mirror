From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Wed, 25 Feb 2015 23:31:15 -0800
Message-ID: <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
	<CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
	<xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 08:31:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQsuo-0007fD-4w
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 08:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbbBZHbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 02:31:17 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:37564 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbbBZHbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 02:31:16 -0500
Received: by iecrl12 with SMTP id rl12so11802266iec.4
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 23:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=W1x0avN4vzlS8GradofaBc8KCK7X4MasQil9de5JslI=;
        b=lPJLxVY0KWStdCxjJhwglOZYKrRNJ3YfqOJV4szZ2gM9fxPeob9kVfzE7F6aC9+Ii8
         q+PHG2rPYh1TIOFrtVqU6VVmCRy0M+mZeiXunloPEvZ3kzxLtHItLNlncFyvT3Za6wUF
         rCBfYV+l+1yLhF4MPYffLKmYrh0Y0SgQ1t8s7R7Ywbkm+YNdyNazlIdSu/rF9D1LeHoc
         SgtLDS0jmfssyO92Ma8W+OgTd6eQHT6oReutJBAJ/vHJYkdsnDjB5UEIBXijIPT305Cf
         9BVxK+R5cDhCLLLcjnIkRAaN2wnIpBGsjq58xyuPkqV/acqsgbWG27VUrEEQ5wjuPOVI
         fVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=W1x0avN4vzlS8GradofaBc8KCK7X4MasQil9de5JslI=;
        b=Icq3vjewumyWdr4ksqbUsvL7xvDnU1z6oQdtMZkRtk+O/7bKL0RRnAF1tfYEySQh6e
         6uvDQTkPeyRMg85zIlPb4QBeCbJx92mQ++NJ2/bMwQCjtSwtRLIfloI3C6jMSNN7YPCo
         GEthwNc+ULDS8KEpVt9amu3UPUhKCcKjqt6S+LLcXGKReNH97fY7ZyWYRY7FFMKPmBDM
         tQCOjzzTysSPeivBEmQHLcNo0kSzZaLs8Aic0SafQYAezbQgsvJax4ETv9gx1UZ+8oqT
         B8edJMBunJid/PGHhSjA+l2d//STn1Ain/UhBrbtDKf/KdFupb43qVCu7BlHJ0phWxrc
         HM6w==
X-Gm-Message-State: ALoCoQmFkdj6LTUdFss5vkHh2sGt6kAZQCVroz/i/+bBpTFnFlkiKvgerRsx3GmXO6pB2ndN3kmo
X-Received: by 10.50.56.82 with SMTP id y18mr32702528igp.25.1424935875566;
 Wed, 25 Feb 2015 23:31:15 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Wed, 25 Feb 2015 23:31:15 -0800 (PST)
In-Reply-To: <xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264424>

On Wed, Feb 25, 2015 at 10:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Feb 25, 2015 at 6:37 AM, Stefan Beller <sbeller@google.com> wrote:
>>> I can understand, that we maybe want to just provide one generic
>>> "version 2" of the protocol which is an allrounder not doing bad in
>>> all of these aspects, but I can see usecases of having the desire to
>>> replace the wire protocol by your own implementation. To do so
>>> we could try to offer an API which makes implementing a new
>>> protocol somewhat easy. The current state of affairs is not providing
>>> this flexibility.
>>
>> I think we are quite flexible after initial ref advertisement.
>
> Yes, that is exactly where my "I am not convinced" comes from.
>

We are not. (not really at least). We can tune some parameters or
change the behavior slightly,
but we cannot fix core assumptions made when creating v2 protocol.
This you can see when when talking about v1 as well: we cannot fix any
wrongdoings of v1 now by adding another capability. So from my point
of view we don't waste resources when having an advertisement of
possible protocols instead of a boolean flag indicating v2 is
supported. There is really not much overhead in coding nor bytes
exchanged on the wire, so why not accept stuff that comes for free
(nearly) ?

I mean how do we know all the core assumptions made for v2 hold in the
future? We don't. That's why I'd propose a plain and easy exchange at
first stating the version to talk.

Anyway what is the cost of a round trip time compared to the bytes on
the wire? Usually the cost of bytes on the wire correlate with the
latency anyway. (think mobile metered compared to corporate setting
with low latency). That's why I'd rather optimize for used bandwidth
than round trip times, but that may be just my personal perception of
the internet. That's why I'd propose different protocols.

Thanks,
Stefan
