From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RelNotes: Spelling & grammar fixes.
Date: Mon, 18 Nov 2013 10:42:48 -0800
Message-ID: <xmqqmwl1blg7.fsf@gitster.dls.corp.google.com>
References: <xmqqsiuzdhov.fsf@gitster.dls.corp.google.com>
	<1384448473-25840-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 19:44:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViTof-0004kU-OC
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 19:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab3KRSnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 13:43:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094Ab3KRSmv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 13:42:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF0AF5182D;
	Mon, 18 Nov 2013 13:42:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9LXw80VNU2/sUyTMu/7neErRi9E=; b=aRKssN
	BDNAiCbWAlcPMOdw5ZWxq+/8HVvsmEdcjP/Yv7DCKEMGuU2efVWKPdxrdVFftpZ+
	2rvqlekNW87owqxC6Xpkiv2IYhKHEOVpeNRP7NEn9H5UL0oosaO5tHHfxQxLt41d
	hxZkObI+d1+hI1XepprGa2o9w7uMNDx0yqa48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nn5mZVik3VLr4G4eA6TlS1R+kvbKOY1U
	GA22Uc/7AweJR5TamR+SZP/E96ZHzJo95a2Zr+i9NMRvhe00NZhiBcc4c2FFFpmQ
	TEwNfP0UaSGXTSmWh+56Bhm/846gG+/T0ctmiou9615KSRHOmzj1dErKOao5hJj+
	eN3xxceKhuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E13115182C;
	Mon, 18 Nov 2013 13:42:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 419955182B;
	Mon, 18 Nov 2013 13:42:50 -0500 (EST)
In-Reply-To: <1384448473-25840-1-git-send-email-marcnarc@xiplink.com> (Marc
	Branchaud's message of "Thu, 14 Nov 2013 12:01:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 39D8F4F6-5081-11E3-BAFD-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238005>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Mostly just tweaks, although I did change the "foo^{tag}" description a lot.

Thanks.  It is surprising that one can make so many typoes in a
single document ;-)

> @@ -55,7 +55,7 @@ Foreign interfaces, subsystems and ports.
>  
>   * "git-svn" used with SVN 1.8.0 when talking over https:// connection
>     dumped core due to a bug in the serf library that SVN uses.  Work
> -   it around on our side, even though the SVN side is being fixed.
> +   around it on our side, even though the SVN side is being fixed.

Hmph, is this a grammo?

> @@ -126,56 +126,58 @@ UI, Workflows & Features
>     "git status --porcelain" instead, as its format is stable and easier
>     to parse.
>  
> - * Make "foo^{tag}" to peel a tag to itself, i.e. no-op., and fail if
> -   "foo" is not a tag.  "git rev-parse --verify v1.0^{tag}" would be
> -   a more convenient way to say "test $(git cat-file -t v1.0) = tag".
> + * The ref syntax "foo^{tag}" (with the literal string "{tag}") peels a
> +   tag ref to itself, i.e. it's a no-op., and fails if
> +   "foo" is not a tag.  "git rev-parse --verify v1.0^{tag}" is
> +   a more convenient way than "test $(git cat-file -t v1.0) = tag" to
> +   check if v1.0 is a tag.

Much easier to read.  Thanks.

>   * "git branch -v -v" (and "git status") did not distinguish among a
> -   branch that does not build on any other branch, a branch that is in
> -   sync with the branch it builds on, and a branch that is configured
> -   to build on some other branch that no longer exists.
> +   branch that is not tracking any other branch, a branch that is in
> +   sync with the branch it is tracking, and a branch that is tracking
> +   some other branch that no longer exists.

People use the verb "track" to mean too many different things, and
the original deliberately tried to avoid use of that word.

Specifically, we try to limit the use of "track" to mean "to keep a
copy of what we observed from the remote" as in "remote-tracking
branch remotes/origin/master is used to track the 'master' branch at
your 'origin'", which is very different from "your 'master' branch
builds on your upstream's 'master'".

So I dunno about this part of the change.
