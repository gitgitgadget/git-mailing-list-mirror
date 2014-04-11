From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Our official home page and logo for the Git project
Date: Fri, 11 Apr 2014 12:25:17 -0700
Message-ID: <xmqqr453sm76.fsf@gitster.dls.corp.google.com>
References: <xmqq7g6z4q6b.fsf@gitster.dls.corp.google.com>
	<534578b2e22e2_af197d3081@nysa.notmuch>
	<CAH5451kNoXobbh3-WBkewvKvNeFkV0P14Z55=qDN+Ak2WGkHSA@mail.gmail.com>
	<20140411114017.GC28858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 11 21:25:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYh4q-0006QE-4T
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 21:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbaDKTZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 15:25:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273AbaDKTZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 15:25:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 935317A1D3;
	Fri, 11 Apr 2014 15:25:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fB3Zwj/EkklHtw9bSudwo+EpZ9g=; b=fb8ChY
	fInsaeyzU5QXnR/zbyZJ5gqDDK7CTUQj9dDv1VI4YuFfH3EGiPTMuie/n6PgWRA6
	EPHgJqEKTKGBguf9sac7ykKuNuonTxMEGquejsutZfpiq/ox/tluzPuw4mBSWXNU
	wwsJbQtpQBfQdkIOQbY5S7vBUpz9zY5sHxZZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FK2aX1h9gU0qRzIg5PjLiH+sOybxsEkU
	xQB+h508LynHMgXAGgYTi5EiqoZoaSgZLymlsdP9qFb6ykR6f2tPzakzF5YWDiUc
	8nEIjrvngemBQ9spPeARKbEugHEhW/W3u4rKGmlUqYucXMubviI5Xojcey3sEoOL
	z4FIG5G+SWw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A29D7A1D2;
	Fri, 11 Apr 2014 15:25:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47CF87A1D1;
	Fri, 11 Apr 2014 15:25:19 -0400 (EDT)
In-Reply-To: <20140411114017.GC28858@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 11 Apr 2014 07:40:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 04AB5748-C1AF-11E3-B5F5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246134>

Jeff King <peff@peff.net> writes:

> The git-scm.com page is mostly targeted at end users: what is it, how do
> I get it, where is the documentation. Things like a logo repository, or
> developer information is spread across various wikis and other sites.
> If there's interest, we can make "dev.git-scm.com" for such things, or
> host repositories under http://github.com/git. But we would first need
> content to put there, and somebody would need to step forward to
> organize and maintain that content.

The mention of "dev.git-scm.com" gives me a mixed feeling.  The
chasm between the developer community and casual end-users who know
about Git primarily via their perusal of git-scm.com is one of the
root causes of this confusion.  

The pages at https://git.wiki.kernel.org/index.php/Main_Page are
done primarily by developers, and between the two logos on that
page, the one that appears inside the page under "Main Page" header
has long been the logo that Git people immediately recognised as the
Git logo.  That logo originally appeared on gitweb, I think, and is
in my tree (on the other hand, the logo in question on the motion
does even appear anywhere in my tree).  We didn't feel a need to
declare it was the official logo.  That was from back when Git
community did not have strong needs for "branding".

The one on the left-top corner was one of the alternatives that
received favorable reactions from multiple people (I am not sure if
there was a clear "majority" though) submitted when we briefly had a
poll to come up with an updated logo.

https://git.wiki.kernel.org/index.php/GitRelatedLogos has many other
"Git related" logos, many of which I do not even recognise and are
nowhere near "official".

In any case, this motion is not about "let's declare the logo we see
on git-scm.com today as _the_ official one".  It is not about "that
logo on git-scm.com sucks; let's come up with a better one".  People
are welcome to do that discussion elsewhere, and I do not mind a
repository of contestants created somewhere, but personally I think
the project is too mature for that and it is too late, even though
the "bleeding-red fork" logo may not be my favorite.

The motion is about this:

    Outside people, like the party who approached us about putting
    our logo on their trinket, seem to associate that logo we see on
    git-scm.com today with our project, but we never officially said
    it was our logo (we did not endorse that git-scm.com is our
    official home page, either, for that matter).

    It is silly for us to have to say "Ehh, that is a logo that was
    randomly done and slapped on git-scm.com which is not even our
    official home page, and the logo is licensed CC-BY by somebody
    else.  Go talk to them.", every time such a request comes.

    Please help us by letting us answer "Yup, that is a logo (among
    others) that represents our project, and we are OK with you
    using it to help promote our project" instead.

That is what I meant by "our official logo" in the first message.

So,... seconds?
