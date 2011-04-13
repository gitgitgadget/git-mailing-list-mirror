From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 13:43:39 -0700
Message-ID: <7vfwpllw5g.fsf@alter.siamese.dyndns.org>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com>
 <1302721187.21900.4.camel@drew-northup.unet.maine.edu>
 <1E5D7DCE-B3B3-4CC7-8F40-4ED48E76907D@gmail.com>
 <1302722214.22161.5.camel@drew-northup.unet.maine.edu>
 <86vcyigcqy.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Joshua Juran <jjuran@gmail.com>,
	Daniel Searles <dsearles@medialab.com>, git@vger.kernel.org,
	oleganza@gmail.com
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Wed Apr 13 22:44:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA6ux-0007tN-Tv
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 22:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697Ab1DMUn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 16:43:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44108 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932476Ab1DMUn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 16:43:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 20303546F;
	Wed, 13 Apr 2011 16:45:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ybPP+rCAW4s1q6Nm/7TvCSeOyH0=; b=A+SOE8
	/XySurejLnvmwYQZQaUZj3c05Rvv5Zy9kg80g307MHYHRGa77quAOvykQjGsE5Xa
	ZUM+Ick7UKudjXa7ynxOcnW1O0EUU1ql6HQueMmbpY1rmRvJSC7HoOnie2ARbkxO
	GYUbaIeCLdKfu+qvNHjnZONy0BwGkCRsGXGxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IGmZ+JYneGLZaaDpJiuOye8lf0Ht5qxu
	xtksvRe6Cem2QdCm2peK3cc8+LqY+ThwvlWGoGjf1PbpGy7u5jlGIIKyrjKdwHaA
	uJrjXw2lrljMaYi1zvu7UmU/O/6Ggh1Z6kQsjAYpN99cCo9VhG1i9aYnLR3DFowo
	gOC180M084M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1C6C546E;
	Wed, 13 Apr 2011 16:45:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D2EA7546A; Wed, 13 Apr 2011
 16:45:40 -0400 (EDT)
In-Reply-To: <86vcyigcqy.fsf@red.stonehenge.com> (Randal L. Schwartz's
 message of "Wed, 13 Apr 2011 12:41:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03443928-660F-11E0-90F0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171487>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Drew" == Drew Northup <drew.northup@maine.edu> writes:
>
> Drew> He also clearly stated that he's not calling git command-line tools...
>
> Drew> "Gitbox neither links (statically or dynamically) against Git nor uses
> Drew> custom interfaces to interact with it. Git binaries are provided for
> Drew> your convenience only."
>
> Huh?  How do you get "not using git CLI" there?  He's not using *custom*
> interfaces, but the *standard* interfaces are more than enough.
>
> He's made new porcelein, and using the plumbing directly.  That's
> exactly why we have plumbing in git, right?

That agrees with my reading of the page.

GPLv2 section 3 (c) allows distribution of compiled executable without
source by only pointing at the place the distributor got an offer to the
source code when the distributor got the compiled executable it is passing
on, and that is quite close to (but not exactly is --- I think the
distributor compiled the executable, not passing on) what the Gitbox site
is doing (i.e. distributing executable without distributing the source).

However, 3 (c) is allowed only for noncommercial distributor that passes
compiled executable along from its upstream source, so that part may need
to be fixed, I suspect, to comply with section 3 by going in either
subsections 3 (a) or 3 (b) route.

IANAL of course.
