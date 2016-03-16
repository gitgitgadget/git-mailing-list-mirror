From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An idea for the "Leftover Bits": rebase -x to imply -i
Date: Wed, 16 Mar 2016 15:19:41 -0700
Message-ID: <xmqqy49i2hhe.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kZg3QkfjB1hwZKRS9Hqg-1H=kQwuwByX_rAMzveXtnp7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 23:26:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agJtx-0002LC-T5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 23:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966914AbcCPW0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 18:26:44 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966998AbcCPWTp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 18:19:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94E214E5BF;
	Wed, 16 Mar 2016 18:19:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mvUpKlcqzQYDCvRDpkDKZ3RXoxI=; b=bivveR
	4MLHdY1tEn0J5Q8Uqg/pRaFRCqcNbV4Iuc8RYOYNe2y+MvYSlfOL8hkMi4LLmmPR
	Nj/BIOGLwyMBucthTd0E5aj0cTGmXnqRbFOIx7w6aUnWTIqGNzjlqhZVcGpV/Yxw
	JiX/HoaH1xAsiRPqg1ZW6Z1us1YMZyKKO4+Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uyRP2iRsmuVLPoeLiwxhhyVVh1H1J+xN
	1JVpo6mvIsAOP9U3yI6FEuzFZp/Jpk2xynkM5sl9O3A+d7j61CYTfTJEWTvQH4j5
	SDdONW0UMbjiawJLV+ySoZB5GuV8zGz8v0Cr56w12TuGNlAj5IWmXSix6i3WvBb1
	qpdyML8VY5E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B8F44E5BE;
	Wed, 16 Mar 2016 18:19:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 13FA24E5BD;
	Wed, 16 Mar 2016 18:19:43 -0400 (EDT)
In-Reply-To: <CAGZ79kZg3QkfjB1hwZKRS9Hqg-1H=kQwuwByX_rAMzveXtnp7Q@mail.gmail.com>
	(Stefan Beller's message of "Wed, 16 Mar 2016 14:12:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2ECD4F44-EBC5-11E5-9993-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289054>

Stefan Beller <sbeller@google.com> writes:

> here is an additional ideas for the "Leftover Bits" on git-blame.blogspot.com
> (Is there another way of contributing these, such as sending a patch
> against some
> repository? Or any other way which may bother you less?)

A message "Subject: [RFC] ..." that asks "Wouldn't it be wonderful
if command X is extended to work like this way?", without even
mentioning "leftover bits", would be far more useful.  Instead of
going nowhere waiting for the next round of "leftover sweep" picks
it up to add it to my "leftover bits" list, it may even find a
traction here ;-).

The list is my personal collection of "leftover" things, i.e. topics
that were raised on the list, perhaps already discussed or perhaps
nobody thought them interesting, that I found when re-reading the
past list traffic that did not reach a useful conclusion to result
in a patch (or resolution, a shared understanding, that it is not a
good idea).  Getting added to the list should not be a goal.

Your message is perhaps the least effective way to add an item to
the list.  It hasn't been discussed here, nobody seems to have felt
it is a good idea, and I didn't think it is particularly interesting
myself (at least not yet).
