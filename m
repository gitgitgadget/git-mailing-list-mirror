From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cherry.txt: cross reference "git log --cherry"
Date: Sat, 21 Dec 2013 22:58:02 -0800
Message-ID: <7vk3exjrt1.fsf@alter.siamese.dyndns.org>
References: <5167369f.ea15340a.5e12.0282@mx.google.com>
	<1387484450-935-1-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 22 07:58:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuczC-0001Sw-Qq
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 07:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab3LVG57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 01:57:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab3LVG56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 01:57:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3CB04D5E2;
	Sun, 22 Dec 2013 01:57:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BMVF2Ta43wUuo6dPSE5j2xKZZ9s=; b=EMCWcQ
	OwZJBoGl4F9WNUM6YlnUDRaOge2ZIex7yCWQlE5X1yfT4lO6pMSlGEEvq/I8HdDf
	w1OsHZkYnJTtvxDgozbZt13gOIgVV9ZIm/Dr+FT7uBWfo8OxE3UZzjj0BLyyNnM+
	HCgR2zFcMW2O26bQ4f/k81Hpq5kJbgXXzjTk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ilud2a0YBFuH2Ig1YbErIYGvbOfEBklT
	jLxRZIvwpniPtfZjbPCZ9L3zATDV+fApdkl0kzjo1GfBy1IzmTZwnAVcIdU74cc+
	vfuikTThQTpUN/IATDW4CNyhwbB3sLpJQ3Y1M6LwaX7gkW1uKKvvyoyNsixWFi2o
	mzBbnWhjhis=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFD8A4D5E1;
	Sun, 22 Dec 2013 01:57:57 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1EC94D5E0;
	Sun, 22 Dec 2013 01:57:56 -0500 (EST)
In-Reply-To: <1387484450-935-1-git-send-email-naesten@gmail.com> (Samuel
	Bronson's message of "Thu, 19 Dec 2013 15:20:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 63047F20-6AD6-11E3-8DFF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239633>

Samuel Bronson <naesten@gmail.com> writes:

> I learned of "git cherry" some days ago, but only learned of --cherry
> and related options to "git log" today[1] (more-or-less by chance).
>
> If the git-cherry(1) manpage had mentioned --cherry, I would have
> learned of these options sooner.

This proposed log message is of an unusual style.  It is curious
that somebody learn "cherry" first before "log".

>  SEE ALSO
>  --------
> -linkgit:git-patch-id[1]
> +linkgit:git-patch-id[1],
> +the `--cherry` option to linkgit:git-log[1]

The description text talks about "changeset (or "diff")", "compares
the changeset rather than the commit id", "diffs are compared",
etc., which is a hint that a lone reference to "patch-id" would be a
page to read about that comparison, which is a good motivation that
may entice the readers to follow that reference.

I am not sure what value the readers of this man page would see to
this addition, though. Unlike the reference to patch-id, it is not
so obvious what gives them motivation to follow this new reference
to "log --cherry".  A new sentence in DESCRIPTION section to mention
it (e.g. "'log --cherry' gives similar information") may be needed
at the same time.
