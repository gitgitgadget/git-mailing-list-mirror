From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] strbuf.h: drop asciidoc list formatting from API docs
Date: Fri, 12 Dec 2014 14:19:00 -0800
Message-ID: <xmqqk31weckr.fsf@gitster.dls.corp.google.com>
References: <20141212212726.GA26284@peff.net>
	<20141212212820.GB27451@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:19:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzYYH-0003oE-OT
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 23:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbaLLWTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 17:19:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752208AbaLLWTD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 17:19:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F8B624DBE;
	Fri, 12 Dec 2014 17:19:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XR7lbKqEDloR+HIh18gtJ32V1Pw=; b=UNaCdb
	DjVvkYFD/cXVKwzyIOIeYA/rETr9A5RZfxIwRMET6H2/HgPfMucYMJYrourCbvQZ
	rr1TlAK5u5Qc9pzOSNOmAEplqWhS9Kpfmx7r/W+TFsw96yF4QumxOqhGBQIEzSIZ
	QQ7m8O37ARvQOzTvHC02bcrg8Usfbdg195vdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S7KkBm09l2QruAcwirIlHbtKoKnfWvAQ
	IzYEZ6vrRuHK4+vmgq0XX/1OLtGGTax+NNqBkvE9ymFBCjYHpXZ1DCAz07F9wG1Q
	sZT7JVlV3w+3Ic9Sg/H/aoRQ3OdZ1yAErGDno/L2j2blmUeR87gPgdIWZTaInmCv
	SRIcB8fxsbQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8468324DBD;
	Fri, 12 Dec 2014 17:19:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 078C024DBA;
	Fri, 12 Dec 2014 17:19:01 -0500 (EST)
In-Reply-To: <20141212212820.GB27451@peff.net> (Jeff King's message of "Fri,
	12 Dec 2014 16:28:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0501906-824C-11E4-B1AC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261384>

Jeff King <peff@peff.net> writes:

> Using a hanging indent is much more readable. This means we
> won't format as asciidoc anymore, but since we don't have a
> working system for extracting these comments anyway, it's
> probably more important to just make the source readable.

Yeah.

Those who want to strip the leading " * " to turn it into AsciiDoc
would need to also parse out the hanging indent and format into
AsciiDoc, which is not entirely an unreasonable thing to ask.
