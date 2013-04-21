From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git-log.txt: fix description of <since>..<until>
Date: Sat, 20 Apr 2013 23:40:59 -0700
Message-ID: <7vy5ccwflw.fsf@alter.siamese.dyndns.org>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 08:41:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTnxU-0006XL-KA
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 08:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab3DUGlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 02:41:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab3DUGlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 02:41:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EEA91312E;
	Sun, 21 Apr 2013 06:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SkovABK0Cv9hFEzZAbFCHOPOB1Q=; b=O2/ryx
	iyZUyHDZHrDrKGKflpP2e4Cuq/jM92M56iAJH9jqHjtXGDCLc9P8sp7u+yGauZ4V
	mPWhUA8ozwbLFWqPuZasfnIwzE0OsmTqW7P6T6QwqyJFQ/KamxEahWEl0RpMBm9y
	RzQDwGMNzvZe9ExbEnT1P2NMQ0PkCMSQf3IRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eOVamk+TqnqPAlFiVmWu67yj+etx8Edc
	fob9JAORsSXluLxZXzhkjlzdQu6b8m2kVavmjaSsshK8AKf+wNsZk+f81/ezfRQ5
	tKRn6aNR17bzu1o/21X8oxL0eFehgkDADgR9XAVFKLyj8/8Z8/mrSUYoiVb3QSkO
	AtEr+wvR7p8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81D211312D;
	Sun, 21 Apr 2013 06:41:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB9701312C;
	Sun, 21 Apr 2013 06:41:00 +0000 (UTC)
In-Reply-To: <1366458313-7186-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sat, 20 Apr 2013 17:15:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E54B492-AA4E-11E2-992D-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221897>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> First, <since> and <until> are ways to specify "revisions", not
> "commits", as gitrevisions.txt would indicate.  Second,
> '<since>..<until>' is simply indicative of how users would normally
> want to specify the rev spec: it need not conform to this form, and
> can take any form that gitrevisions.txt lists.  A 'git log :/quuxery'
> is perfectly valid, for instance.  Make these two corrections to the
> description of '<since>..<until>' under OPTIONS.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-log.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 69db578..f03ae74 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -25,11 +25,11 @@ OPTIONS
>  -------
>  
>  <since>..<until>::
> -	Show only commits between the named two commits.  When
> +	Show only commits between the named two revisions.  When
>  	either <since> or <until> is omitted, it defaults to
>  	`HEAD`, i.e. the tip of the current branch.
> -	For a more complete list of ways to spell <since>
> -	and <until>, see linkgit:gitrevisions[7].
> +	For a more complete list of ways to spell <since>..<until>,
> +	see linkgit:gitrevisions[7].

A bigger issue is if it is a good idea to single out A..B like this
in the enumeration of options and parameters.  We are listing this
among the optoins and pathspec, so this is where we _ought_ to be
saying that you can specify a revision range on the command line.
We use A..B only because it is the most commonly used form, asking
e.g. "show me the commit since v1.7.12 up to v1.8.0", but this
existing headline makes it as if it is the _only_ form, which is
somewhat misleading.

It might be better _not_ to say <since>..<until> here and on the
synopsis part, replace it with <revision range>, and update the text
to mention <since>..<until> as a more concrete "v1.0..v2.0" example.
Perhaps like

    <revision range>::

	Show only commits in the specified revision range.  When no
	<revision range> is specified, defaults to "HEAD" (i.e. the
	whole history leading to the current commit).  v1.0..v2.0
	asks for commits since the commit tagged as version 1.0 up
	to the commit tagged as version 2.0.  For a more complete
	list of ways to spell this parameter, see "Specifying
	Ranges" section of linkgit:gitrevisions[7].

or something.

Documentation/gitrevisions.txt lists <rev1>..<rev2>, but does not
mention that missing <rev1> (or <rev2>) defaults to HEAD, which is
worth adding there with or without the above suggested update.
