From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/11] Consolidate ref parsing code
Date: Thu, 16 Oct 2014 14:51:49 -0700
Message-ID: <xmqqd29rsmx6.fsf@gitster.dls.corp.google.com>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
	<xmqqwq7zspwm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 16 23:51:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xesxi-0004rJ-0J
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 23:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbaJPVvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 17:51:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750765AbaJPVvw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 17:51:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C8F315A0F;
	Thu, 16 Oct 2014 17:51:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xm6URS5CVes1GxhC1pYXbh7zuF0=; b=AKzkQj
	WevIrCScZlZMQaxqJCDXVvw6Zfl+lgFmrlHbrGJPe/SFn+/0os8t0DZ4Tw/89xP8
	EBOZRdLWx/Oq8iJI7QdLxZcCzUjCbXjbfQ247LBocDZUEyT2KZLn3DXUKkUhZV5W
	QOAk7naY51ZhRBx1Rbi6Rr+RABa3m9l0uVfVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pZmZRFm1+NytDPiHbXIS4xgggBn+gl9a
	tEY9cVDhzC9DbNv7HtcBa+lFPmQapYIiLaDuUgM/YArt4DZvmJU8UYe4CB4ze342
	8ikI0RDaZ4/S9uIvHJMaSrYUEIqS3QwiDAZpYPtW6fDN8lhsa84pjGKifGG3bpWc
	0drwuUMvsW0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31A2015A0E;
	Thu, 16 Oct 2014 17:51:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A533715A0D;
	Thu, 16 Oct 2014 17:51:50 -0400 (EDT)
In-Reply-To: <xmqqwq7zspwm.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 16 Oct 2014 13:47:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2735648-557E-11E4-A36A-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> This is a rif on Duy's oldish patch series [1]. I started reviewing
>> his patch series, but found that some of his patches did multiple
>> things, making it harder to review. I started pulling it apart into
>> smaller changes to aid my review, and I guess I got carried away :-/
>
> Hmmm...
>
> You are aware of another large change in flight in the same area,
> and after having reviewed that series a few times I was hoping that
> you would have a better understanding of how ready the other topic
> is.  And then I see this series that conflicts with that other
> topic.  Is this your way to say that the other topic is not quite
> ready?

The last one was a rhetorical question and I regret that it came out
a bit harsher than I intended to.  I just wanted to see a bit better
inter-developer coordination, that's all.

Thanks.
