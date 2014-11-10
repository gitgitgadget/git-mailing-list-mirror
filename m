From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2014, #01; Wed, 5)
Date: Mon, 10 Nov 2014 09:10:36 -0800
Message-ID: <xmqqmw7z9e2b.fsf@gitster.dls.corp.google.com>
References: <xmqqfvdxi7aq.fsf@gitster.dls.corp.google.com>
	<545F668B.7000805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 18:10:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnsUG-0002e8-HD
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 18:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbaKJRKl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2014 12:10:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752856AbaKJRKk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2014 12:10:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B0DB1BB0E;
	Mon, 10 Nov 2014 12:10:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T8p3GRbJ0J1I
	qjCLkLxIyUhqEkY=; b=sdP9tfba2CDEm4XnG+R3WoElte18mvlFnUK4x1J6OYEx
	VbyRrYJvQ0v/aWMDtIli5+Qo+YNJJE6W4tQoEvjzI8vDrn0wBdkmIv7ctU09y0gf
	6uC9wEEizYRCu4SuyZWN56aYvlbHeY538hs2oZYPwQDJoBtfimhdQC+AAQg5veI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dBhO7J
	UbWzioap4J05ugCo3SZk9SiYr5Z6ccRZJOj/kemqfNNUK10Fj3BqRu6XuPqgdfU6
	/Chl4k13RTSi24Ov4BHR019L427qcdEFMp+TGE487WosrGrD5My0FRR4Ux/FGw3+
	RKwzDzXtAL5BRo/651hL4PLuiXu24sDvtBdiM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 867531BB0D;
	Mon, 10 Nov 2014 12:10:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08C561BB07;
	Mon, 10 Nov 2014 12:10:37 -0500 (EST)
In-Reply-To: <545F668B.7000805@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sun, 09 Nov 2014 14:05:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7DDA6CC2-68FC-11E4-95B9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> * jt/timer-settime (2014-08-29) 6 commits
>>  - use timer_settime() for new platforms
>>  - autoconf: check for timer_settime()
>>  - autoconf: check for struct itimerspec
>>  - autoconf: check for struct sigevent
>>  - autoconf: check for struct timespec
>>  - autoconf: check for timer_t
>>=20
>>  Reviewed, discussed and wanting for a reroll.
>>=20
> Every time I want to test pu under Mac OS X this patch has to be reve=
rted manually.
>
> Is there a chance to remove the V1 version from pu until we got the V=
2 version, please ?

Let's discard the series, with an expectation that a reroll in a
direction that was discussed in the review thread will be considered
if/when it comes (aka "without prejudice").
