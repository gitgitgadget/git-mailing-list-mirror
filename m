From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2010, #02; Wed, 16)
Date: Thu, 17 Jun 2010 09:24:21 -0700
Message-ID: <7vocf939vu.fsf@alter.siamese.dyndns.org>
References: <7viq5ict4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Brian Downing <bdowning@lavos.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Ian Ward Comfort <icomfort@stanford.edu>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Philippe Bruhat (BooK) <book@cpan.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simo Melenius <simo.melenius@iki.fi>,
	Stephen
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 17 18:25:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPHu9-0007g1-Rs
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 18:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998Ab0FQQZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 12:25:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932992Ab0FQQZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 12:25:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D856BC304;
	Thu, 17 Jun 2010 12:25:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nutj6EdF80VFHNGdZ6NzhmGGOLo=; b=UXadfJ
	FRoPm/L60CCiXLKg8nfQxRVYcTIk4Vl7WVZxHI2E5uYvYj/xL8qkndhmh/kqX7J+
	1Dpv5JVjqjyaB0sdVGdqYhAIZ8hfo/0apneZ0kSGy94z31dGh9Iexg9Nbq5+mq9P
	N8F6xiPQPibw0F+fUjoc2MW1/URyO7zu4BKB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xh84uaaG3GIRrhI5Nc9mxb6GxD9Tw5di
	3KsY8b8CTpsMBzdeyicS1cGbO7vzT5ovZ9C8KPnaWx/x7g1zCIIFhDrCWDBOppl5
	VMJGeOYlPt057xT8TO8BB19IL1gmsYe0XDmietUPkEOj31NifWT1osmTeDqpmDL9
	qMv3Csdxyqc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B600BC2FA;
	Thu, 17 Jun 2010 12:24:50 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76A23BC2E6; Thu, 17 Jun
 2010 12:24:23 -0400 (EDT)
In-Reply-To: <7viq5ict4p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 16 Jun 2010 19\:03\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DA5882FE-7A2C-11DF-A44B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149318>

Here are some comments and notes on various topics; this message discusses
only transitions from 'pu' to 'next'.

> * bd/maint-unpack-trees-parawalk-fix (2010-06-10) 1 commit
>  - unpack-trees: Make index lookahead less pessimal

I really need to come up with time to check this one.

> * ab/blame-textconv (2010-06-07) 3 commits

Type punning in textconv_object() needs to be fixed.

> * cp/textconv-cat-file (2010-06-09) 4 commits

Likewise.

> * ab/i18n (2010-06-15) 3 commits
>  . Add initial C, Shell and Perl gettext translations
>  . fixup! Add infrastructure
>  . Add infrastructure for translating Git with gettext

I haven't got around to fix conflicts merging this with various other
topics yet.

> * ab/tap (2010-06-09) 4 commits
>  - We use TAP so the Perl test can run without scaffolding
>  - Skip tests in a way that makes sense under TAP
>  - Merge branch 'jc/t9129-any-utf8' into ab/tap
>  - Make test-lib.sh emit valid TAP format
>  (this branch uses jc/t9129-any-utf8.)

I was not sure why TAP is worth the trouble, and I still am not sure.

> * jl/maint-diff-ignore-submodules (2010-06-08) 2 commits
>  - Add optional parameters to the diff option "--ignore-submodules"
>  - git diff: rename test that had a conflicting name

Is everybody happy with the naming of --ignore-submodules=<when> and the
semantics?

> * tr/rev-list-count (2010-06-12) 2 commits

I am not convinced the upstream selection logic between git/svn is right
in the tip one.  Clues?

> * tr/send-email-8bit (2010-06-12) 1 commit

If I am not misreading the patch, it does not seem to stop the scanning of
the "C-T-E:" header at the end of header; it should.

> * pb/maint-perl-errmsg-no-dir (2010-06-14) 1 commit

There was a comment on what the proposed commmit log message said
regarding $!; perhaps an update is in order?

> * zl/mailinfo-recode-patch (2010-06-14) 2 commits

The interaction between "-n --recode" needs to be fixed; it probably is Ok
to reuse "i18n.commitEncoding".  Opinions?

> * jn/grep-open (2010-06-12) 4 commits
> * jn/gitweb-return-or-exit-cleanup (2010-06-13) 1 commit
> * jc/maint-simpler-common-prefix (2010-06-16) 1 commit
> * mg/pretty-magic-space (2010-06-14) 1 commit
> * sb/format-patch-signature (2010-06-15) 2 commits
> * cc/cherry-pick-series (2010-06-02) 8 commits

I will merge these to 'next' shortly.

> * ic/maint-rebase-i-abort (2010-06-08) 1 commit
> * jk/maint-advice-empty-amend (2010-06-06) 1 commit
> * jn/document-rebase-i-p-limitation (2010-05-31) 1 commit
> * rr/parse-date-refactor (2010-06-03) 1 commit
> * sm/branch-broken-ref (2010-06-04) 2 commits
> * cc/maint-commit-reflog-msg (2010-06-12) 1 commit
> * lt/extended-sha1-match-commit-with-regexp (2010-04-23) 1 commit
> * jc/rev-list-ancestry-path (2010-06-04) 5 commits
> * eb/core-eol (2010-06-04) 4 commits

I already merged these to 'next'.
