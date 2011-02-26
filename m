From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch_merged: fix grammar in warning
Date: Sat, 26 Feb 2011 00:24:43 -0800
Message-ID: <7vbp1z8apg.fsf@alter.siamese.dyndns.org>
References: <AANLkTikgmA8useucn0T6Gp7m5ang8iy-a--L_2HuOk9d@mail.gmail.com>
 <AANLkTimN2ba8Ab2BRp=sU4NT_e6UYh4HH2L7afgEkHg8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Hanchrow <eric.hanchrow@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 09:25:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtFSd-0001Ik-Ga
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 09:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678Ab1BZIY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 03:24:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab1BZIY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 03:24:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 91828269B;
	Sat, 26 Feb 2011 03:26:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G/dx3+4u4uLOduRrRwMBdU6N+K8=; b=wBe531
	Zc8tzL0fg0an1R3qTTfqhHDtwBXafFGTTse3cR08Z6FtX217U0xYwnXml1v6cdF1
	LUSeBYLb8rhUgA+PN0ZtT4nk3/Le1oRvgDsvSheyfMHfg2zH3SmPb2fCvBGYPP8M
	RPlh5g/dHq5nsuty6PB0Ts/6Bnr+iqio5On3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WxrigACLJuJy7WZmlBE5tUl5Eyb2D6h+
	MhhotDTiVRZzwC+6DBeoAT4wdpcNS4XrQS667gNRs6DKQwmuBs6S/c/r1x0vYudD
	0RjsiGkTcxs3UVPLwVdYCcvOEpQeqMBfUgkhBfQqgP7lroywQuZivUoMxrpa7gIa
	cSQ0pqXgrHo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 600F1269A;
	Sat, 26 Feb 2011 03:26:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2DB4D2699; Sat, 26 Feb 2011
 03:26:01 -0500 (EST)
In-Reply-To: <AANLkTimN2ba8Ab2BRp=sU4NT_e6UYh4HH2L7afgEkHg8@mail.gmail.com>
 (Jay Soffian's message of "Fri\, 25 Feb 2011 22\:44\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E5B4542-4182-11E0-9E45-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167963>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Fri, Feb 25, 2011 at 10:33 PM, Eric Hanchrow <eric.hanchrow@gmail.com> wrote:
>>  builtin/branch.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 9e546e4..915f270 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -134,7 +134,7 @@ static int branch_merged(int kind, const char *name,
>>            in_merge_bases(rev, &head_rev, 1) != merged) {
>>                if (merged)
>>                        warning("deleting branch '%s' that has been merged to\n"
>> -                               "         '%s', but it is not yet merged to HEAD.",
>> +                               "         '%s', but it has not yet been merged to HEAD.",
>
> You can drop the "it" while you're at it. :-)
>
> j.

Yeah, and we would want a sign-off, too.
