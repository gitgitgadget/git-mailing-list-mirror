From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Wed, 09 Mar 2016 16:37:43 -0800
Message-ID: <xmqqd1r3f9rc.fsf@gitster.mtv.corp.google.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
	<20160304055117.GB26609@ikke.info>
	<1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
	<20160304115634.GC26609@ikke.info>
	<CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
	<xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
	<xmqqlh5ungct.fsf@gitster.mtv.corp.google.com>
	<xmqq8u1tmr6l.fsf@gitster.mtv.corp.google.com>
	<CACsJy8C5r2f76p3oq5oX_1P5Vqt9qd7TAafuKxJ=Y8baELbJog@mail.gmail.com>
	<xmqqbn6olu1w.fsf@gitster.mtv.corp.google.com>
	<CACsJy8AUs-DAo-GceO9ND9RPVeDOfm_UM4ZuaeNWDwBVMu+dnQ@mail.gmail.com>
	<xmqqk2lbil7k.fsf@gitster.mtv.corp.google.com>
	<CACsJy8D=OjLBN-EXyKM4NnGhSGftYX+RAaR9fg8ML3QWAAb+iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 01:37:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adobv-0003t7-7H
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 01:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934500AbcCJAhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 19:37:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933127AbcCJAhq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 19:37:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4809A4C87D;
	Wed,  9 Mar 2016 19:37:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gD+tAEfKVVbbMnxYjXke/mKbZDk=; b=q7ow12
	YLZaZ+PmN8bhAn/doqzeObpQFCv2UlLOVBn9nR2MzARMAIk6vT9D9GoniPkOU2O4
	ZGoSHW/hyWu9zawF72/ntLn03IKZZ0TiP7NEn6Ch355V6Eje7ey/bSnH2ezKOwRI
	gsRR6VMwEf97brRxGnm9L0lJ7Apww7k1Fx2rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TgNHtBbY2C+YktTYXz9RSiAyjhl/OXKx
	Po20u3upQJlGnZBuRrFWbsnEwQwuIFzXW0Ud/YqOdnAmdjWexmndXSGByudBAdWJ
	ark0CJDFiIyu7A6exGvdYSlvXqGa+bBqPOKRFBBZagaMC61uxZ7Qtr/Yhy3Uf2aG
	tQmudtGofHU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3EB694C87C;
	Wed,  9 Mar 2016 19:37:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B57D44C87B;
	Wed,  9 Mar 2016 19:37:44 -0500 (EST)
In-Reply-To: <CACsJy8D=OjLBN-EXyKM4NnGhSGftYX+RAaR9fg8ML3QWAAb+iQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 10 Mar 2016 07:26:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4E2A2370-E658-11E5-9838-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288590>

Duy Nguyen <pclouds@gmail.com> writes:

> A bit off topic, but these two paragraphs may need rephrasing, I don't
> really understand what it's trying to say
>
>  - If the pattern does not contain a slash '/', Git treats it as
>    a shell glob pattern and checks for a match against the
>    pathname relative to the location of the `.gitignore` file
>    (relative to the toplevel of the work tree if not from a
>    `.gitignore` file).
>
> Not sure why "relative to the location of .gitignore file" matters. We
> basically just take `basename $path` out and try to match it.

That is because the documentation was written with a single
consistent matching mode in mind: you match various patterns against
the FULL path in the repository, no matter where you find the path.
If you find a pattern "*.c" in d/.gitignore file, a path d/hello.c
matches, even though '*.c' does not match 'd/hello.c' in the shell
glob sense, and the rule needs to clarify that the leading directory
part "d/" in the path "d/hello.c" does not participate when matching
it against the pattern "*.c" taken from "d/.gitignore" file.

If you start from a mindset to match hello.c part with *.c when you
find both in d/ directory, "relative to the location" part would
sound redundant or even confusing.

>  - Otherwise, Git treats the pattern as a shell glob suitable
>    for consumption by fnmatch(3) with the FNM_PATHNAME flag:
>    wildcards in the pattern will not match a / in the pathname.
>    For example, "Documentation/{asterisk}.html" matches
>    "Documentation/git.html" but not "Documentation/ppc/ppc.html"
>    or "tools/perf/Documentation/perf.html".
>
> Perhaps "Otherwise" can be stated explicitly that "if the pattern does
> contain any slash, besides the trailing one". 

Yeah, I think there originally was just two (it has slasn or it
doesn't) and "If ..." followed by "Otherwise" was clear enough, but
spellin it out would not hurt.
