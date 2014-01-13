From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Create HTML for technical/http-protocol.txt
Date: Mon, 13 Jan 2014 10:40:05 -0800
Message-ID: <xmqq38kr7mka.fsf@gitster.dls.corp.google.com>
References: <196469122.1795615.1389439169514.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Jan 13 19:40:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2mQw-00032U-9N
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 19:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbaAMSkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 13:40:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbaAMSkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 13:40:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5332620DA;
	Mon, 13 Jan 2014 13:40:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pjC2hhAl0U3WedDGTpKyMTptcXs=; b=dbVpDU
	jdehdyFqosz4Sd6NlwY5OkaH5JYxLFqdE1R1GkgmQyvEbwVH1LPkS37EoVy7i2Y+
	tQoxmFadG7YsTDS23lDxLOrYiMZKHf3SwEi0tgyJSqODw09KQ7BiOwmMgFAgL3GE
	4ceSkbuxKifTZm8Jtqwi0mQAc3xJoTZFQ3s88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xbGAWeyktv2QkcsoU7xsb1sDCd6mkSTQ
	q+bvmdk1LBt2JdOTrVC2lmXfpEPc/aKqwssjFAqG8SeWv9ean+ClovLGZCl9qvJd
	AxWB7CSeekJWoT6vNGVewmDksxaXH9X/FPpaQlcjCJwMb+yKVDNE7v+pQ2iLHB8R
	PjwhkJwREAY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95F91620D9;
	Mon, 13 Jan 2014 13:40:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF8FF620D7;
	Mon, 13 Jan 2014 13:40:10 -0500 (EST)
In-Reply-To: <196469122.1795615.1389439169514.JavaMail.ngmail@webmail08.arcor-online.net>
	(Thomas Ackermann's message of "Sat, 11 Jan 2014 12:19:29 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 21F7CCCC-7C82-11E3-B785-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240366>

Thomas Ackermann <th.acker@arcor.de> writes:

> - Add to Documentation/Makefile
> - Start every TODO with a new line
> - Fix indentation error
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/Makefile                    | 1 +
>  Documentation/technical/http-protocol.txt | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 36c58fc..b4a4c82 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -70,6 +70,7 @@ TECH_DOCS += technical/racy-git
>  TECH_DOCS += technical/send-pack-pipeline
>  TECH_DOCS += technical/shallow
>  TECH_DOCS += technical/trivial-merge
> +TECH_DOCS += technical/http-protocol

The output from "ls Documentation/technical/[b-z]*.txt" tells me
that this patch makes the TECH_DOCS cover everything (in other
words, this is not "I was intereted in http-protocol.txt; I did not
bother checking if there are others that are not formatted.").

Which is good, but that is something you could have said at the very
beginning as the motivation (which cannot be read from the patch)
before going into details of what you did (which can be read in the
patch).

Also let's keep them in order and move the new line before the
index-format, as h comes before i.

>  SP_ARTICLES += $(TECH_DOCS)
>  SP_ARTICLES += technical/api-index
>  
> diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
> index d21d77d..c64a5e9 100644
> --- a/Documentation/technical/http-protocol.txt
> +++ b/Documentation/technical/http-protocol.txt
> @@ -332,6 +332,7 @@ server advertises capability "allow-tip-sha1-in-want".
>    have_list         =  *PKT-LINE("have" SP id LF)
>  
>  TODO: Document this further.
> +
>  TODO: Don't use uppercase for variable names below.
>
>  The Negotiation Algorithm
> @@ -376,10 +377,8 @@ The computation to select the minimal pack proceeds as follows
>  
>       Commands MUST appear in the following order, if they appear
>       at all in the request stream:
> -
>         * want
>         * have
> -
>       The stream is terminated by a pkt-line flush ("0000").
>  
>       A single "want" or "have" command MUST have one hex formatted

The resulting _source_ file read as txt becomes somewhat harder to
read with these changes.  Admittedly, it is mostly because the
original text was meant to be easy to read in TEXT, not to be
formatted via AsciiDoc into HTML.  We can see that in many places in
the formatted output with your patch.  For example:

 - Strings like "200 OK", "304 Not Modified", "HEAD" are italicized
   ("Discovering References" section); "GET" request is shown as
   Roman body text.  I think in our documentation it is customery to
   typeset these "as-is" things in monospaced.

 - "dumb server reply:", "smart server reply:" ("Smart Clients"
   section) are shown in monospace just like the actual protocol
   message examples that follow them, but we would most likely want
   to see them as part of the body text.

 - As all the descriptions of steps in the Negotiation Algorithm are
   indented, the AsciiDoc formatted result becomes just a series of
   fixed-font blocks around there.

So,... I think this patch may be a good first step, but it needs to
be followed by another that cleans up the mark-up in order for the
resulting HTML to be truly usable.

Thanks.
