From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please review this pull request for maint branch with update of
 de.po
Date: Fri, 11 May 2012 12:21:37 -0700
Message-ID: <7vipg2le0u.fsf@alter.siamese.dyndns.org>
References: <CANYiYbFf73hVen2sg1viNrXxt-g+tP=bF_ryBF8JYp0ZAL0b6A@mail.gmail.com>
 <CANYiYbFiwvy8Lw+XQTehbc3k2FukrvhCvR6urfAR_3xVqXxNZA@mail.gmail.com>
 <7vtxzr1kbd.fsf@alter.siamese.dyndns.org> <87ipg75drv.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 11 21:21:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSvPP-0004bu-9M
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 21:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760854Ab2EKTVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 15:21:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760812Ab2EKTVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 15:21:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECCBA645C;
	Fri, 11 May 2012 15:21:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DwhojanFDgXpM3piGKvPviKkP1M=; b=XwoM07
	SPjs/otbiQGT79ItCHaWxKG+P3ctzBWCWlzGBDz/YANbUQtELuyl+W7Yxe4ma6Az
	Xp+Sm04GW7MWfMU5GzyOSK+HeceffeyMelbS8owdq8+K7JE6dcpk/JMhBsydBRFu
	eEARHnT4qs4RbewVVt00Ci8VVeOeImud6pJ7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w3+WizgqTUj3E9j4yqkww1cT2OAXJ/U1
	WLlWYuJiLj4Z/TUm9INU6+yGTzp3ceU58jNsm3lQTSklij9JEUw46+5rRQE+CXcX
	bXQ6e08ThkZgn9tMpVq90YFkxcHIeGRw4Fs4W3P7zIzyMg5gsmx7BNCfZt2r82YE
	zajMAl9Dm6I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3648645B;
	Fri, 11 May 2012 15:21:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45DC7645A; Fri, 11 May 2012
 15:21:39 -0400 (EDT)
In-Reply-To: <87ipg75drv.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 8 May 2012 09:32:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8862DEE6-9B9E-11E1-8C49-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197689>

Thomas Rast <trast@inf.ethz.ch> writes:

> But for next time, can there be another solution?  It seems that this
> process will make it very hard in general to keep the git-gui and core
> git translations in sync.

That unfortunately is fundamental in the way git-gui and the core git are
related to each other, and the story is the same for gitk.

The arrangement to pull only in one direction comes from the initial
desire from the maintainers of these "merge -s subtree" merged projects.
These source trees are designed to be usable without being embedded inside
a source tree of the core git, and when people want to work only on one of
these projects, their clone will not have to carry any material from the
history of the git core side.  The git core side didn't _have_ to have
them as part of its tree, but because it makes distribution to end users
more convenient, and that was the reason why we have these as part of our
tree.

Theoretically, we could ignore the wish of git-gui/gitk projects and apply
patches that touch these two parts directly to the git core tree, and let
the maintainers of these projects deal with the consequences.  They can
cherry-pick only a part of your commit from the git core tree to their
trees while still retaining their independence, for example, and my next
merge from them will see "both sides added identically or made identical
changes", which is not a huge deal.  But that adds burden to integrators,
which is not a scalable solution when contributors can make the burden
smaller.

The downside is of course the two projects won't be synchronised, but that
is inherent---the contained projects do *not* want to be synchronised in
the first place.  The price these projects pay is that they cannot affect
what is outside of their trees (e.g. they cannot add test scripts to our
side to test the new feature in their new tree).

Another downside, once "merge -s subtree" is made, is that tracking
changes in such a semi-subproject in the context of the containing project
becomes harder, as we will continuously seeing what is essentially a
renaming merge.  But it still is manageable as long as the merge is in one
direction only.  When inspecting the history of the contained project, you
only need to find the last such merge to the containing project, and then
follow the history of its second parent, whose history will _not_ contain
anything from the containing project.

The recent contrib/subtree merge (not to be confused with "merge -s
subtree") follows quite an opposite approach from what was used for
git-gui/gitk.  It decided to cease to be an independent project to
eventually integrate it as a part of the core, and further development of
it will happen in the context of the layout of having the top of the last
of its tree at contrib/subtree.  Because it has involved a merge in the
"merge -s subtree" style once, it is harder to track its history beyond
that point, but by being the part of the larger tree from now on, we only
have to suffer once---it is inconvenient to inspect the history before the
merge, but that is a one-time transition pain.

Incidentally, that is why I would be _very_ reluctant to take further
merges for contrib/subtree if the merged history contain "git subtree"
merges that ran "merge -s subtree" in both ways.  It makes what is
supposedly just a one-time transition pain to continuous one.
