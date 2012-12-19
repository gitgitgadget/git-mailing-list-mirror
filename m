From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2012, #05; Tue, 18)
Date: Wed, 19 Dec 2012 12:47:59 -0800
Message-ID: <7vobhp93b4.fsf@alter.siamese.dyndns.org>
References: <7v4njjf6fk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 21:48:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlQYz-0003HE-DU
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 21:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab2LSUsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 15:48:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768Ab2LSUsE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 15:48:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FCF388B9;
	Wed, 19 Dec 2012 15:48:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bmGywGi+a5FzG3I7Fb/K6afU/ds=; b=RiumqG
	p8d7m33fA7vF3L+6AJe1eXTOtX8fTlyg81um40KdP5c3lBhfobbwQmMczZ9H75Ug
	94jawW9FLxoKV55otIuJFU53Xuj1DlVeCGg5wm69+Qpn1NmFBdLyCxr7ZChMB6x6
	5C6s0ibEICZ8YFtmOP6W368qATUjJWUn+DXxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LFP0l6gpd1jLI8dUkU5UZVBoN8zJSUQG
	p2Eq2Z/BX1MxAc+pVJUTrmamEaN9ZQsRl9n+yco3lGWaSl3E/AfG8z+zJdB4D5UN
	MCvYUsuOsiwCuGFbs4DqJh0QlohfnudUTOTtWeobpS1SfT6wc2WvYvXuzyj7ZFLM
	Pepe7StVMyU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10F8588B5;
	Wed, 19 Dec 2012 15:48:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5960C88B2; Wed, 19 Dec 2012
 15:48:01 -0500 (EST)
In-Reply-To: <7v4njjf6fk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 18 Dec 2012 12:31:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60DCDC72-4A1D-11E2-877C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211846>

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
> The tip of the 'master' branch is a bit past 1.8.1-rc2; hopefully we
> can go final around the end of the week.
>
> Many topics are getting into good shape in 'next', hopefully ready
> to be merged soon after the 1.8.1 final.

As we seem to be getting more minor documentation updates that are
safe for the upcoming release, and also because I've updated the
AsciiDoc toolchain used to prepare the preformatted manpage and HTML
tarballs, I changed my mind to delay the final til the end of the
year, and tag an rc3 toward the end of this week instead.

Both repositories http://code.google.com/p/git-htmldocs/ and
http://code.google.com/p/git-manpages/, and the browser-reachable
pages at http://git-htmldocs.googlecode.com/git/git.html should
start getting the output formatted with AsciiDoc 8.6.8.

The following documentation updates topics are likely to be in the
rc3:

    as/doc-for-devs
    cr/doc-checkout-branch
    jc/doc-diff-blobs
    jc/fetch-tags-doc
    jk/avoid-mailto-invalid-in-doc
    nd/index-format-doc
    sl/git-svn-docs
    sl/readme-gplv2
    ta/api-index-doc

Also I am planning to have the .mailmap cleanup topic in the rc3:

    jk/mailmap-cleanup

Thanks.
