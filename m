From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An idea for the "Leftover Bits": rebase -x to imply -i
Date: Wed, 16 Mar 2016 15:51:09 -0700
Message-ID: <xmqqlh5i2g0y.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kZg3QkfjB1hwZKRS9Hqg-1H=kQwuwByX_rAMzveXtnp7Q@mail.gmail.com>
	<xmqqy49i2hhe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 23:51:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agKHc-0003sS-QQ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 23:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935047AbcCPWvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 18:51:14 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933308AbcCPWvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 18:51:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F02714EBE4;
	Wed, 16 Mar 2016 18:51:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7UOJ9rX+RUbDUXpo17XHfMm5Seg=; b=F74TPT
	Tmjui8R4aQ9ifhrp5qkIc/Yx+pM7TYWJIbSRPAA9GVUDshyPe3HvJgQGKY/EUZ/n
	BPQqXMRWfNT1b+0E2bKxAgumuhhEzNPwps2MUuBLPsUMJJ0sTT3OQos7Ujxpbp/n
	vtxC603exkyL7S+5FNNXwUCBN1yPLbQX5CLWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SVnKjLJmwTNJv+GIsDDVHDc19e5qiiUo
	U8tnJQgsdfi+kNSiuF2VzQG9jKCdhjs6McXCIttlvohdiutlPNDhf88CjsjRN5s6
	vggZ7YbXabRIM0BaBLWW2EN+YD3AaHpGi8GYktuIvg6QNPE25OVRAEjiPcog9DUI
	WVUi2tyfDoQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E779A4EBE3;
	Wed, 16 Mar 2016 18:51:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6F3794EBE2;
	Wed, 16 Mar 2016 18:51:10 -0400 (EDT)
In-Reply-To: <xmqqy49i2hhe.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 16 Mar 2016 15:19:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 93C3A6E2-EBC9-11E5-916B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289057>

Junio C Hamano <gitster@pobox.com> writes:

> The list is my personal collection of "leftover" things, i.e. topics
> that were raised on the list, perhaps already discussed or perhaps
> nobody thought them interesting, that I found when re-reading the
> past list traffic that did not reach a useful conclusion to result
> in a patch (or resolution, a shared understanding, that it is not a
> good idea).  Getting added to the list should not be a goal.
>
> Your message is perhaps the least effective way to add an item to
> the list.  It hasn't been discussed here, nobody seems to have felt
> it is a good idea, and I didn't think it is particularly interesting
> myself (at least not yet).

Having said that, I could use help in maintaining the collection.

A few "characteristics" of that list, that cannot be updated by
anybody but me (because it is just my personal collection after all)
are:

 * I do not have to worry about useless new entries that do not
   align the overall system design getting added by clueless people.

 * Adding new entry after scanning past list traffic and finding a
   still unresolved topic that "died down" is relatively easy.

 * Removing existing entries because the topic was revived on the
   list and completed is _hard_, as that is merely an administrative
   overhead to me.

Moving it to a public wiki would lose the first point, which is a
benefit.

Merely making it public does not guarantee that the third point
(i.e. clean-up) would happen more easily unless we have volunteers.
It is likely that the "leftover bits" list would go stale just like
other people's wikis or bug trackers.

On the other hand, if we do have volunteers who are scanning for
"stale" items in the "leftover bits" list to tell me "that item was
done with commit c0ffee1eaf" and that would help me quite a bit
without being it a public wiki/bug tracker.
