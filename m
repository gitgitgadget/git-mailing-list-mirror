From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Fri, 12 Dec 2008 19:35:03 -0800
Message-ID: <7v1vwc928o.fsf@gitster.siamese.dyndns.org>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 04:37:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBLJZ-0003bA-Hx
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 04:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbYLMDfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 22:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756150AbYLMDfP
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 22:35:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbYLMDfN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 22:35:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EFBE086400;
	Fri, 12 Dec 2008 22:35:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AC4FB863FF; Fri,
 12 Dec 2008 22:35:05 -0500 (EST)
In-Reply-To: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk> (David
 Howells's message of "Fri, 12 Dec 2008 18:28:27 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B9A22BE-C8C7-11DD-8958-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102984>

David Howells <dhowells@redhat.com> writes:

> Add a guide to using GIT's simpler features.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  Documentation/git-haters-guide.txt | 1283 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 1283 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/git-haters-guide.txt
>
>
> diff --git a/Documentation/git-haters-guide.txt b/Documentation/git-haters-guide.txt
> new file mode 100644
> index 0000000..51e4dac
> --- /dev/null
> +++ b/Documentation/git-haters-guide.txt
> @@ -0,0 +1,1283 @@
> +		      ===================================
> +		      THE GIT HATER'S GUIDE TO THE GALAXY
> +		      ===================================
> +
> +By David Howells <dhowells@redhat.com>
> +
> +Contents:
> ...
> +============
> +INTRODUCTION
> +============
> +
> +So, you want to do some Linux kernel development?  And you hear there's this
> +piece of software called 'GIT' that you probably ought to be using when dealing
> +with the kernel community?  Then you find out that not only was Linux started
> +by this Linus Torvalds person, but GIT was too!  Perhaps it doesn't seem fair:
> +Linus has not just _one_ huge piece of software named after himself, but _two_!
> +And on top of that, globe spanning hardware vendors just queue up to give him
> +all the herring he can eat!!
> +
> +Then you look at webpages about GIT.  You look at the manpages!  You run the
> +commands with --help!  And you *still* don't know how to do anything complex
> +with it!!  You feel certain that there's some secret rite you have to perform
> +to become a GIT initiate - probably something involving two goats, an altar and
> +a full moon - oh, and lots of beer (we *are* talking about kernel developers
> +after all).
> +
> +Then you ask around, and people look at you blankly, hedge or say that it's
> +easy and obvious (they should know - they wrote the damned thing).  You realise
> +that the manpages are more an aide-memoire and that what you really want is
> +some sort of crib sheet; something that can hold your hand whilst you cut and
> +paste things from of it until you can see the point.
> +
> +Well, let's see if I can help...
> +
> +
> +DISCLAIMER
> +----------
> +
> +I don't really know what I'm doing with GIT...

I think this patch is good up to this point.  It is mildly funny and there
would exist some people who share the same sense of humor as the above
paragraphs (I am unfortunately one of them, though).

I've only skimmed the remainder of the patch, and found there are quite a
few technical errors and deviations from standard terminologies that I do
not care to enumerate (I do not have infinite amount of time).  They make
me suspect that anybody who tries to learn from this document would be
harmed rather than helped in the longer run.

The document could be a good addition if the remainder of the patch is
replaced by a collection of links to better introductory documents that
are already available on the net, IMHO.
