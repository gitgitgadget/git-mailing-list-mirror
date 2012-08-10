From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 11:06:08 -0700
Message-ID: <CAD0k6qTnQ+b8e2wt4WZ2HhOdsKXzcMkGbUZBkbw2j6_mQdE9GA@mail.gmail.com>
References: <20120810075342.GA30072@sigill.intra.peff.net> <7vboiilpvs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 20:06:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sztba-0006gm-22
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 20:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758616Ab2HJSGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 14:06:30 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:46423 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab2HJSG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 14:06:29 -0400
Received: by ghrr11 with SMTP id r11so1891009ghr.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 11:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record;
        bh=HA8JdMIeB/ub8zxoxPu6JZpEi9z+Hf5dNeKr3GGG86M=;
        b=YVfCdex4YmRTlPvp8xD57csjzi+ZDYlQu4rzzJs6F4MwXRKIScwmMJDuljxKOLnWjl
         wjZ7qk9J7ZvcSLK/PKAUeHjd9hz9UTHnNfYOk4xU9EMVkjvZPG+yi5dmxTffb6xNKcGl
         r0ldLm6AKJLU6e3VS/SN7x1XnDzXHGs05dovDlllVlGpRMyMWVE4IbX0dduIsN4kFDYQ
         TnH8ItNC5hQnfo86jtNeR9B86I7DK8c/jN1chpln7mikTmfLvO8P3n2um1cB0kfJ93yG
         MFlDD8nkXdM8N02fpWbm2kEaGQckIWNYyWWKmWCqL/YZ9shZg7Pd/VrkktXVVT31DNBk
         A5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=HA8JdMIeB/ub8zxoxPu6JZpEi9z+Hf5dNeKr3GGG86M=;
        b=bKnGuKFjTdbYLPVZoI86bykywN6FX/Geftkb2R3SWdK4a+vDj+njvSI/MsC8asfZEB
         84z5bUwFmjuPFU4rI0Bb87i8d1dHG7aSjEFaWEeE4y9o9NhaGH+1x6WetNvpHWwQ1Wyh
         wKXZWuAK9aV0uVUujHJ5gyoBHy0Jt9e8sJ3cpwXpMQHHJDST1IX36mTKOkFEoZ5pSr4B
         wnNVSRKeMKuB20RBWGoJ1p9KPuOnE5nArl/vcE0HQYfxppjlEOIkBo+TI1X/aS0cl3Gu
         vzbePAZm7wxGuLdWtr7SKkHaJVs8PsXbBVIP07O4DC4twSnEW39AdcAPZM3xIVyCFfna
         Ub+A==
Received: by 10.50.104.163 with SMTP id gf3mr525565igb.69.1344621988638;
        Fri, 10 Aug 2012 11:06:28 -0700 (PDT)
Received: by 10.50.104.163 with SMTP id gf3mr525550igb.69.1344621988445; Fri,
 10 Aug 2012 11:06:28 -0700 (PDT)
Received: by 10.231.135.1 with HTTP; Fri, 10 Aug 2012 11:06:08 -0700 (PDT)
In-Reply-To: <7vboiilpvs.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQm8dKMKp+A0bL8AReRNnJ0yrN2AWdoZbzitbkEkq6odHTa6mVjUC4tQ8umOgxjLFU8g5KawHjBo8ae5T0V4qkzy/jmUs4MtJmna9/73eq2ftQNtxmtKMYSswaavLOE6PawqpvPoQFNr9ykqh36zxTntY5j59YuT1SElNRy3dJtP7H6bOXY15T01Enk7JngkjKa9uPBk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203241>

On Fri, Aug 10, 2012 at 8:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Ugh, the jk/version-string topic breaks fetching from Google Code. With
>> my patch, the client unconditionally sends an "agent=foo" capability,
>> but the server does not like seeing the unknown capability and ends the
>> connection (I'm guessing with some kind of internal exception, since it
>> spews "Internal server error" over the protocol channel).
>
> I asked the folks who run code.google.com and they are indeed seeing
> something like these in their logs:
>
>  >> Client asked for capability agent=git/1.7.12.rc2.79.g86c1702 that was not advertised.

FWIW, this error comes from Dulwich:
https://github.com/jelmer/dulwich/blob/25250c1694dac343d469742aeafa139f37fc4ec6/dulwich/server.py#L196

So any servers running Dulwich would be affected by this...though I'm
not aware of any large-scale Dulwich installations other than Google
Code.

> So please consider your conjecture confirmed, and thanks for a
> prompt fix.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
