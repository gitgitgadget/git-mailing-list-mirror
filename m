From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2013, #03; Thu, 12)
Date: Fri, 13 Dec 2013 12:58:47 -0800
Message-ID: <7vwqj8zcvs.fsf@alter.siamese.dyndns.org>
References: <xmqqwqj9r2ig.fsf@gitster.dls.corp.google.com>
	<52AAB9B6.4080402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 13 21:58:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrZp1-0001q2-Ex
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 21:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079Ab3LMU6w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Dec 2013 15:58:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991Ab3LMU6v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Dec 2013 15:58:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA0F75A1C5;
	Fri, 13 Dec 2013 15:58:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bLhIK3VkLuRD
	/uuqgdVMwTcfqMM=; b=VsdazTK8sMiKujNvhjPJl2kj9kvYTa9Vw9Ku8UsC8M1/
	e+Q0dQvAnDIONbDMKsDX4OVQlFXdKwElh7YK/M4HC4Rz0f7TYvOAQX4XFbpxKAQT
	dxuzwEggAG0jLD9WC6RnLi9pMXFqEJUfU22T9ipkIZ4AO+vVKCDWthzeLUgJBPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lytMbm
	vljRbyMDVhw2T72HfZkh7KmKnEDDCw4zXLDsg5Wql6QuZ89kMyx1ZdGEixU2WuB6
	V+9RrssiEN5Ls0Dx4VnjkRofgnSHtd3heW0gmh8cz4X6AqarbfcKbifG5i2pSsTE
	3IaHrLk6T5FKmJk6ifrq6IThRPY1rnbuE894M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 973C25A1C4;
	Fri, 13 Dec 2013 15:58:50 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD2B65A1C2;
	Fri, 13 Dec 2013 15:58:49 -0500 (EST)
In-Reply-To: <52AAB9B6.4080402@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 13 Dec 2013 08:39:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D944CA8-6439-11E3-BA67-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239267>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 12/13/2013 01:57 AM, Junio C Hamano wrote:
>> [Cooking]
>>
>> * fc/transport-helper-fixes (2013-12-09) 6 commits
>>   - remote-bzr: support the new 'force' option
>>   - test-hg.sh: tests are now expected to pass
>>   - transport-helper: check for 'forced update' message
>>   - transport-helper: add 'force' to 'export' helpers
>>   - transport-helper: don't update refs in dry-run
>>   - transport-helper: mismerge fix
>>
>>   Updates transport-helper, fast-import and fast-export to allow the
>>   ref mapping and ref deletion in a way similar to the natively
>>   supported transports.
>>
>>   Will merge to 'next'.
> This breaks t5541, (at least on my systems, both Linux and Mac OS)

Thanks for stopping me.
