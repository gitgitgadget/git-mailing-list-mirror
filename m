From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 11:54:34 -0700
Message-ID: <7vhajemd1x.fsf@alter.siamese.dyndns.org>
References: <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?Q?Ngu?= =?utf-8?Q?y=E1=BB=85n?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 20:54:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0AP-0001Au-FQ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 20:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759009Ab3DJSyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 14:54:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824Ab3DJSyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 14:54:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BADDF15BDD;
	Wed, 10 Apr 2013 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BFdJ2ydOyILgbKCpYCJ7jnqMjMM=; b=kvLjwy
	hxnHMqs1LPcIYvXO6tYVND8ticVBA+SmgMShKV5fuQL3XL0qwXu4J5oVxAcizYR7
	Mp7kh07NorDBMNgD6nqUH0Tzie8L/3lyxsBkvAPml4sfPGfmNWmuTr6YBGCqMdHc
	u+1UhNgfHJ2jUfktrOdVNbIU+aunQtXvPGKss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EzSC/jAnhv3h/bAUUGhlKdT6CX9P4f+f
	IbV0+JMVqfdoLqTqkZwB1y8i3F6wy4Ae0J2jmcrfaIAq7GwvhgN0sj487MtI8wSw
	IIZwDtb1stM6d5iUG/iepZx5tR6qJgVR9v1kRN8ytY11vYEgU3Yfg/U+ubUNWrDA
	xOU5JxNZgeU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B222515BDC;
	Wed, 10 Apr 2013 18:54:36 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2DAE15BDA; Wed, 10 Apr
 2013 18:54:35 +0000 (UTC)
In-Reply-To: <20130410172748.GA16908@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 10 Apr 2013 13:27:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16CA3864-A210-11E2-B972-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220720>

Jeff King <peff@peff.net> writes:

>> With the branch.$name.remote, the user tells us "When I am on this
>> branch, I want to talk to this remote".  When you did
>> 
>> 	git push -- master next ;# case #4
>> 
>> on branch maint, branch.maint.remote should not come into play.
>
> I understand that's your position, but I don't understand _why_.
>
> If branch.$name.remote is "when I am on this branch, I want to talk to
> this remote", that rule is not be impacted by the presence of refspecs
> at all.

So running the above while on 'maint' will send master and next to
the remote your "git push" would send to when run without any
refspecs?

That is internally consistent and understandable, and I have no
objection to it.  Certainly much better than basing the decision on
branch.{master,next}.remote as I thought you were suggesting to do.
