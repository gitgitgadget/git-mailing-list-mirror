From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "docs: stop using asciidoc no-inline-literal" breaks asciidoc
 8.2.5
Date: Tue, 29 May 2012 12:45:51 -0700
Message-ID: <7vzk8q3h5c.fsf@alter.siamese.dyndns.org>
References: <CACBZZX7Y-NTzRP1KYy=eEHTsLHTrzxGms61anXSHVbyCSPgurw@mail.gmail.com>
 <87ehq3mbxg.fsf@thomas.inf.ethz.ch>
 <CACBZZX5iOB5PCZUCX5ksR4hpw+DTLTaP4jOnyHAJ8hZVe9xo5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 21:45:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZSMg-00083y-L1
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 21:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257Ab2E2Tpz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 15:45:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41611 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581Ab2E2Tpy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 15:45:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 991D591F7;
	Tue, 29 May 2012 15:45:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HnTz386ApXoe
	F1puFroI9f7GMnw=; b=hXE4A9LpoTiJ+7uinpubR7+TUvpXuRxwEW9TjBqkgvYE
	K9UF84iEZqn9ciONsHgIThjSsk2ZjEa7oLJ8Unkm2iBnOQL2yHWSLs7y7zwkQDbv
	dWuvph4n2QEV89OrYNi89ZFLr+7wNPn1OjLkVZfkaZTJzhH0ctlwB347tHMA1kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QumDDx
	EsStPVkvS9fbjTsmX9Y/ymqkhAbf1QS5FGOHWciR7p6PoI8g7YvuD86ARhBGXmUb
	dmorLGOJK+sEGQcpeFFQ+DXr2YGs0nDk3eSH73LMEVd164HbbwddfGIcuuWaLQlq
	oguIO+DWX0xz9Q2DgJtqUceGoESNaQ+jSDHMM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F22191F6;
	Tue, 29 May 2012 15:45:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20A7291F4; Tue, 29 May 2012
 15:45:53 -0400 (EDT)
In-Reply-To: <CACBZZX5iOB5PCZUCX5ksR4hpw+DTLTaP4jOnyHAJ8hZVe9xo5w@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 29 May
 2012 14:31:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E65F72DA-A9C6-11E1-AFF8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198755>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think it's too soon to break the stock toolchain on systems as
> recent as RHEL 5.5 in the name of slightly nicer asciidoc syntax.

It is debatable if any version of distribution can be called
"recent" if they ship 5 year old version of software that is updated
fairly often, though.

> We could also keep the nice syntax and have some simple sed-based
> pre-processor that converts the syntax to the older and more widely
> supported version.

No, let's not go there.  I do not see any reason to believe that
such a sed script would do an equally good or better job as native
AsciiDoc implementation to deal with inline-literals.  That means we
would end up writing our documentation with a subset of newer
AsciiDoc that the custom sed script can grok---which defeats the
purpose of the whole exercise.

> Or we could just decide to break RHEL 5 and systems released at a
> similar time, but that isn't what the patch suggested it was doing, s=
o
> we should probably step back and ponder whether that's something we
> want to do.

Very true.  Jeff, how do we want to proceed?  For the upcoming
release, I am inclined to say that we would revert 6cf378f (docs:
stop using asciidoc no-inline-literal, 2012-04-26).  We would still
need to double check the result, though. Documentation updates that
came after it are written assuming "inline-literal" behaviour, and
parts we may have "fixed" with the commit will format to their old
rendition.
