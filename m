From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2012, #06; Mon, 19)
Date: Tue, 20 Nov 2012 15:50:45 -0800
Message-ID: <7vy5hvq1ey.fsf@alter.siamese.dyndns.org>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 00:51:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Taxao-0007dy-P7
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 00:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368Ab2KTXus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 18:50:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089Ab2KTXus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 18:50:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A30E0A1EF;
	Tue, 20 Nov 2012 18:50:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6siNgyAR2qhT31PdX5T2JOV6GUA=; b=AS/XA8
	Eb5tHfLgUMqUZFFeq58An7Ywy61Fpdn9KIabvrwJxCfRSGutWvGNsnPiZ3oNOJMD
	ysWufqNyzQCqpVXt2OxCqLPCrZp0X52DVjdInNk1olWpoIQYe3FjUJagP43WOjp3
	pRUlKD0n3psLtDlSLMras1wA/tJGGrLUoIBDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oY9fIVUS4b42L9ez8nB00tbij+1+U29e
	Sk9GMpO0wSYcVgpIeqojrz1DgZFwf+GzOYzPDQ7eilC+WEBFIwADaZNwrtH2tIUT
	QmhyXkumbRTQ5WybKpvc25a8ipmcXMhPt3TQA1nPV2xDwGxU/67mB8QJA7GceA4T
	F4uEoaiAW9s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90D51A1EE;
	Tue, 20 Nov 2012 18:50:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA7E2A1E9; Tue, 20 Nov 2012
 18:50:46 -0500 (EST)
In-Reply-To: <7vpq39up0m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 19 Nov 2012 15:55:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1ADCF994-336D-11E2-861A-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210124>

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
> Bunch of topics have been merged to 'next'.
>
> We are at the beginning of the 5th week of this release cycle
> (cf. http://tinyurl.com/gitcal), and I've moved many topics to the
> Stalled category, which will be discarded without prejudice soonish
> unless there are some updates.  I am still a bit behind on some
> topics and already posted rerolls may have to be pulled in.

It feels a bit too busy/loud to issue two "What's cooking" in a row,
so here is an informal update.

 - The following have graduated to 'master'.

     cn/config-missing-path
     jk/checkout-out-of-unborn
     jk/maint-gitweb-xss
     jk/maint-http-half-auth-fetch
     jl/submodule-rm
     kb/preload-index-more
     mg/replace-resolve-delete
     mh/alt-odb-string-list-cleanup
     ml/cygwin-mingw-headers
     pw/maint-p4-rcs-expansion-newline
     rh/maint-gitweb-highlight-ext
     ta/doc-cleanup

 - Many topics have been merged to 'maint' in preparation for 1.8.0.1.

     mg/maint-pull-suggest-upstream-to
     mm/maint-doc-commit-edit
     as/maint-doc-fix-no-post-rewrite
     rs/lock-correct-ref-during-delete
     rf/maint-mailmap-off-by-one
     jk/maint-diff-grep-textconv
     js/format-2047
     sz/maint-curl-multi-timeout
     po/maint-refs-replace-docs
     ph/pull-rebase-detached
     mm/maint-doc-remote-tracking
     rs/branch-del-symref
     nd/grep-true-path
     jc/grep-pcre-loose-ends (early part)
     da/mergetools-p4
     jc/test-say-color-avoid-echo-escape
     bw/config-lift-variable-name-length-limit

 - A few topics have been resurrected from the stalled category to
   cooking:

     pp/gitweb-config-underscore
     jc/apply-trailing-blank-removal
