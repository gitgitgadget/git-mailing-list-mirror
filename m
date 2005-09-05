From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Sun, 04 Sep 2005 18:35:39 -0700
Message-ID: <7vwtlw9tzo.fsf@assigned-by-dhcp.cox.net>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 03:35:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC5tg-0001Zl-PS
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 03:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVIEBfm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 21:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVIEBfm
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 21:35:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:59864 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932138AbVIEBfl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 21:35:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050905013541.MAUP3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Sep 2005 21:35:41 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl> (Horst von
	Brand's message of "Sun, 04 Sep 2005 20:54:12 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8076>

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> I had the same opinion.  The counter-argument people raised when
>> this topic came up on the list was that it would help grepping
>> in the source tree.
>
> Grepping for what?

I am only a messenger for their argument and, as I said, I did
not particularly buy that argument because I myself do not find
it too disturbing that a grep in my built tree says "Binary file
libgit.a matches", especially I typically run grep in my Emacs
buffer and C-x ` (next-error) does not get confused by such
useless hits.  But I can understand why it matters to people
working in other environments.

> In any case, this would be for a very specialized,
> developer-only, occasional task. I don't see how that warrants
> a fractured tool namespace for /all/ users /all/ the time.

Yes, you convinced the convert again.

Now I have to find a poor unsuspecting volunteer to do the
actual heavylifting after 0.99.6 happens ;-).
