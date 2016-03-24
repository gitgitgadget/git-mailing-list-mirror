From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] Expanding tabs in "git log" output
Date: Thu, 24 Mar 2016 08:37:01 -0700
Message-ID: <xmqqd1qjc2g2.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
	<1458775426-2215-1-git-send-email-gitster@pobox.com>
	<56F391A4.6090603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 24 16:37:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj7Ju-000234-JV
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 16:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbcCXPhH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 11:37:07 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751036AbcCXPhF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 11:37:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0BAE4A488;
	Thu, 24 Mar 2016 11:37:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vw26HJiJP+oo
	DcmhAz3645v3lWs=; b=QghibwSxqzu/ElxelVqHjz3uq1SWF9UHYX87TgMO1vNh
	3ASLzF4SI94mdjZZ5ZlSRuSf8tdH297o7o3BxSfOSbYy80xEh0tw0UABfAhRtlDd
	L/EoGFyKoJbtb+9yiidCWVa88/XAmVZ9+v8K+44wmqpFQ2qiKSNYZP2JReDLjmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oepJ+o
	iLiICVJN9LWhLcjjFTXquB+XlBLGEEf1MvTAIPzZ+4t83qYQQUr7m3cAHrGt1roZ
	9QxOF/mfrUhENWySGuAIXwTkl1tXqQXsOt9m4WsKMom1IJYrlS9wQq9NASiLl/QM
	62B3xotjfolGE3wFsThExU2lf26G81tuEK6Z0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B85E94A487;
	Thu, 24 Mar 2016 11:37:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 375654A484;
	Thu, 24 Mar 2016 11:37:03 -0400 (EDT)
In-Reply-To: <56F391A4.6090603@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 24 Mar 2016 08:05:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 41B60850-F1D6-11E5-AF32-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289751>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>  [5/5] adds a new option --no-expand-tabs that controls the bit 4/5
>>        introduces, so that "git log [--pretty] --no-expand-tabs"
>>        would show the log message indented by 4 spaces, without tab
>>        expansion.
>
> Does this introduce an unnecessary regression out of the sudden ?

As I see this as a pure UI-level improvement done to a few of our
Porcelain program, I would say there is no regression here.
