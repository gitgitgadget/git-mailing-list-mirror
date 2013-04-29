From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Documentation/git-diff.txt improvements
Date: Mon, 29 Apr 2013 10:40:44 -0700
Message-ID: <7va9ohjkv7.fsf@alter.siamese.dyndns.org>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
	<CALkWK0nVZHwSMS_gtisiAguNhAMnDpdWmAtz_OgzP93YZtYfHQ@mail.gmail.com>
	<7v38u9l2jk.fsf@alter.siamese.dyndns.org>
	<CALkWK0=aF2H4b9L32zvFQweYrzsJ-ZoBZ59TcECEasyy5TyvmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 19:40:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWs4J-0002TQ-Pv
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448Ab3D2Rkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:40:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55425 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757311Ab3D2Rkr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:40:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92A0D1AAEE;
	Mon, 29 Apr 2013 17:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hldzd/UscpkxtEVl0k8RK6NyWxE=; b=xXbZQ7
	iP7WUKBgKt8BHDMHt/FuIaZtGP2m70LOpcIp27+rQT/2wBAJO+hfdFFVBckj1Skm
	IMbTrAol3xsZr/DVJEcFlay5VMpBHUCsHzPko7pFPqr/xLgESsvXCS1de2k9V4vd
	sI/DUf535W0YWeRjn0fdenmFp9kLvHEev1oVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iDuMyF96cxMptiJMtgNn+q0J4joC5Q4Z
	KbSvOUH9e9RrEUlAvYkMohE8MDw9MrrfMsevmZ7GhuPCaW2Y/AHgjs8iF0ct4SMe
	ckIsljUvibyX/iq7f+clrOSCfIArlmoQNLKFSND//YiDljK04t1vh6p5tFDjevQN
	TZ7gi/orhyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 896641AAED;
	Mon, 29 Apr 2013 17:40:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DB171AAEB;
	Mon, 29 Apr 2013 17:40:45 +0000 (UTC)
In-Reply-To: <CALkWK0=aF2H4b9L32zvFQweYrzsJ-ZoBZ59TcECEasyy5TyvmQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 29 Apr 2013 22:49:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC3026A2-B0F3-11E2-B139-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222822>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> I had an impression that many of them, with the suggested fix-ups,
>> were improvements, with or without the A~B discussion.  It seems
>> that the entire review wasted many braincycles if you are to drop
>> the ball at this point, which is very dissapointing.
>
> No, I don't meant to drop the ball at all.  I'm _very_ annoyed by this
> inconsistency, and have a burning desire to fix it.  It's just that I
> don't want to fixup something now and regret it later, so I'm putting
> it off until the A~B issue gets resolved.  In the meantime, the first
> two patches are fine and can be applied as is.

As far as I am concerned, there is no A~B issue.

Please don't let it take good changes hostage.
