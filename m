From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] Expanding tabs in "git log" output
Date: Thu, 24 Mar 2016 11:22:05 -0700
Message-ID: <xmqqmvpn91o2.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
	<1458775426-2215-1-git-send-email-gitster@pobox.com>
	<56F391A4.6090603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 24 19:22:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9tm-00069W-BE
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 19:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbcCXSWP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 14:22:15 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752365AbcCXSWM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 14:22:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC1234B8B1;
	Thu, 24 Mar 2016 14:22:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=a6lE7j76gy3z
	Pi5xRtS2LCop7ns=; b=mZyf4RB5l+c2Y1upKuWEfRLDV1GIGBFWQu+ZoZizYd0l
	OjjEY20ZCcnITMC+b/Sz6f88zTWs8Do51iymBNj8Jtm7ZPopC3eNtI5fsK52UIXe
	jRMzOnaD9k1a6tGpObhG3uyNTsNeqvQL97e7sRE49aLwD2Ij5HPwnSbuSGqMTrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UIO60p
	p1fH4KuAmYuKSzC2TiSS56ILc9oyigyw2HsDZauAbjB376azKi+VI9TfWEJmPhFv
	wv03n+zJG9vWW9bklTP/AtGbiXtSNiBEebDMV4Hu5wC0QFa48MeO0/vrDCrsNpim
	oQU+ZyIbA9tRjDfT73Sj8cJVKESZNZ7yRubkU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5CD34B8AF;
	Thu, 24 Mar 2016 14:22:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 685A64B874;
	Thu, 24 Mar 2016 14:22:07 -0400 (EDT)
In-Reply-To: <56F391A4.6090603@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 24 Mar 2016 08:05:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 511EB546-F1ED-11E5-94A8-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289779>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Would it make sense to have
> git log --tab-size=3D8
> (or similar)
>
> and add a config variable like
> git config ui.logtabsize
> which is 0 by default to get the old handling and 8 for the new one ?

That may be a good approach (I agree with you that --tab-size is not
the best name).  Want to try it as a replacement?
