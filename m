From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 06 Jul 2015 11:06:08 -0700
Message-ID: <xmqq7fqd17qn.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-4-git-send-email-dborowitz@google.com>
	<xmqqfv578x87.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
	<xmqqzj3f7gde.fsf@gitster.dls.corp.google.com>
	<CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
	<xmqqegkl2qu2.fsf@gitster.dls.corp.google.com>
	<CAD0k6qRLu1d7Sa8aVrHtDCsJNtVXwzHBAyOmmUHmVAx7qHmOPg@mail.gmail.com>
	<xmqq615x2ph1.fsf@gitster.dls.corp.google.com>
	<CAD0k6qT8=xQb6MRcLkyvZBm0MRdQ0Z-8ojqghovdgeJQ2EBNEA@mail.gmail.com>
	<CAD0k6qQW3TbgXDsc2Wzid8RNyugumUbSu4KTzO21euO3y_OWGw@mail.gmail.com>
	<xmqqsi91197o.fsf@gitster.dls.corp.google.com>
	<CAD0k6qRGQyFxZ8+yqkzYff_k4ZjWPaegQbBphwXyfBtUOCCw6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 20:06:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAmW-00032k-MX
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 20:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbbGFSGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 14:06:12 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:32889 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbGFSGL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 14:06:11 -0400
Received: by igh16 with SMTP id 16so31859959igh.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Dn9WLDddAKbNHknc0SGAiINC6JUSwIB1wdVEpaRHzvQ=;
        b=BePRdyY7I6k7IcgzEyQLF4If/1hJxzso0OeX8PS4pJGRLsrCrtTMaCdBOQWTe1H/wH
         kiQVGmbv3y7BxkeZ17c6enqI/O7lNn9ikRbivHEvrXgWI+jLyH5FO3f/gwdipBN0TZGn
         /NIeOI6QAU7Ffcba+vsfOM+DMKY1BjJIeHgOOn9GB+RXgFJcXtM69GHZisE0TTbAeZT9
         FZXzIbDgt5ChwkqtFwyLlGeAOtIestX1jhprvsEdl9ZnpH4D265g/AgBOmuLPskZPuGH
         0IIifVk6rRI10H6togTZEhmhPyQILfcWjQGTKl2FxqfC9B+9EYj8GmE8d7jJJNETy71T
         hgIg==
X-Received: by 10.50.79.129 with SMTP id j1mr70003756igx.12.1436205970306;
        Mon, 06 Jul 2015 11:06:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id s5sm10146933igh.6.2015.07.06.11.06.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 11:06:09 -0700 (PDT)
In-Reply-To: <CAD0k6qRGQyFxZ8+yqkzYff_k4ZjWPaegQbBphwXyfBtUOCCw6g@mail.gmail.com>
	(Dave Borowitz's message of "Mon, 6 Jul 2015 13:38:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273444>

Dave Borowitz <dborowitz@google.com> writes:

> On Mon, Jul 6, 2015 at 1:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Dave Borowitz <dborowitz@google.com> writes:
>>
>>> Another way of looking at the problem with my assumptions is, I was
>>> assuming "pkt-line framing" was the same thing as "pkt-line header".
>>> You seem to be saying the definition of "pkt-line framing" is "header,
>>> and optional trailing newline".
>>
>> Yes.  I thought that was what "Server SHOULD terminate with LF;
>> client MUST NOT require it" in the existing text meant.
>
> Unfortunately, the existing text is littered with examples of
> "PKT-LINE(foo SP bar LF)". If we assume "PKT-LINE(...)" means "apply
> pkt-line framing to the [...]", then this strongly implies that
> "pkt-line framing" does _not_ include the trailing LF. (Or the logical
> but bizarre alternative reading that such an example might have _two_
> trailing LFs :)

Yes,  But I never viewed PKT-LINE() as an element that strictly
defines the grammar of the packet protocol ;-)

By clarifying that "sender SHOULD terminate with LF, receiver MUST
NOT require it" is the rule (and fixing the existing implementations
at places where they violate the "MUST NOT" part, which I think are
very small number of places), I think we can drop these LF (or LF?
for that matter) from all of the PKT-LINE() in the construction in
the pack-protocol.txt, which would be a very good thing to do.

The example in your sentence will become PKT-LINE(foo SP bar) and
the "there may be an LF at the end" would only be at one place, as a
part of the definition of PKT-LINE().
