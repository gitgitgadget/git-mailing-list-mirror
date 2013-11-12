From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] [trivial] Fix comment typo
Date: Tue, 12 Nov 2013 09:19:00 -0800
Message-ID: <xmqqob5pilmj.fsf@gitster.dls.corp.google.com>
References: <1384269465-23352-1-git-send-email-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Masanari Iida <standby24x7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 18:19:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgHcM-0007gQ-V3
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 18:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab3KLRTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 12:19:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47973 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab3KLRTE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 12:19:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8174550755;
	Tue, 12 Nov 2013 12:19:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=phQN8oQlQ6+yp2TGCeSoZ+bEUBk=; b=SVldse
	ezvxy8z3uk+lknJusV4atA2Nj5BwBI49wCgY2B8Ua3+pCNTasCRDAo6LGzI/dNM3
	cdFK4F2tVbRasnPz7rOxJOlsLhF/p2X+Lg3BL/GjwJNxuiXK4h7bKdcRPbaCzXKV
	AZ7IZPr2biJ6mSBsdQIJ+7rgsZtQY+QZzbLu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n03xuvFKdZp6ck6Ds7S8qh5tJlwzQ/Ic
	rBfGSFIipkm4oGMKWdnrz0SgYbG8wfMhUP4cpuuuLEjP+Mb/T+POBBYRvJ9ctV0Q
	n8n5iDd+Yyt9zF3/yDZAjL8+n2yFMUW3f6mBPzg8HiMYg91kZDzhEG0w6mC7ucLo
	L0vFjSpgMGI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 711E150754;
	Tue, 12 Nov 2013 12:19:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C94BB50753;
	Tue, 12 Nov 2013 12:19:02 -0500 (EST)
In-Reply-To: <1384269465-23352-1-git-send-email-standby24x7@gmail.com>
	(Masanari Iida's message of "Wed, 13 Nov 2013 00:17:42 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 86C7441A-4BBE-11E3-8E73-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237720>

Masanari Iida <standby24x7@gmail.com> writes:

> Correct spelling typo
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  git-bisect.sh | 2 +-
>  pathspec.c    | 4 ++--
>  wrapper.c     | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 9f064b6..ebac284 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -137,7 +137,7 @@ bisect_start() {
>  			# cogito usage, and cogito users should understand
>  			# it relates to cg-seek.
>  			[ -s "$GIT_DIR/head-name" ] &&
> -				die "$(gettext "won't bisect on seeked tree")"
> +				die "$(gettext "won't bisect on sought tree")"

The phrasing before your "fix" comes from Cogito which called the
state cg-seek left in a "seeked tree", I think, so this change is
probably a wrong thing to do.
