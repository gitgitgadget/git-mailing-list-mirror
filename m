From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Composing git repositories
Date: Wed, 03 Apr 2013 23:40:05 -0700
Message-ID: <7v7gkilry2.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
 <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org>
 <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de>
 <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de>
 <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <20130331225747.GB11704@elie.Belkin>
 <7v7gkkern9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 08:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNdqi-0003ml-Pv
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 08:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763727Ab3DDGkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 02:40:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755816Ab3DDGkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 02:40:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5452011D0E;
	Thu,  4 Apr 2013 06:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5mOtPwVi11djHhoOujc5PAtYTMQ=; b=p1rZtI
	+KIic7Ed05GxOKrlG6cym53m6MbJ1PncMXcpGW+cosIKwZZ93CJ7C4wraaKN4QqJ
	tRg0AceZ+UXFKidjnAB/pRMiSgHFKxR4cugOa2tvrhszVoWCSKiSes6FZy98oZ62
	efiUJX4qxOv/Emeikwf2z0B6VZ705ViY0DYOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fbcC3moOLQAuXHD/jJWbc3kbl6Jd/gXm
	NV5fJrGgZp8Ca0Y6SreEjvpQsqo91Ah+TIXB5PZOQnEv9C9z9iAf/RvctFS1hlT5
	O9WHY3lZavMR6gefGqWBhoBUJmYSu7qJ/gRXNH79s09Er+H2yZSAy6nExjfKwnIm
	XoA6MvlTKEs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47FB511D0B;
	Thu,  4 Apr 2013 06:40:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB03511D09; Thu,  4 Apr
 2013 06:40:06 +0000 (UTC)
In-Reply-To: <7v7gkkern9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 02 Apr 2013 11:03:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D00B5CC-9CF2-11E2-97C1-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219986>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> If you are curious, at a quieter time it might be useful to ask for
>> pointers to the discussions that led to the current design, and folks
>> on the list might be glad to help.
>
> Not on the current design but the discussion before that round that
> influenced the outcome greatly was this:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/14486/focus=14492
>
> where we discussed a separate "gitlink" type of object.
>
> And obviously this discussion is also a must read:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/44106
>
> I vaguely recall asking (or seeing somebody ask) why Linus ended up
> with using "commit in index" without introducing a separate gitlink
> type, but I didn't find it.  IIRC, the answer was "it turned out
> that we didn't need it" or something like that, which I tend to
> agree.

Found a bit more relevant and probably more important (at the design
level) discussion history for people interested in understanding why
the things are as they are (without which we cannot make progress
while avoiding mistakes):

 http://thread.gmane.org/gmane.comp.version-control.git/15072
 http://thread.gmane.org/gmane.comp.version-control.git/31941/focus=32302
 http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47621
