From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] Untracked cache improvements
Date: Wed, 20 Jan 2016 14:33:15 -0800
Message-ID: <xmqq8u3j51as.fsf@gitster.mtv.corp.google.com>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:33:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM1Ja-0001Ed-G7
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 23:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbcATWdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 17:33:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752516AbcATWdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 17:33:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E31E73E033;
	Wed, 20 Jan 2016 17:33:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fhprrVrd/6X1eR2F1gZi7ST+0ag=; b=lItnpL
	F0T3bnFI8KLLzfIsrh2FCxNnDv5YZNPKE67yzyB47vrA+y9PS1XMRwaquflsNAry
	ZG/nHRnus8HlH4tM1p3XwIYno26I197J0Wdtz6JRpQe6HaWiwexbhirSrUfDpXyz
	RrFDEUxZvB76p+BSn7VRiG780oE148htIANiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VdCbX7oURn4c0/M7hMhOlIopE2YSc8TN
	Md7eqNWP4GY0uA2wj4ZH6HkwFWQCPgY35ibZjCxOJZ6driXcxEzkcse+9CVlFbX5
	rAvXljw6K4TrfO5wtb9QVfFg3Nh2iL+u2PbzUul2lQDjxxT3m0MvRq3D30i/SdbS
	1Fi3G8bycQY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA8063E032;
	Wed, 20 Jan 2016 17:33:16 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4BBFD3E031;
	Wed, 20 Jan 2016 17:33:16 -0500 (EST)
In-Reply-To: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Wed, 20 Jan 2016 10:59:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CC6E8AD2-BFC5-11E5-ADC9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284476>

Thanks. Will queue.

Anybody who knows the untracked code wants to give the final
eyeballing over the series, so that we can start thinking about
merging it to 'next'?
