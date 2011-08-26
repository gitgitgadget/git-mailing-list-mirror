From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-replace.txt: Clarify list mode
Date: Fri, 26 Aug 2011 09:30:35 -0700
Message-ID: <7v4o14f844.fsf@alter.siamese.dyndns.org>
References: <4E574D61.8050501@drmicha.warpmail.net>
 <0a88518db0b0db8f1a4a4deeebd6dffc2d603e74.1314345131.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 18:30:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwzIs-0002lt-Cu
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 18:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab1HZQal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 12:30:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755296Ab1HZQak (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 12:30:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26EF4393E;
	Fri, 26 Aug 2011 12:30:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iur0CUVK2acmQbaO/Drk2+RaOE0=; b=cjc0XM
	JX+aS1LhsVedCQStsYgTW0S33pGF4sHQH6vVBPmJdPgKK6CsrzSOiZDrF21WL4Fg
	5iJZx0JsRtyRMe0nHRRAzdO+/XLM2JHYSRJe3jbhZaY4NEr28wKHpBlI7oArbtAS
	+KDiG4jBsI/yGfdpmdMnt4KceRFnpv2O+dNok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fZuEMEgzJnkO3rlOGj4jDRhP8CLXvTyR
	pwmZ1CwnzqAesyMkusOssMWfGQcq9q587/qHh/GaxzzxOb3sMebBSTU2AdURj8yX
	MAy2RlCNT2MfFG3Zwwx7aE3uN2zs592bi80VcaBbMyZnRG73qmK2E0MDbg0AbcEu
	QDZj7qPq1Ks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BC4D393D;
	Fri, 26 Aug 2011 12:30:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72FAD393B; Fri, 26 Aug 2011
 12:30:38 -0400 (EDT)
In-Reply-To: <0a88518db0b0db8f1a4a4deeebd6dffc2d603e74.1314345131.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 26 Aug 2011 09:53:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB76DA9A-D000-11E0-8ED6-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180177>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Clarify that in list mode, "git replace" outputs the shortened ref
> names, not their values.
>
> Also, point to the difficult to find git show-ref $(git replace -l).
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-replace.txt |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
> index 17df525..cd00837 100644
> --- a/Documentation/git-replace.txt
> +++ b/Documentation/git-replace.txt
> @@ -61,6 +61,13 @@ OPTIONS
>  	all if no pattern is given).
>  	Typing "git replace" without arguments, also lists all replace
>  	refs.
> ++
> +Note that this lists the names of the replace refs, not their values
> +(not their replacements). You can get the latter like this, e.g.:

Hmm, the update is _not wrong_ per-se, but...

I highly doubt we would want to try to cover confusions that may come from
any and all different mis-/pre-conceptions people may have by making the
description _longer_.

Which part of the wording in the existing description made you think that
the command might list both names and their contents?  We should identify
that misleading description (if there is) and fix that, instead of tacking
clarifying clauses at the end.

Given these statements:

	"git replace" lists all replace refs.
        "ls" lists paths in the directory.

I would say a natural reading of them is that they list "replace refs" and
"paths", not "replace refs and their contents" and "paths and their contents".

By the way, one thing I forgot to say was that I do not think the variant
of the output you wanted to have is necessarily a bad thing (it is bad to
change the existing output to that variant, breaking other
people). Perhaps it can become "-v(erbose)" output?
