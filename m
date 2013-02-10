From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/15] user-manual: Use --format=tar.gz to create a
 gzipped tarball
Date: Sun, 10 Feb 2013 14:52:23 -0800
Message-ID: <7vk3qfrdco.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <92a02e35df3dab70928e56e6790417243beea2af.1360508415.git.wking@tremily.us>
 <7va9rbst37.fsf@alter.siamese.dyndns.org>
 <20130210223239.GE8377@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:52:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4flZ-0001X9-JR
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145Ab3BJWwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:52:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40639 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757048Ab3BJWwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:52:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39BA4C251;
	Sun, 10 Feb 2013 17:52:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zBnDYXJGITbgjl0ZxG6ZsEOGEdY=; b=sX+0fv
	5MxgoAU6Ti/2qZ5UVkN05/536a/MaWP/dROcMWy3pwynsrX6aX6RrexVilhHK+kO
	DjjwfkZXhqgehl2gkO6Ed9Zu4SI5vBV65ZLARte92Aojg7kVzyBRr9HjAUfDq9Hc
	Xo+40u3rE8nZmCfNOjf5O1gUCIhMMBJOKJeLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Do1OyVaAFsuNg0X41cnGbtqhbuPv6X4b
	VzpCIwFSYhMpyec/THz04dEthTDqpu1NOBe6CTTOJyVQR1nIzug9gBy9VsuTLJ7A
	eS7RO2PtcGeTxaofHINCufckyCxQqKYtYv5l2FXvmI/MZX34pylg0ka9O4biE2+6
	J8wRyLrqphU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A345C24B;
	Sun, 10 Feb 2013 17:52:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2080C240; Sun, 10 Feb 2013
 17:52:28 -0500 (EST)
In-Reply-To: <20130210223239.GE8377@odin.tremily.us> (W. Trevor King's
 message of "Sun, 10 Feb 2013 17:32:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BC9902A-73D4-11E2-99DC-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215965>

"W. Trevor King" <wking@tremily.us> writes:

> On Sun, Feb 10, 2013 at 02:27:08PM -0800, Junio C Hamano wrote:
>> This is a "meh" at least to me.  Unless it uses something like
>> 
>> 	git archive -o latest.tar.gz --prefix=project/ HEAD
>>         
>> it is not all that interesting.
>
> Great suggestion.  My original goal was to remove the pipe, but if we
> can remove the redirection too, that's one less POSIX-ism for newbies
> to wonder about ;).

I was referring to more about the implicit format recognition not
pipe.
