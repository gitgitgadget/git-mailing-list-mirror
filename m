From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "lets" vs. "let's"
Date: Wed, 01 May 2013 10:18:50 -0700
Message-ID: <7v61z28vph.fsf@alter.siamese.dyndns.org>
References: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
	<CAPig+cSQeU8BaaPm7GfCUxtsVj1Ce31ygBLdkb5WN8o4aNMAow@mail.gmail.com>
	<CA+39Oz7gib+dpW1CNEHtD2M6JcOF1QuxpeOWLcyTxdVPGnS5+A@mail.gmail.com>
	<5181257C.2050108@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Adam <thomas@xteddy.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Wed May 01 19:19:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXagD-0002Cn-99
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 19:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab3EARSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 13:18:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051Ab3EARSw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 13:18:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B36E1BBD5;
	Wed,  1 May 2013 17:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cZqZ2Wk8ndIEOYg5Z/1bwMV5mPc=; b=p1Cy4H
	Jarg4VMsK5kLTP0AWbEZdTMeDxCBA5X3afZozkkCsy5Tugkcq0I3PmQ9/IGek3Au
	6pK/VA764yFlwIWzTzePV9NhC0DhzL5CMe/ZwG1Cge8TyLSF+z/24HCrLsZMojd9
	8VAlP//onoUT/9SUnPp1H70FlhMWbAwp72H8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tDJMcsLqWv7n+oz3MGTv5XC6T+Ijk82S
	gsbVy6dL6C1WLxlaYAmSNlKP9dZF7SMR2/Id3HhE4Ar8NfVs9iVxWon6cCIMr4jb
	s9EUIqiF6q24LerKsFNHpfb937n+XOzDE6MiAss910P3Vh8wGYTyWd2yd4l2bRu0
	o3zO9VQkJrk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F22461BBD4;
	Wed,  1 May 2013 17:18:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DD691BBD1;
	Wed,  1 May 2013 17:18:51 +0000 (UTC)
In-Reply-To: <5181257C.2050108@xiplink.com> (Marc Branchaud's message of "Wed,
	01 May 2013 10:23:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3175A5DA-B283-11E2-A5CC-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223103>

Marc Branchaud <mbranchaud@xiplink.com> writes:

> On 13-05-01 06:31 AM, Thomas Adam wrote:
>> On 1 May 2013 11:12, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, May 1, 2013 at 5:51 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
>>>> remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
>>>> can't remove '{0}'?
>>>>
>>>> This patch allows '@' to be the same as 'HEAD'.
>>>>
>>>> So now we can use 'git show @~1', and all that goody goodness.
>>>>
>>>> Until now '@' was a valid name, but it conflicts with this idea, so lets
>>>
>>> s/lets/let's/  (contraction of "let us")
>> 
>> Ah, the contraction versus the first person singular.  In this case
>> where the context is concluding in decision, rather than making a
>> statement ("Let's go to the shops", for example) then "lets" is the
>> correct word to use here.
>
> You've lost me.  I think Eric is right.  If "lets" is a verb in this
> sentence, what is its subject?
>
> Besides, of which verb & tense is "lets" the first person singular?  Never
> have I "lets" anything in my life...  :)

I'll queue with:

	... '@' was a valid name, but it conflicts with this idea,
	so make it invalid.

That is, just use the imperative mood to give an order to the
codebase to "make it so", which is a common style of log messages in
this project.
