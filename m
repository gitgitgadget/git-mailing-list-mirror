From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 6 Jul 2015 14:08:21 -0400
Message-ID: <CAD0k6qQH1t2QzjQydjqzse+caib4Z+yCtJd9eDy=hBukxLKMhQ@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
 <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com> <CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
 <xmqqegkl2qu2.fsf@gitster.dls.corp.google.com> <CAD0k6qRLu1d7Sa8aVrHtDCsJNtVXwzHBAyOmmUHmVAx7qHmOPg@mail.gmail.com>
 <xmqq615x2ph1.fsf@gitster.dls.corp.google.com> <CAD0k6qT8=xQb6MRcLkyvZBm0MRdQ0Z-8ojqghovdgeJQ2EBNEA@mail.gmail.com>
 <CAD0k6qQW3TbgXDsc2Wzid8RNyugumUbSu4KTzO21euO3y_OWGw@mail.gmail.com>
 <xmqqsi91197o.fsf@gitster.dls.corp.google.com> <CAD0k6qRGQyFxZ8+yqkzYff_k4ZjWPaegQbBphwXyfBtUOCCw6g@mail.gmail.com>
 <xmqq7fqd17qn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 20:09:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCApq-00054Y-Tr
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 20:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbbGFSJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 14:09:38 -0400
Received: from mail-vn0-f47.google.com ([209.85.216.47]:44611 "EHLO
	mail-vn0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbGFSJh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 14:09:37 -0400
Received: by vnbg129 with SMTP id g129so17957684vnb.11
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OTv00y8aqlKnqAxom3pGlWuzvIUNOC5nak+e88fauBk=;
        b=N3heOl86yNrPT+FElC8QfyIV1Wg8BQddMsqIs0cf591x/qwCsTp9BfDb8Asn98F01K
         rSzIIDiPJSch4EhBtLoksSRc7SYI5fvFCfL5Lf7yn0qHHqODiPwMphv75bZfFf+GYinJ
         p3CT4n5HwERx/RmV2ipI1slEV7rzQLChYvybVsAxxiwwA+3I+5WR5NM23cHLphPVNP3k
         0zxKx+7mJi7+PGUqbHWFcC++3cjfkyad7bZrN06MPXvyunWGCQKwW4WVeaQuAqHQzWJz
         L64A/lTskrNGqza/mPzMZ2+ol3n5k1A1rvSY8q66DXEfWED7HwI1GNElqeEQKB+KgACQ
         KmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=OTv00y8aqlKnqAxom3pGlWuzvIUNOC5nak+e88fauBk=;
        b=Eue7+4rLADAQtop+RknJsfj6X5Kd24WxmM6GM0aANklvaA/7OXdlpPijPeBzs1xeWr
         6PeUE/vE2bgGUbCvdcK2oz9wdEuRWnSjrobmsGmz7SebPteHGAM5ofIBhc4FtRFokhNG
         SukK2vZ3l0jtVRsdIaFr97KxG0+1n5DoMWFyMXK/4yrtxKu0wT48MBJgcZ2bWCIAv1Dt
         MuvVx/WlXESJOK/KIlOITOKJeUPmOtv5Z0+gDTfr0S72GOEIzH3A6SITcIv2Gjs/2tGb
         7n130dj/lkWA6B/RgQAyCPi0pF4yx4h51P8JzsAml3DBJfuv6F0yyDBELbfrhfpJophY
         IYxw==
X-Gm-Message-State: ALoCoQkZyW5pn5EZ3zpIqIXJoa4ya37wr5y09D2tDN5TDg7bO3awiHW6hpTjSgnDgLxa4deBrqWc
X-Received: by 10.52.52.114 with SMTP id s18mr176191vdo.9.1436206176490; Mon,
 06 Jul 2015 11:09:36 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Mon, 6 Jul 2015 11:08:21 -0700 (PDT)
In-Reply-To: <xmqq7fqd17qn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273445>

On Mon, Jul 6, 2015 at 2:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> On Mon, Jul 6, 2015 at 1:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Dave Borowitz <dborowitz@google.com> writes:
>>>
>>>> Another way of looking at the problem with my assumptions is, I was
>>>> assuming "pkt-line framing" was the same thing as "pkt-line header".
>>>> You seem to be saying the definition of "pkt-line framing" is "header,
>>>> and optional trailing newline".
>>>
>>> Yes.  I thought that was what "Server SHOULD terminate with LF;
>>> client MUST NOT require it" in the existing text meant.
>>
>> Unfortunately, the existing text is littered with examples of
>> "PKT-LINE(foo SP bar LF)". If we assume "PKT-LINE(...)" means "apply
>> pkt-line framing to the [...]", then this strongly implies that
>> "pkt-line framing" does _not_ include the trailing LF. (Or the logical
>> but bizarre alternative reading that such an example might have _two_
>> trailing LFs :)
>
> Yes,  But I never viewed PKT-LINE() as an element that strictly
> defines the grammar of the packet protocol ;-)
>
> By clarifying that "sender SHOULD terminate with LF, receiver MUST
> NOT require it" is the rule (and fixing the existing implementations
> at places where they violate the "MUST NOT" part, which I think are
> very small number of places), I think we can drop these LF (or LF?
> for that matter) from all of the PKT-LINE() in the construction in
> the pack-protocol.txt, which would be a very good thing to do.

Completely agree, and that is what I meant when I said "The additional
upside [to explicitly defining pkt-line framing in this way] is that
we could then potentially remove all or almost all LFs from this
document."

> The example in your sentence will become PKT-LINE(foo SP bar) and
> the "there may be an LF at the end" would only be at one place, as a
> part of the definition of PKT-LINE().
