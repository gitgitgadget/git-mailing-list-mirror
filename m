From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Tue, 05 Jun 2012 08:12:29 -0700
Message-ID: <7v1ultrdwi.fsf@alter.siamese.dyndns.org>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
 <7vsjecvxmc.fsf@alter.siamese.dyndns.org> <vpq1ulvuxd9.fsf@bauges.imag.fr>
 <20120604115630.GC27676@sigill.intra.peff.net>
 <vpqpq9en8ol.fsf@bauges.imag.fr>
 <20120605065955.GB25809@sigill.intra.peff.net>
 <20120605073403.GC25809@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 17:12:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbvQx-0000Of-Iv
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 17:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab2FEPMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 11:12:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505Ab2FEPMc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 11:12:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC4718DA1;
	Tue,  5 Jun 2012 11:12:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lwAqipnU4yGf2oXcpA4kIp7nWu8=; b=N6qzX7
	xGIMNG10Jme+dBnC49aprEqy2cJ+KklTR1pnhvMZ0oJCGDaCEjXpppXHhdsUXjGs
	xAM3avjIcJGNrm3RtD7xYADE6jS/mhrg25JX3RO5zSyTlS/UpgyjNwgPx31nF1zv
	2AUsk5T3qaXmkC/m48Uhyij1q6lAm6I/ve9IY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CukaBw0psS3zmleqYK3AE4OwkYY/hjVI
	ZNZDH/keVx2tfJzym/rIfmCMdNlEAyCq0bwLmDl9r0/i/F/4QbDC1vzbOBZB1HFa
	+lBba6sI2d9axuUQ1oWK9bqakzZ6ZWb/T74OZH2YcqHJpn4qHgS8Xhe6NKPkrQD/
	GGj4XGBvyHc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2A0D8DA0;
	Tue,  5 Jun 2012 11:12:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E9458D9F; Tue,  5 Jun 2012
 11:12:31 -0400 (EDT)
In-Reply-To: <20120605073403.GC25809@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Jun 2012 03:34:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEE7856A-AF20-11E1-B771-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199250>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 05, 2012 at 02:59:55AM -0400, Jeff King wrote:
>
>> I wonder if we could even make asciidoc work to convert
>> linkgit:git-config[1] into the right path (i.e., to include the ".."
>> automatically) when we are in the subdir.
>> 
>> I don't really have a sense how powerful asciidoc macros are, but this
>> seems like an obvious case that they should handle.
>
> Here is a simple fix. The Makefile bits are more hacky than I would
> like. It would be really nice if the asciidoc macro could convert "we
> are working on X/Y/Z.html" into "we need ../../ to get to the relative
> base", but I don't think it is that flexible.
>
> We could also replace asciidoc with a wrapper script that does the
> conversion and sets the appropriate attribute. I don't know if it is
> worth the trouble. It's not like we add documentation subdirectories
> very often.

Sorry, but I am not sure what problem is this trying to solve.  An
API documentation page should only refer to command documentaion
pages, and never another API documentation page that is at the same
level?

> -- >8 --
> Subject: docs: fix cross-directory linkgit references
>
> Most of our documentation is in a single directory, so using
> linkgit:git-config[1] just generates a relative link in the
> same directory. However, this is not the case with the API
> documentation in technical/*, which need to refer to
> git-config from the parent directory.
>
> We can fix this by passing a special prefix attribute when building
> in a subdirectory, and respecting that prefix in our linkgit
> definitions.
>
> We only have to modify the html linkgit definition.  For
> manpages, we can ignore this for two reasons:
>
>   1. we do not generate actual links to the file in
>      manpages, but instead just give the name and section of
>      the linked manpage
>
>   2. we do not currently build manpages for subdirectories,
>      only html
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/Makefile      | 2 ++
>  Documentation/asciidoc.conf | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 14286cb..b3693c8 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -280,6 +280,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
>  	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
>  	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
>  
> +technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
>  $(patsubst %,%.html,$(API_DOCS) technical/api-index): %.html : %.txt
>  	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
>  		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
> @@ -333,6 +334,7 @@ $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
>  
>  WEBDOC_DEST = /pub/software/scm/git/docs
>  
> +howto/%.html: ASCIIDOC_EXTRA += git-relative-html-prefix=../
>  $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
>  	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
>  	sed -e '1,/^$$/d' $< | $(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 - >$@+ && \
> diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
> index aea8627..6d06271 100644
> --- a/Documentation/asciidoc.conf
> +++ b/Documentation/asciidoc.conf
> @@ -91,5 +91,5 @@ endif::doctype-manpage[]
>  
>  ifdef::backend-xhtml11[]
>  [linkgit-inlinemacro]
> -<a href="{target}.html">{target}{0?({0})}</a>
> +<a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
>  endif::backend-xhtml11[]
