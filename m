From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: Fwd: possible Improving diff algoritm
Date: Wed, 12 Dec 2012 16:40:32 -0500
Message-ID: <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
	<CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
	<7vvcc73yzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kevin <ikke@ikke.info>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 22:40:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiu2y-0004ak-EP
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 22:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279Ab2LLVkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 16:40:35 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65487 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab2LLVke (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 16:40:34 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so1132241lbb.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 13:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AmaWgt+SzFc0wYkFWoFAgYYKqKAaJ8LsAWguH/b/Mhs=;
        b=mVdWJw9Sog8PAjANiVMXsK644pDJGWiLrklGnjhn09FgBJ1ZReBvFGtOX83lawolGF
         RDB9BGWrlCfyH77qZRUXjuoOGezWikcC4XsEOpaMSDFhWlgr49B/Jit9Ujzk0KkhKLBH
         2FhbqYbflLwnH5DRmwvd5G7Rnh5u3ASSz1/lRqZn1mfZUeab1A1Q7w/emKfAV8gOJXUP
         ls4dAERWK3qJbqzOoK5YobO/lHeDdwNbrMlE5uXsKwtl1iTrTtj7ylbjNUUgsw8zKIZO
         +sJ3DFafYxWG+OHtXuCx8xfuJfqM9yp96k55rba+WsGDIcrlFnn8ucub10uVe10GUNNG
         Vc5Q==
Received: by 10.152.106.212 with SMTP id gw20mr2491015lab.8.1355348432689;
 Wed, 12 Dec 2012 13:40:32 -0800 (PST)
Received: by 10.112.29.195 with HTTP; Wed, 12 Dec 2012 13:40:32 -0800 (PST)
In-Reply-To: <7vvcc73yzh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211395>

> So I think with s/Regularly/About half the time/, your observation
> above is correct.
>
> I think the reason you perceived this as "Regularly" is that you do
> not notice nor appreciate it when things go right (half the time),
> but you tend to notice and remember only when a wrong side happened
> to have been picked (the other half).

Is there a reason why picking among the choices in a sliding window
must be contents neutral?

I see these "illogical" (== stylistically not matching user intent) diffs
quite often.  C comments (as in the example given) and #ifdef blocks
are typical cases.

Purely anecdotically, I have seen more trouble applying "illogical"
diffs than I would have expected from the corresponding "logical" diffs.

Morten
