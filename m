From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 6 Jul 2015 13:11:45 -0400
Message-ID: <CAD0k6qT8=xQb6MRcLkyvZBm0MRdQ0Z-8ojqghovdgeJQ2EBNEA@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
 <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com> <CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
 <xmqqegkl2qu2.fsf@gitster.dls.corp.google.com> <CAD0k6qRLu1d7Sa8aVrHtDCsJNtVXwzHBAyOmmUHmVAx7qHmOPg@mail.gmail.com>
 <xmqq615x2ph1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 19:12:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC9wD-0003wX-BH
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbbGFRMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:12:09 -0400
Received: from mail-vn0-f50.google.com ([209.85.216.50]:34030 "EHLO
	mail-vn0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbbGFRMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:12:06 -0400
Received: by vnbf7 with SMTP id f7so17737767vnb.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dzTZ4+iXbcqEwiLGrGH6PSnIAkmbc7orBuhPnK38zro=;
        b=lp1IKevvsFn31Waiy2EX/wYZQLS5obIk0LBc4W+IK/nNv8MVlpUnSQxZ5YaiI8dhQA
         yu39BA+EbwcMue6hikumrAAm6qDdHyhwUJevOAYQa3MVwV0hSKGJ8Xtz9Pebxrla/Ew8
         8m9mB9zRP9F4o1XiTtlvHF2lyOzNVrGgckL4Q/9RUBFOHrMCOeAoi2vvWgDxInsEU0a6
         e5FYKb58NyWb75NxdBrTi9RdsSY6fNakvDdkknUjQWdqk7EYseUtk1H0BxpTPetnlMcf
         BdZm3anarRel/zaxhde2K2Lp4HdL9ZesdaM+1Q9nprBxrXRqGhZCYJ0vvNvd9E8o3s9z
         0W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=dzTZ4+iXbcqEwiLGrGH6PSnIAkmbc7orBuhPnK38zro=;
        b=CwW/LpShKVQwngIw7RZqTBX746jan/XL7i4plk53Gjo87j476jMFG8JZyKnWUFEED2
         KuTGa448DjN9Q2hr3IBvvggtIMF9GVZ3xKmxDK7SMTTkXHVq81kCvqwXDI2qG7rEOakQ
         HTWGkgM29vH0Gr9RSWR3jkob50URw1/si/XS5aYmv7rW6T6CHXq6zctXH9etwtcKHB+S
         IUaF7agWF/Ntmze7omkLY7Ns8CGiVYaYIkV9M8NSDFvpnmypbUGKdwSY0KcS/BZdc1R+
         oeJwYQM0wIEDKUFY4WELL2RpF/5wiEbabSN9vPguC/vj9xh2YLsWQumkeLUKSW32RQ3y
         SAVQ==
X-Gm-Message-State: ALoCoQmGgcH5pgqGHPo+0EpZrXMHpvTImsqKTeoRh7dSHJ0gWMQhwulJP5t6dXrj0BscO19wZKsK
X-Received: by 10.52.6.8 with SMTP id w8mr50863707vdw.85.1436202725027; Mon,
 06 Jul 2015 10:12:05 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Mon, 6 Jul 2015 10:11:45 -0700 (PDT)
In-Reply-To: <xmqq615x2ph1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273407>

On Mon, Jul 6, 2015 at 12:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> The server can munge pkt-lines and reinsert LFs, but it _must_ have
>> some way of reconstructing the payload that the client signed in order
>> to verify the signature. If we just naively insert LFs where missing,
>> we lose the ability to verify the signature.
>
> I still do not understand this part.
>
> There is no way to "naively" insert, is there?  You have an array of
> lines (each of which you have already stripped its terminating LF at
> its end).  How else other than adding one LF at the end of each
> element do you reconstruct the original multi-line string the client
> signed?  Are there other ways that makes the result ambiguous??

I think I understand the confusion now. I think you and I are working
from different assumptions about the client behavior.

My assumption was: the intended behavior for the client is to sign the
exact payload that was sent over the wire, minus pkt-line headers.

For example, under my assumption, if the client sent:

0008foo\n
0007bar
0008baz\n

then this indicates the client signed:

"foo\nbarbaz\n"

Under this assumption, "naively inserting LF" means inserting an LF
after "bar". Thus the server would record the following in a
persistent store:

"foo\nbar\nbaz\n"

If we only store this string, and do not remember the fact that the
client originally omitted one of those LFs, then when we go back to
verify that signature later, it will fail.

That was my assumption.

Your assumption, IIUC, is that the payload the client signed MUST have
contained LFs in between each line. When framing the content for the
wire, the client MUST send one "logical line", which has no trailing
LF, per pkt-line, and furthermore the pkt-line content MAY contain an
additional trailing LF.

Under your assumption, the server always has enough information to
reconstruct the original signed payload.


The problem with the documentation, then, is that the documentation
does not say anything to indicate that the signed payload is anything
other than what is on the wire.

So maybe this series should include an explicit description of the
singed payload outside of the context of a push. Then, in the push
section, we can describe the set of transformations that the client
MUST perform (splitting on LF; adding pkt-line headers) and MAY
perform (adding LFs).

>> If we say the payload the client signs MUST have LFs only in certain
>> places, then that gives the server enough information to reconstruct
>> the payload and verify the signature.
>>
>> But if we say the signed payload MUST have LFs and the wire payload
>> MAY have LFs, then now we have two completely different formats, only
>> one of which is documented.
>
> I thought that was what I was saying.  The wire protocol sends the
> contents of each line (both what is signed and the signature) on a
> separate packet.  When I say "contents of a line", I do not include
> the terminating LF as part of the line (iow, LF is not even
> optional; the terminating LF is not considered as part of "the
> contents of a line").  It becomes irrelevant that a pkt-line may or
> may not have a trailing optional LF.  If there is LF at the end of a
> packet between "push-cert" and "push-cert-end" packets, that LF by
> definition cannot be part of the "contents of a line" in a
> certificate.
>
> It is just a pkt-line framing artifact you can and should remove if
> you are doing a "split to array, join with LF" implementation to
> recover the original string.
>
> And that is very much consistent with the way we send other things
> with pkt-line protocol.  Each packet up to the first flush is
> expected to have <object name> and <refname> as ref advertisement.
> The pkt-line framing may or may not add a trailing LF, but LF is not
> part of <refname>.  It is not even part of the payload; merely an
> artifact of pkt-line framing.
