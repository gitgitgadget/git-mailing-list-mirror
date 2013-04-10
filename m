From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 09:37:01 -0700
Message-ID: <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?Q?Ngu?= =?utf-8?Q?y=E1=BB=85n?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 18:37:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPy1I-0007AL-BU
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 18:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937049Ab3DJQhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 12:37:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46701 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934881Ab3DJQhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 12:37:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3AEE12B66;
	Wed, 10 Apr 2013 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xJqnJZHcFcvrEYprajvEq9qEmdI=; b=kUqr6w
	mceu4Tp1dckHcjxd+LcvHeSThygU0ECh6aJvSvOmd6yxgk5Pvrh2H+EkaZfrBgz8
	uAX9bY82tO0Whqw7R+c2uSoCACByrbUuToxyzo7m5QHPjH8S8rxJkmHBEy2e7/yl
	PhhFqfJoFSTazTTdT1Ys/duLgpYSnWS7aCISg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aJ5WAR2FIC36ancz/68OlzIB6Qm9D+x4
	RQ4Frv4C4AdKw+/mIlf8vubiKGt8byU8O8xkm1umwtPSKK9+enPpboafF5mtA9gv
	Xtamd6nV056RXKFgwd6tfXog1gU003sDjgyM3Yyiwv3wShr2Ln2HLbOpah9335Xf
	SEe9nnzD3EA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6A2212B65;
	Wed, 10 Apr 2013 16:37:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09BF112B5F; Wed, 10 Apr
 2013 16:37:02 +0000 (UTC)
In-Reply-To: <20130410041343.GB795@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 10 Apr 2013 00:13:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFA5544E-A1FC-11E2-BFD2-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220702>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 09, 2013 at 06:19:01PM -0700, Junio C Hamano wrote:
>
>> > 	git push -- master next; # push two refs to default remote
>> 
>> ... or default "push remote" if there is one, I presume?
>> 
>> As you are giving what to push, I am assuming that
>> branch.$name.remote would not come into play in this case.
>
>...
> The missing case 4 is obviously:
>
>   dst=missing, refs=present
> ...
> Do you want to explain your thinking? I'm guessing it has to do with the
> fact that choosing branch.*.remote is about trying to push to the
> configured upstream (even though we traditionally do _not_ take into
> account branch.*.merge when doing so).

With the branch.$name.remote, the user tells us "When I am on this
branch, I want to talk to this remote".  When you did

	git push -- master next ;# case #4

on branch maint, branch.maint.remote should not come into play.

Would we want to push our 'master' to branch.master.remote in a way 

	git checkout master && git push

would do, while at the same time because we were told to do the same
for 'next', we do the same as

	git checkout next && git push

would do?  That would work if you give just branch names, but that
is not a general enough definition to cover your case #4, e.g.

	git push -- v1.2.3 master:refs/remotes/mothership/master

If we define case #4 to push to the remote.pushdefault (falling back
to remote.default), this case would do what can simply be expected;
if the earlier cases also push to that same place, ignoring
branch.$name.remote for master and next, that would be consistent.
