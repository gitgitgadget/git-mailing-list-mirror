From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 6 Jul 2015 12:38:20 -0400
Message-ID: <CAD0k6qRLu1d7Sa8aVrHtDCsJNtVXwzHBAyOmmUHmVAx7qHmOPg@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
 <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com> <CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
 <xmqqegkl2qu2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 18:38:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC9Q2-0000FK-1N
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 18:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbbGFQip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 12:38:45 -0400
Received: from mail-vn0-f52.google.com ([209.85.216.52]:44262 "EHLO
	mail-vn0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999AbbGFQil (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 12:38:41 -0400
Received: by vnbg129 with SMTP id g129so17655295vnb.11
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=k/gOHqkHils9Jwa6hdEj2ENiGtmZR2nAnlOAehyUP50=;
        b=NGdMNACpemdS5ZShLFVA8Ju2G+IaU6DVHbXU1UUSu2hm8OVSESlTKWbpBynO+M+tcS
         CfK3obcu7VydhdvlUqqaV9jif2UbiwkFvnfhuQYII2CGR5dy9eUj9h2hfBpy8kIgCEi1
         oEjza252QlmqR9HLPR3y5lKj5bDXTxRFig0GTKTguZF7EjCv+ssU/t1yCMpsEQjTDkXa
         eTl3rmPJiH8ZuGH3TAtWSS+LWN2iduz++6gqwTrMUjfKPZtzHqupGE3dbKaD1pr8DqB5
         MhlZdjaMf+cwv/7kKDAR/eUHflESaFjQ3DDcb7a+T/Sqa5blC5mcFzZ+ffPeJd+/oIdG
         IUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=k/gOHqkHils9Jwa6hdEj2ENiGtmZR2nAnlOAehyUP50=;
        b=TruW5avL/q1g8Ug76o5HYHjuTSPnqQaMPTmqzW0K1Yoh6X4lIJyQ2X1GpFCx7EQPeY
         LLJfk++CAT257JDWK8EMiuyH7u00CutePjMVIOm9fokSKZZhQePPE2y6CGc/gt1HI+Dw
         oIvw/YDKrXnS3qV1BVl/e0glG2BlzzdtsNf678QIRUTGfbH/FfuIZ83Z6qoK0nQyIFJS
         thSfSdBf8+gfC64xXGcNsf0tzZtS7dQ6hSxQTUHehUU1jw0dH38C1b+9gIrgqQfL2cDC
         71DfGwVrCKsrga+iIeFXX+Q1gy1cIIE9aYS9z2CAnuzLjQZJaOuKPxXNPcJ/41lXTkP3
         fZ3A==
X-Gm-Message-State: ALoCoQnP73r4+B8jxDCVLr6VbOAXrJTLpq/geaDZf5JIfkHOjneYpm4waGBVJZfzrwo+V9y5PkvL
X-Received: by 10.52.251.107 with SMTP id zj11mr50909940vdc.96.1436200720224;
 Mon, 06 Jul 2015 09:38:40 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Mon, 6 Jul 2015 09:38:20 -0700 (PDT)
In-Reply-To: <xmqqegkl2qu2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273403>

On Mon, Jul 6, 2015 at 12:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> push cert format is like commit or tag format. You need those LFs. We
>> can't just go declare them optional because of the way pkt-line read
>> function is implemented in git-core.
>
> As I said, I view each of the packets between "push-cert" and
> "push-cert-end" packets representing the meat of each line in the
> cert.  The sending end takes a cert as a long multi-line string,
> splits them into an array, each of whose element represents a line
> in it (iow "certlines = certstring.split('\n')"), and sends them
> packetised.

Right now the sending end sends newlines.

> The receiver receives a sequence of packets, notices "push-cert"
> packet, collects packets until it sees "push-cert-end" packet and
> treats them as elements of this array.  pkt-line deframing process
> would have to strip optional LFs to reconstruct the original array
> the sender had (i.e. the above certlines array).

The problem is the signature. Today, the client computes the signature
over the payload it actually sends (minus pkt-line headers)

The server can munge pkt-lines and reinsert LFs, but it _must_ have
some way of reconstructing the payload that the client signed in order
to verify the signature. If we just naively insert LFs where missing,
we lose the ability to verify the signature.

If we say the payload the client signs MUST have LFs only in certain
places, then that gives the server enough information to reconstruct
the payload and verify the signature.

But if we say the signed payload MUST have LFs and the wire payload
MAY have LFs, then now we have two completely different formats, only
one of which is documented.

> The receiver needs to join the array with LF to recover the long
> multi-line string once it received the array.  But this LF does not
> have anything to do with the optional trailing LF in pkt-line.  If
> you sent the original "certlines" array via different RPC mechanism,
> you need to join them together with your own LF to reconstruct the
> multi-line string.
>
