From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 6 Jul 2015 13:18:02 -0400
Message-ID: <CAD0k6qQW3TbgXDsc2Wzid8RNyugumUbSu4KTzO21euO3y_OWGw@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
 <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com> <CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
 <xmqqegkl2qu2.fsf@gitster.dls.corp.google.com> <CAD0k6qRLu1d7Sa8aVrHtDCsJNtVXwzHBAyOmmUHmVAx7qHmOPg@mail.gmail.com>
 <xmqq615x2ph1.fsf@gitster.dls.corp.google.com> <CAD0k6qT8=xQb6MRcLkyvZBm0MRdQ0Z-8ojqghovdgeJQ2EBNEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 19:18:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCA2J-0007t8-5H
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbbGFRS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:18:26 -0400
Received: from mail-vn0-f53.google.com ([209.85.216.53]:42962 "EHLO
	mail-vn0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbbGFRSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:18:25 -0400
Received: by vnbf62 with SMTP id f62so24199971vnb.9
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3Ky0FGxvpVi/kfF8RV374+0qukA6KGGqjb/iuVzCVDI=;
        b=MhEYwv22i/7Bye4bzVZSK1Od8dME6rLvLyd1HLaRl/FU3KkTXwJZYDGTfoAAeIEsDz
         jCBYO6v5THWzXUZuXscBTE0tlRYqsbu9Jc1HRF+lDhxre5fhwpWwK3RrRtfoyDk8ntHF
         jKFfVSnn1bDISdbLVZYslFDMeb51z81Ou3CMuluGtu1B1AinOeT7kYEAEfBDvxZ1w7hK
         Tz4B2jYYVuJngXQD9rHmfQ7vy1mteVapzBs9tCz3SNEOlnfirRZs8dTdXs5BcJ+rrFPo
         RswpyuW+RedVg4PB6Ajre0gHTBnSZ1jc1oWkzEpjcmxaih4O3LRWYT4YPZyv9FuNw4F9
         1QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=3Ky0FGxvpVi/kfF8RV374+0qukA6KGGqjb/iuVzCVDI=;
        b=MBIN2V8ICO9faFdSE4MH2xh4WhEPTqFBnx0KpEymYQNHfCgWUrGxS31pI+ldt1I86p
         oBEewUMMViMUSqBQsYGkrJ2CYS3h4ELoff/4ToQhgV6oLqdF6FUy5kWHgzFaLGD5aqKd
         G23T4s35ysk1iAJjDH8K3HG7UApqFw+h0IR2q+YiSHjQe1BN64kYFWvOx8oEv7BOUxd8
         1RN6v5tNOaB8Byjl+TS5XKalKIVhhkaQgJcMAe6Zp4szq7pSqqQ78mqot8X31z47BiJJ
         COgk5NUstt+xugNJFpqwd9Njw84AFfF3i8RD05VxC6rEjypBesexQnA2bkPUGUa/sJNX
         yN7w==
X-Gm-Message-State: ALoCoQkKQIrfJxeUs9u3VU1yEFbxMHEhLVBipWx6/gu3N+XwVqcuAKmMUpjSWXfyq+qWYFIQbENu
X-Received: by 10.52.188.137 with SMTP id ga9mr51003079vdc.30.1436203104760;
 Mon, 06 Jul 2015 10:18:24 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Mon, 6 Jul 2015 10:18:02 -0700 (PDT)
In-Reply-To: <CAD0k6qT8=xQb6MRcLkyvZBm0MRdQ0Z-8ojqghovdgeJQ2EBNEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273410>

On Mon, Jul 6, 2015 at 1:11 PM, Dave Borowitz <dborowitz@google.com> wrote:
> On Mon, Jul 6, 2015 at 12:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Dave Borowitz <dborowitz@google.com> writes:
>>
>>> The server can munge pkt-lines and reinsert LFs, but it _must_ have
>>> some way of reconstructing the payload that the client signed in order
>>> to verify the signature. If we just naively insert LFs where missing,
>>> we lose the ability to verify the signature.
>>
>> I still do not understand this part.
>>
>> There is no way to "naively" insert, is there?  You have an array of
>> lines (each of which you have already stripped its terminating LF at
>> its end).  How else other than adding one LF at the end of each
>> element do you reconstruct the original multi-line string the client
>> signed?  Are there other ways that makes the result ambiguous??
>
> I think I understand the confusion now. I think you and I are working
> from different assumptions about the client behavior.
>
> My assumption was: the intended behavior for the client is to sign the
> exact payload that was sent over the wire, minus pkt-line headers.
>
> For example, under my assumption, if the client sent:
>
> 0008foo\n
> 0007bar
> 0008baz\n
>
> then this indicates the client signed:
>
> "foo\nbarbaz\n"
>
> Under this assumption, "naively inserting LF" means inserting an LF
> after "bar". Thus the server would record the following in a
> persistent store:
>
> "foo\nbar\nbaz\n"
>
> If we only store this string, and do not remember the fact that the
> client originally omitted one of those LFs, then when we go back to
> verify that signature later, it will fail.
>
> That was my assumption.
>
> Your assumption, IIUC, is that the payload the client signed MUST have
> contained LFs in between each line. When framing the content for the
> wire, the client MUST send one "logical line", which has no trailing
> LF, per pkt-line, and furthermore the pkt-line content MAY contain an
> additional trailing LF.
>
> Under your assumption, the server always has enough information to
> reconstruct the original signed payload.
>
>
> The problem with the documentation, then, is that the documentation
> does not say anything to indicate that the signed payload is anything
> other than what is on the wire.

Another way of looking at the problem with my assumptions is, I was
assuming "pkt-line framing" was the same thing as "pkt-line header".
You seem to be saying the definition of "pkt-line framing" is "header,
and optional trailing newline".

A quick scan of pack-protocol.txt did not turn up anything one way or
the other on this issue, so perhaps we could make it more explicit.
The additional upside here is that we could then potentially remove
all or almost all LFs from this document.

> So maybe this series should include an explicit description of the
> singed payload outside of the context of a push. Then, in the push
> section, we can describe the set of transformations that the client
> MUST perform (splitting on LF; adding pkt-line headers) and MAY
> perform (adding LFs).
>
>>> If we say the payload the client signs MUST have LFs only in certain
>>> places, then that gives the server enough information to reconstruct
>>> the payload and verify the signature.
>>>
>>> But if we say the signed payload MUST have LFs and the wire payload
>>> MAY have LFs, then now we have two completely different formats, only
>>> one of which is documented.
>>
>> I thought that was what I was saying.  The wire protocol sends the
>> contents of each line (both what is signed and the signature) on a
>> separate packet.  When I say "contents of a line", I do not include
>> the terminating LF as part of the line (iow, LF is not even
>> optional; the terminating LF is not considered as part of "the
>> contents of a line").  It becomes irrelevant that a pkt-line may or
>> may not have a trailing optional LF.  If there is LF at the end of a
>> packet between "push-cert" and "push-cert-end" packets, that LF by
>> definition cannot be part of the "contents of a line" in a
>> certificate.
>>
>> It is just a pkt-line framing artifact you can and should remove if
>> you are doing a "split to array, join with LF" implementation to
>> recover the original string.
>>
>> And that is very much consistent with the way we send other things
>> with pkt-line protocol.  Each packet up to the first flush is
>> expected to have <object name> and <refname> as ref advertisement.
>> The pkt-line framing may or may not add a trailing LF, but LF is not
>> part of <refname>.  It is not even part of the payload; merely an
>> artifact of pkt-line framing.
