From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Release notes grammatical fixes.
Date: Tue, 05 Aug 2014 11:29:25 -0700
Message-ID: <xmqqha1qpz7e.fsf@gitster.dls.corp.google.com>
References: <xmqqy4v3q43r.fsf@gitster.dls.corp.google.com>
	<1407257445-18363-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 20:36:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEjaZ-0002L0-WC
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 20:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbaHESfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 14:35:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59227 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755740AbaHES3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 14:29:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 78E7C2EC3B;
	Tue,  5 Aug 2014 14:29:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IZdsZRALGnLcmE/iinJ5Ds9fM/c=; b=YnuReW
	nuIf2drDjAdsDB+gKbTJ4Oi+iu5Y0Ap8P0mjfYnmkgTl4FEY4McBnbE8WpiDPYzH
	LvZ31wlDUEFuLoTktoCdElu/4fjfU+Tei1tCjvleGC6lK2BvGWEKfSJSQsM3eOnc
	lmZgpaiXB7A0gLdY6nDX3P+78hMXsJsQdwOsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l4DCFY1eji7SLXq+nXd7Txokbt118IfC
	TO21OMPvl+r6+aAwHIQkkDyX6QJgeLeMGLNxISUfgfgwYcjoj7NCs6Uqh+glp2wr
	rejFat+1xJdUwIKwZeshWSZeIHGxbKauAiWvrWGIZxw4Tsa2QC8ifVAFQkc5jTfO
	pfsLGF0zX0A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D6AE2EC39;
	Tue,  5 Aug 2014 14:29:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6CB462EC20;
	Tue,  5 Aug 2014 14:29:27 -0400 (EDT)
In-Reply-To: <1407257445-18363-1-git-send-email-marcnarc@xiplink.com> (Marc
	Branchaud's message of "Tue, 5 Aug 2014 12:50:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6EBB00FA-1CCE-11E4-A003-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254818>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> diff --git a/Documentation/RelNotes/2.1.0.txt b/Documentation/RelNotes/2.1.0.txt

Many are indeed grammatical errors, and many others make the result
easier to read, even if the original weren't incorrect per-se.

> @@ -87,22 +87,20 @@ UI, Workflows & Features
>   * "git mergetool" learned to drive the vimdiff3 backend.
>  
>   * mergetool.prompt used to default to 'true', always asking "do you
> -   really want to run the tool on this path?".  Among the two
> -   purposes this prompt serves, ignore the use case to confirm that
> -   the user wants to view particular path with the named tool, and
> -   redefine the meaning of the prompt only to confirm the choice of
> -   the tool made by the autodetection (for those who configured the
> -   tool explicitly, the prompt shown for the latter purpose is
> -   simply annoying).
> -
> -   Strictly speaking, this is a backward incompatible change and the
> +   really want to run the tool on this path?".  The default has been
> +   changed to 'false'.  However, the prompt will still appear if
> +   mergetool used its autodetection system to guess which tool to use.
> +   Users who explicitly specify or configure a tool will no longer see
> +   the prompt by default.
> +
> +   Strictly speaking, this is a backward incompatible change and
>     users need to explicitly set the variable to 'true' if they want
> -   to resurrect the now-ignored use case.
> +   to resurrect the old behaviour.

I however think you are losing information here.  It is unclear in
the rewritten one why you would ever want the "old" behaviour, i.e.
what you may be missing by following along with this change.

Thanks. 
