From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Sat, 24 Oct 2009 20:08:47 -0700
Message-ID: <7vy6n02mrk.fsf@alter.siamese.dyndns.org>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
 <7vy6n065os.fsf@alter.siamese.dyndns.org>
 <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
 <94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 04:09:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1tTz-0004SA-6w
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 04:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbZJYDJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 23:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbZJYDJH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 23:09:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbZJYDJF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 23:09:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A4733663BA;
	Sat, 24 Oct 2009 23:09:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aVNCqkle5FqJxS67WqvrDnuuRlQ=; b=Ewlx5g
	eBXFOwHkx0HCR3tvofHeaWKv88/+TBRfUNeZAwVoapAtA5xZb7igH0QkuYkR71ib
	0apjhqOrsu2DlhEw0BRDnsfec7chzVJQ65bxI6+P/xFWbM4mMuJCzB7wwMgJkeq9
	Twc1PUA62yoAOEWfmszv4UmDAd2HM22iU63k4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rlh8yAZGT/37ynlryNyicTT9ilddJABk
	TWTzqu33XFWIJ1PZuLT0UykszMsZRP40T24d+DXDOcfzEMHXeiFdE3GHVeKz0LBY
	1dzIe5HMAaRW+Eb1+0RF/+yCGdMcjgA7dITgdapped4O6wF7vYjH2AcPk09hyFzK
	xoAZR9DYvug=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28416663B9;
	Sat, 24 Oct 2009 23:08:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7813663B8; Sat, 24 Oct
 2009 23:08:48 -0400 (EDT)
In-Reply-To: <94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>
 (Felipe Contreras's message of "Sat\, 24 Oct 2009 23\:16\:51 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BD3FAB70-C113-11DE-A1E9-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131187>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> I'm inclined to to discard the first patch.
>
> And you decided to mention that after many people including you, have
> agreed that it's a good idea?

This line of argument is wrong and counterproductive.  Of course, after
reading what others said and thinking about it more myself, I can change
my mind based on their opinions.  Otherwise there is no point in having
any mailing list discussion.

People propose changes, and two things can happen:

 (1) I and others may think it is not a good idea, clarifying argument may
     come from the original author and/or additional arguments defending
     the change may come from others.  People who thought it was not a
     good idea may change their mind, and the patch gets accepted.  git
     becomes better.

     If people cannot change their mind, it is useless to make supporting
     arguments to nudge them to reconsider.

 (2) I and others may think it is a good idea, a counterargument comes,
     and people who originally thought it was a good idea may change their
     mind, and the patch does not go in.  git is saved from becoming
     worse.

     If people cannot change their mind, it is useless to make counter-
     arguments to nudge them to reconsider.

Yes, I originally thought a "getting started" section may be a good idea.
There is no need to point it out to me.

But after I saw that the original author said "_if_ we have to do this,
keep it short", the comment made me question my previous assumption one
more time: is it really a good idea to add "getting started", and is it a
good idea to cover the config command in that section?

After re-reading the first thousand lines of the user manual, I realized
that the explanation was carefully laid out so that you do not have to be
taught "git config" in the beginning to be able to follow it.  Now, after
applying your latest patch, if we do not have to teach "config" there,
what else is left in the section? --- Nothing.

What conclusion do you expect me to reach after such a consideration,
other than "then let's not have it"?

> If you read the results of the last git survey you'll see that the
> area that needs most improvement is the documentation.

Yes, I did read it, but what about it?  You already know we both want to
have a good set of documentation.

Remember that "changing" and "improving" is different; some changes may
not necessarily be improvements.  "It needs improving, so let's change it"
is not an argument.  This isn't obviously limited to the documentation but
also applies to UI changes.

> Also I still
> see many people doing commits without configuring the user name and
> email properly and so I've tried very hard to improve the user manual
> to make it easier for them to understand they must do that.

The "unconfigured user.name is wrong" is the least of the problems for
people who start commiting without understanding the basic principles.
People may ask "how do I publish my changes", "how do I discard the
commit" and "how do I modify the commit two days ago", and teaching them
things like "reset HEAD^" and "rebase -i", without making them aware of
the implications will do disservice to them in the long run.  That kind of
self-teaching is already done by people (and for doing so sometimes they
hurt themselves) by diving into man pages of individual commands before
understanding the distributedness and its implications, and my hope has
always been to keep the user-manual a document that teaches things in one
coherent and hopefully the most useful order.

The early part of the manual (the first thousand lines) does not talk
about making commits but lays out the groundwork for a good reason.  And
in order to follow the current structure of the manual, you do not need to
be taught "config" as the first thing.

It is a totally different story if we are going to rewrite the manual in
such a way that we start from "hello world".  I am not necessarily saying
it is a bad way to teach [*1*].

But the current "starting from a sightseer, while learning the basic
concepts like reachability and stuff, and then learn to build on top of
others' work" structure would also be a valid way to teach, and in that
presentation order, I do not think teaching "config" sits well at the
beginning.


[Footnote]

*1* Indeed, the book I did recently does just that, starting from a solo
user who develops on his own from scratch, and then uses another
repository as a back up repository, and then works on two different
machines with a repository each, still working solo no the same project.
After that working with other users collaboratively comes. If you teach in
that order, you have to cover config before you cover commit, which pretty
much means config is mentioned at the very beginning.
