From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/16] Add git-remote-testsvn to Makefile.
Date: Mon, 20 Aug 2012 15:19:31 -0700
Message-ID: <7vehn1i4uk.fsf@alter.siamese.dyndns.org>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 00:19:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3aJx-0001dh-9t
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 00:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186Ab2HTWTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 18:19:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52231 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289Ab2HTWTe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 18:19:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C8168D3B;
	Mon, 20 Aug 2012 18:19:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UW4VfP07cMIho9NQEFj0qwWTisw=; b=idQbgX
	3dbXXAGxr9AtaqBfumZRaH2se0LYp6hXj2NQ8+/pxMZPgKHOkyipSNGp61r9zR+7
	hsPzTsheIo4Dlm7HRLJof8QBA2AbVmD+aOazTcsQUqa5kpFxnTI/GMYLmeWqGU+r
	7DF3zuScu2K419TQ7vFYaGW2TH7yNlLHUXU3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JfHavVt8yJ5E6+uoWVHIFdrGFuf9VOZq
	r+BIa/p4Pi+xXLKpqQSnpAPTbQkDXDAzQ92RcKpxt1HiDitWFclOdrD862FUDWoJ
	Sch5s/uLe/8LDkuE5ciyB1+k+Ka/GfDe2ZLA5GtzxXGZuTwPxKRZGzL7XB5uKxr+
	m3ggVwWC6vM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18AE38D3A;
	Mon, 20 Aug 2012 18:19:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65AAC8D39; Mon, 20 Aug 2012
 18:19:33 -0400 (EDT)
In-Reply-To: <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Mon, 20 Aug 2012 23:52:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E5FB368-EB15-11E1-8EA4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203901>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> Subject: Re: [PATCH v5 02/16] Add git-remote-testsvn to Makefile.

Adds '.' at the end of the title.

> The link-rule is a copy of the standard git$X rule but adds VCSSVN_LIB.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---
>  Makefile |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 6b0c961..fb5cdcf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -477,6 +477,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
>  PROGRAM_OBJS += shell.o
>  PROGRAM_OBJS += show-index.o
>  PROGRAM_OBJS += upload-pack.o
> +PROGRAM_OBJS += remote-testsvn.o
>  
>  # Binary suffix, set to .exe for Windows builds
>  X =
> @@ -2352,6 +2353,10 @@ git-http-push$X: revision.o http.o http-push.o GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
>  
> +git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) 

Adds trailing whitespace.

> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
> +	$(VCSSVN_LIB)
> +
>  $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
>  	$(QUIET_LNCP)$(RM) $@ && \
>  	ln $< $@ 2>/dev/null || \

But I think moving this to the top-level made things a lot simpler.
Excellent.
