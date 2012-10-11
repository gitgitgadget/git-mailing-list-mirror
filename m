From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Thu, 11 Oct 2012 10:57:26 -0700
Message-ID: <7vmwzs7uyh.fsf@alter.siamese.dyndns.org>
References: <20121005225758.GA1202@sigill.intra.peff.net>
 <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
 <20121006131200.GB11712@sigill.intra.peff.net>
 <7vvcenqx39.fsf@alter.siamese.dyndns.org>
 <20121006183026.GA3644@sigill.intra.peff.net>
 <CAOTq_pu=xWF7q3QobxSerkkbV56n5o+CPQSyHg8onwv73v25+A@mail.gmail.com>
 <20121006190753.GA5648@sigill.intra.peff.net>
 <7vr4paovjq.fsf@alter.siamese.dyndns.org>
 <20121007214958.GC1743@sigill.intra.peff.net>
 <7vehl9q5uk.fsf@alter.siamese.dyndns.org>
 <20121007222502.GA3263@sigill.intra.peff.net>
 <CAOTq_ptaXMUzSi-PomMa9K9-Fnus0pnsO+vq92ZnxfeRQZPAxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Frans Klaver <fransklaver@gmail.com>,
	git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 19:57:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMN0z-0005lC-Po
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 19:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759089Ab2JKR5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 13:57:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758870Ab2JKR53 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 13:57:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D46B8B85;
	Thu, 11 Oct 2012 13:57:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=241gfnX++06RPO2e3jjM7Iy1qSs=; b=Bi0hQs
	KzhZA4U3Za7NGoJlm/z1GXC3bmQMzi7l0jN8hM3rKWKfurNMqnvxX4KkINDQoDTL
	/+yav7GlRih0ayGgmfhsIDUbn8mjomK6jp4iNnHMyk7AFbZjelwtzbBv0hHU8ZLq
	X+2JsrmsZDGN2GsTiM/H03oq5U3FAc9vsSlQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VvEr8tJrkcRbFGVZphCZnGtq7n+gVFcF
	g7yTouPHSloZuigwnAfN26uwFXNhMkSk++Nj5tU0TLXubu4qhlG9Tn3AQerXR1TG
	wwxSYw4IBKdcrsxXBst6tg+XW2WQGIGyWXzTLGHI9r4HUuOcNR64ZE3Ny73Zn/7R
	7lE07Q6q7lY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B1668B84;
	Thu, 11 Oct 2012 13:57:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B63F18B81; Thu, 11 Oct 2012
 13:57:27 -0400 (EDT)
In-Reply-To: <CAOTq_ptaXMUzSi-PomMa9K9-Fnus0pnsO+vq92ZnxfeRQZPAxw@mail.gmail.com>
 (=?utf-8?Q?=22Conrad=C2=A0Irwin=22's?= message of "Wed, 10 Oct 2012 22:51:28
 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E9FD8D6-13CD-11E2-BFDB-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207500>

Conrad Irwin <conrad.irwin@gmail.com> writes:

>  -i::
>  --include::
> -	Before making a commit out of staged contents so far,
> -	stage the contents of paths given on the command line
> -	as well.  This is usually not what you want unless you
> -	are concluding a conflicted merge.
> +	In addition to the paths specified on the command line,
> +	include the current contents of the index in the commit.

"commit" is about committing what is in the index.  include has
always meant "in addition, include the contents of listed paths
in the resulting commit".

The updated text looks totally the other way around.

>  -o::
>  --only::
> -	Make a commit only from the paths specified on the
> -	command line, disregarding any contents that have been
> -	staged so far. This is the default mode of operation of
> -	'git commit' if any paths are given on the command line,
> -	in which case this option can be omitted.
> -	If this option is specified together with '--amend', then
> -	no paths need to be specified, which can be used to amend
> -	the last commit without committing changes that have
> -	already been staged.
> +	Only commit changes to the paths specified on the command line,
> +	do not include the current contents of the index. This is
> +	the default mode of operation when paths are specified.
> +	If this option is specified with --amend it can be used
> +	to reword the last commit without changing its contents.
> +	This mode cannot be used with --patch or --interactive.

The new text on this one does look cleaner and easier to read, at
least to me, but "do not include the current contents" sounds as if
you are recording a tree that only has Makefile and losing all the
other files when you say "git commit Makefile".

    Disregard what has been added to the index since HEAD, and only
    commit changes to the given paths.

might be an improvement, but I dunno.
