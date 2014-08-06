From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry picking and merge
Date: Wed, 06 Aug 2014 16:16:48 -0700
Message-ID: <xmqqzjfhky3j.fsf@gitster.dls.corp.google.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
	<20140801200201.GS12427@google.com>
	<20140801205040.GT12427@google.com>
	<CAK3OfOhbJJqLB4yPbuJyufytxNUSBLzKF6axc4jeU7eAjvXtgA@mail.gmail.com>
	<53E25090.7010803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nico Williams <nico@cryptonector.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 01:17:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFASF-0002Kl-K1
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 01:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbaHFXQ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 19:16:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55030 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472AbaHFXQ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 19:16:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EA6830C5B;
	Wed,  6 Aug 2014 19:16:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bRCZG9ZYUTdl
	7mB/MbWmDFD0mGY=; b=bpwT8Vf/P0ry+V5iiGaMwa4ThtkKC8PHLFP6X/8gFnFs
	ET5jSNXK5uMkrtHJmgT1WS3wClv7kGBEkpK0T++O1XrWVJM7kI3Cw651pQIijSD/
	qzpvE6XZGUiqnCYhJV6r5Gij7ZqaNV5QP+dijGvGaVYIE9ODLByjb0PgqJBHnYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VvbfKn
	ZT7sled107uMwNtlCZGHT+is0g0LQOnWUqgbzkhJRN87o0PmkHghs5odVIijt0U9
	PjChfo+fxtGG74HejiwPKk0iDc8uz15IuCoD4BgwNVz/H+d+euttszJB7xDVgoSW
	PIZ/dO92g0cRHRAfqE9Ly6d0oJ5Y8fEe4ypPw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 655A130C5A;
	Wed,  6 Aug 2014 19:16:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5EA8730C51;
	Wed,  6 Aug 2014 19:16:50 -0400 (EDT)
In-Reply-To: <53E25090.7010803@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Wed,
	06 Aug 2014 17:58:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BEBD633A-1DBF-11E4-A8E9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254913>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> There was (long time ago) a long thread about idea of adding some
> kind of 'weak' references (links), 'weakparent' that can be
> automatically used by Git but do not pollute the commit message,
> and do not affect reachability calculations.  Ultimately it went
> nowhere (as you can see) - there were many problems.
>
> For example: how it would work for reverts and rebases?

Perhaps some digging in the list archive before typing is in order.
This may be a good starting point.

http://thread.gmane.org/gmane.comp.version-control.git/46770/focus=3D46=
799
