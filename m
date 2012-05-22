From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about submodules and absolute paths
Date: Tue, 22 May 2012 14:06:45 -0700
Message-ID: <7vpq9w2ae2.fsf@alter.siamese.dyndns.org>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com>
 <CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com>
 <7vk4043wc5.fsf@alter.siamese.dyndns.org>
 <CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com>
 <70952A932255A2489522275A628B97C31348C70D@xmb-sjc-233.amer.cisco.com>
 <CAOmKuSqRHMS+hvCXL4Ok6ReTPW-3xT9SunGeibjCCCgVk9SU6Q@mail.gmail.com>
 <70952A932255A2489522275A628B97C31348C71F@xmb-sjc-233.amer.cisco.com>
 <CAOmKuSoxf_mRJRyjXj99NQLoa+fD-HU_oUYPrJYPNTPmvhs46g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Matt Seitz \(matseitz\)" <matseitz@cisco.com>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Alexey Pelykh <alexey.pelykh@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 23:07:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWwIA-0007bI-RQ
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 23:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161Ab2EVVGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 17:06:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39955 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756496Ab2EVVGt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 17:06:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7EA7921F;
	Tue, 22 May 2012 17:06:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rln/9eVkc7VnUwpL0S/1TkmWOPQ=; b=m2Q24w
	TiMoKip43YAdUuAFpwQqroRTPdpPwU67Gq7WUxOQRpTvZGjNbcrh3wthkiamNpXC
	7jt54mIUVxpCje1J066fSd/xE9epKDykNW2zSszlpOvlggAYUV/5pa8ZD6sd9Ae0
	Atg4V+bvBG330VrRHO8E1H17hNTdCOYdrM1t4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VWL17CxiO5D6eTI8x8+xPG8vEsmbSxvY
	zxqJvO/Ps29ztGf/hmITi6vbEKLvtQSi/bB6g6smtznNY3a27yJX/WqQqx9LHY6Q
	XCu6N10OKO3xFy2RMdgjIYFbX/09ALJuRfHXQv+orArrSu55guz9FhSFXruSK/dX
	XMyUsTQgLqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEA4E921E;
	Tue, 22 May 2012 17:06:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E5D3921D; Tue, 22 May 2012
 17:06:47 -0400 (EDT)
In-Reply-To: <CAOmKuSoxf_mRJRyjXj99NQLoa+fD-HU_oUYPrJYPNTPmvhs46g@mail.gmail.com> (Alexey
 Pelykh's message of "Tue, 22 May 2012 23:25:43 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0AD73492-A452-11E1-8731-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198254>

Alexey Pelykh <alexey.pelykh@gmail.com> writes:

> Getting back to the topic, who has what opinions on it?

You wait ;-) I do not think our friends in certain timezones had chance to
see your message and think about it yet.

Didn't the submodule folks worked on the related area recently, and
doesn't the result of their work already in v1.7.10?

I am thinking specifically about the series around d75219b (submodules:
always use a relative path from gitdir to work tree, 2012-03-04).  Jens?
