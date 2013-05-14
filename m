From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Tue, 14 May 2013 15:33:32 -0700
Message-ID: <7v7gj1fayr.fsf@alter.siamese.dyndns.org>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	<7v1u99lb8w.fsf@alter.siamese.dyndns.org>
	<CAMP44s1rZmo3cQecGmYVMZ7KSq=z3_mfVnAK+so4QL_JfEe_uw@mail.gmail.com>
	<7v8v3hi9ix.fsf@alter.siamese.dyndns.org>
	<CAMP44s2B3bFWXZe0aL_GMXe_56MbhSZXf-65rT364nY3shYwUA@mail.gmail.com>
	<CAMP44s16VD+Rm5J=TXxQB+pKhpzHqoxBXSSwDvi0CVW2u2J=5g@mail.gmail.com>
	<7v4ne5i7lf.fsf@alter.siamese.dyndns.org>
	<CAMP44s0CgYs9s1ac1EEqhP8XusScj39zY6CcQyMxSnh6i-V6SA@mail.gmail.com>
	<7vvc6lfc98.fsf@alter.siamese.dyndns.org>
	<7vk3n1fbus.fsf@alter.siamese.dyndns.org>
	<CAMP44s2L9CsLu+hr4McVzUnb7x+uipEs5nHKLg+69BicMaJjpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 00:33:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcNmu-0004QT-Fw
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 00:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758395Ab3ENWdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 18:33:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758091Ab3ENWdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 18:33:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E1261EB51;
	Tue, 14 May 2013 22:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VediDLzuIqEVUtySFxvIKYkqr3A=; b=O8Drm8
	R7eZk2waHFpq+T1YMKpyU/y6CkfPxo4w67RhVDjETvH71vnOWLYHr2uwkeNyJGZd
	mNwIFlG4WkamGz6/YudyoOu+ojdKP15C2lHiF3EEs1rKr3H0VHoVVOvL3mjDbddy
	FSyxWsYCZj8plsFrV3lhmQJlRdXxy4TjnKJjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kudwrlvcHiqcO3IUb77hyEAgvGtIdQop
	CvHRw8g78z55zWC7zZwwxz0xsdr6WWBo+fzU57yWPtlPmuLCSgusLajNyWL0NvLn
	odFXuJwzsD66ViLJi15itwE6yp5W+hP/fzfW4i+9zl31hqMtDputrukHG9Owycnp
	uDoolmC992M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 722581EB50;
	Tue, 14 May 2013 22:33:34 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C49E41EB4B;
	Tue, 14 May 2013 22:33:33 +0000 (UTC)
In-Reply-To: <CAMP44s2L9CsLu+hr4McVzUnb7x+uipEs5nHKLg+69BicMaJjpA@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 14 May 2013 17:17:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F93F4AA-BCE6-11E2-B6E6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224362>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, May 14, 2013 at 5:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> And the clone would happen either way, with or without this patch,
>>>> because 'hg/origin/master' doesn't exist, the only purpose 'hg/origin'
>>>> serves is to block the new feature.
>>>
>>> That is the answer I was trying to extract out of you (I take the hg
>>> is a typo for bzr in the above, though).
>>
>> Just to double check, I understand that the justification for
>> removal is this:
>>
>>      If a clone exists with the old organization (v1.8.2) it will prevent the
>>      new shared repository organization from working, so let's remove this
>>     -repository, which is not used any more.
>>     +repository. It is not used by 1.8.3, and did not host any useful
>>     +information in the code in 1.8.2.
>
> That is not true. It did host useful information in 1.8.2, if we apply
> this and the user tries to pull with remote-bzr from 1.8.2, it would
> need to be cloned again.

So the answer to my original question:

    So we nuke that and have them clone from scratch?

is now "Yes, unfortunately, but it happens automatically inside
remote-bzr and the users won't have to do anything extra"?

That is the kind of honest description I wanted to see.
