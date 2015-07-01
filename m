From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Wed, 1 Jul 2015 13:07:11 -0700
Message-ID: <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 22:07:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAOID-0000pM-3c
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 22:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbbGAUHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 16:07:33 -0400
Received: from mail-vn0-f49.google.com ([209.85.216.49]:35257 "EHLO
	mail-vn0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbbGAUHb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 16:07:31 -0400
Received: by vnbg190 with SMTP id g190so8251554vnb.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=U1xVYj1KzxdrhGSXhNq2uj25pHPYS5boc2T4nh1TYuI=;
        b=kMroY9rIyo4PLbV/m06ZNSmYfd8qaAznY9LCON/iklI08e0TJ7rP28GP+7l3w+o0n+
         Z8yvcFyn53J6rLitquBj/x7holtiNIV/UucmrO5HIWtUFTStJauR0sTN/PNOmeEdE/f2
         VdgkK6E0616N5Z2piDKqPvLIFSNgSScACR3RQ7Opa/z/ntXlyMM9VeHtJoWJJhmrHzkq
         l0zRVO/u4veR8LgDYqgtZpx4Gh62JndtzSS6C4e5X2mJkG7mIknzhWTQVv1Q0EolM4+U
         YeAh+s/kUsd7J3oOWCVsl8L9NQO8bLMekAzLReGpZ+UKXC7j0Weygyj3BrNqVtrWQs+6
         WYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=U1xVYj1KzxdrhGSXhNq2uj25pHPYS5boc2T4nh1TYuI=;
        b=W4eV21osv/JmMNbTKkWNsYpNu1t6Vwa6wOGcYuTv1DQTuQerZ0GCdmeMqiOvBt8/oD
         jJEiuIiUrxxh9MZN77aDdP+9jRPFa6LljPtNdp6aQ8up6AhmVlKaGKQmBbjQ0zPrlm2t
         lJTTVQIZKmNCdy9gwRt4U/V+TUvcrp6WqYUMJAaQu0ETUum37wG8hTrROXgPwsvF7v6A
         K4D2HmQjTaJXa5uMWGYrfagXOS/lIn3ioKaKTgTQe9v8Z3ezgYPD9yEHJdABzXAfh74w
         5+0xGMGnu2kUPTxy9YG/LO11lPERKpe87e11bq3/Yoxde44IEAVUTZjoXhcf6RsRs3HR
         Knhw==
X-Gm-Message-State: ALoCoQl5soenCbLmOlqk3BrKKs7XFefN+EkmZGWzP3ntB3U8zULdQ8YVhyebkUGcwHsMXwlbO7c3
X-Received: by 10.52.32.34 with SMTP id f2mr27427365vdi.11.1435781250683; Wed,
 01 Jul 2015 13:07:30 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Wed, 1 Jul 2015 13:07:11 -0700 (PDT)
In-Reply-To: <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273195>

On Wed, Jul 1, 2015 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> Signed-off-by: Dave Borowitz <dborowitz@google.com>
>> ---
>>  Documentation/technical/pack-protocol.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/technical/pack-protocol.txt
>> b/Documentation/technical/pack-protocol.txt
>> index 1386840..2d8b1a1 100644
>> --- a/Documentation/technical/pack-protocol.txt
>> +++ b/Documentation/technical/pack-protocol.txt
>> @@ -534,6 +534,9 @@ A push certificate begins with a set of header
>> lines.  After the
>>  header and an empty line, the protocol commands follow, one per
>>  line.
>>
>> +Note that (unlike other portions of the protocol), all LFs in the
>> +`push-cert` specification above MUST be present.
>> +
>>  Currently, the following header fields are defined:
>>
>>  `pusher` ident::
>
> I am moderately negative about this; wouldn't it make the end result
> cleaner to fix the implementation?

I'm not sure I understand your suggestion. Are you saying, you would
prefer to make LFs optional in the push cert, for consistency with LFs
being optional elsewhere?

C git servers in the wild already require LFs when extracting the
nonce value from the certificate (see find_header). If we make the LFs
optional, then a conforming client may not send LFs, which will cause
nonce verification to fail when pushing to an unfixed server. That is
why I think we are stuck with this.

(Also, this is probably not insurmountable, but the cert processing
code in receive-pack.c would have to be substantially rewritten if we
loosened this requirement. Currently it concatenates the cert contents
without pkt-line framing into a buffer, and searches around for "\n"
and "\n\n".

If LF is optional, then with that approach you might end up with a
section of that buffer like:
  nonce 1234-abcd0000000000000000000000000000000000000000
deadbeefdeadbeefdeadbeefdeadbeefdeadbeef refs/heads/master
where it is impossible to distinguish between the end of the nonce and
the start of the first command.)
