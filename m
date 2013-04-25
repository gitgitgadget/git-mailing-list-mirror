From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 14:37:27 -0700
Message-ID: <7vwqrq1eco.fsf@alter.siamese.dyndns.org>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<87bo92l5el.fsf@hexa.v.cablecom.net>
	<CAMP44s1uS23OvsDY+_YOBGMgc9t=FBEV3YvM34M9sLMEF9hnTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 23:37:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVTrE-0005Ny-89
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 23:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758769Ab3DYVhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 17:37:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758382Ab3DYVhb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 17:37:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FAA019568;
	Thu, 25 Apr 2013 21:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qai7Do6eUV97c0kqsG1vMu0qPnc=; b=E9VfW1
	Xvplp8Kj3vwD6Iu4Ku60LfQG4fGckd3+iybxHQjiGdeftnTIcuwcRr2eNykKOP0c
	Dc5x8pDSnSgnUywzuaK9cTqmExbKpwm4Gm9F1i1H5j4DLTtg4sL0W5XCLRVX3ulZ
	8JTK0ZOG0vkD6kuelS850WYwAYUUk/zhebTpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YwikncwuhEl3t/54rPXPHc/TY7wjBv9t
	9T31tEbHwnFP0qyQjyCRyjezS8IH1w5DR4x5uSRZQNSJNaPlkI+AZlkrWDlbr1JL
	WApEp3ep2IUVhltlCuhJJ15ig0rR+4btxCBJc71sUBo0sYQfheaYAQhat2MfwpJh
	wyCV3aYq+kw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0428219566;
	Thu, 25 Apr 2013 21:37:30 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63AA619565;
	Thu, 25 Apr 2013 21:37:29 +0000 (UTC)
In-Reply-To: <CAMP44s1uS23OvsDY+_YOBGMgc9t=FBEV3YvM34M9sLMEF9hnTg@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 25 Apr 2013 15:52:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5464F06A-ADF0-11E2-AAA0-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222453>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Apr 25, 2013 at 3:30 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> But I do not care that much really. The patch is good either way, if
>>> you don't like it, you go ahead and fix it, because I won't. I have
>>> 174 remote-helper related patches in my queue, and nobody benefits
>>> from rambling about a one liner that is obviously correct, not you,
>>> not me, not the users, not the developers.
>>
>> You don't stick to the rules of this project, which have been pointed
>> out already:
>
> The rules of the contrib area are different from the ones of the rest
> of the project.

Yes and no. 

A contrib/ material may not be held to the same high standard, but
that does not mean a contrib/ area maintainer has a blank check to
do anything there.

It would be pretty obvious to people observing what happens in the
area after a while, if the quality standard the area maintainer
enforces is too out of whack, and at that point the area maintainer
deserves to be ridiculed ;-)

> And I don't recall Peff ever doing this "constructive
> fine-let's-do-the-work-for-him" on any contrib/remote-helpers stuff.

I do not think Thomas was talking specific about contrib/ material
but your interaction in general with other developers.

Cf. http://thread.gmane.org/gmane.comp.version-control.git/220427/focus=220891

FWIW, I thought "that person was me" response from him was more than
reasonable, and I still do.
