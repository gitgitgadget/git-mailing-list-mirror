From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH maint 0/10] Re: [PATCH v2] Fix various typos and
 grammaros
Date: Fri, 12 Apr 2013 09:09:19 -0700
Message-ID: <7vfvyvg28g.fsf@alter.siamese.dyndns.org>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com> <7v4nfch90r.fsf@alter.siamese.dyndns.org> <20130412064837.GA5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	sunshine@sunshineco.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:09:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQgXh-0006tn-Cg
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab3DLQJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:09:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60867 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864Ab3DLQJc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 12:09:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D038D1381D;
	Fri, 12 Apr 2013 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A5MuzZI5466foS5oYcQx20X0Ck8=; b=lvv2Z0
	toKqJw4Wf9UZyFMhBZRWMxdzWNDA8LguBTtI+TFRvNRUFDIjCPERcLC6c8p3Y79u
	kw9GCwgteGMdP22LgCsuNz/NsjflsGAvd624BXcJaUuoCjRFjbKk/uBlXtSxBmGb
	7RpT0E33kfb8JI5DV00eGspNHR8HuyDp5SF/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cOmvzL8iex+/4xfKAaj4B6gWC1PYEf+t
	ITlxH66awkoLd1PRbEwIM9bLaozBke0/gsO9ldLzHSFm3ZqTpNO528+vF4uPPima
	PL7vlY2NjDKMF7skaJWg3fKC+p8Wex5lX+0b8RWY1mYxixtXKUYyqO6HRC/kDVrt
	r0LA5U7ppy8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C76501381C;
	Fri, 12 Apr 2013 16:09:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56E2E13812; Fri, 12 Apr
 2013 16:09:21 +0000 (UTC)
In-Reply-To: <20130412064837.GA5710@elie.Belkin> (Jonathan Nieder's message
 of "Thu, 11 Apr 2013 23:48:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56075288-A38B-11E2-B907-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220993>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Junio C Hamano wrote:
>
>> How much of this stuff have interact with real changes that are in
>> flight, with various doneness cooking in different integration
>> branches?
>
> All except the t3511-cherry-pick-x.sh change apply cleanly to
> "maint" and merge without trouble with master and pu.
>
> Here is a split-up version.

Thanks.

> I haven't looked closely at the patch,
> even to sanity check it --- one of the main points of splitting it
> this way is to make it easier to review with reference to code
> borrowed from other projects.

Sure.

> Some of these patches need more work if they are to be applied.  For
> example, git-gui is maintained separately and should not be patched
> from the toplevel.

True.

Thanks.
