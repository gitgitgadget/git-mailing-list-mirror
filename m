From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [eclipse7@gmx.net: [PATCH] diff: Only count lines in
 show_shortstats()]
Date: Thu, 14 Jun 2012 13:28:16 -0700
Message-ID: <7vaa05eizj.fsf@alter.siamese.dyndns.org>
References: <20120607122149.GA3070@akuma> <4FD0FB75.4090906@in.waw.pl>
 <20120607200434.GA2965@akuma> <7vk3zig92n.fsf@alter.siamese.dyndns.org>
 <4FDA3668.3000900@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Strasser <eclipse7@gmx.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>, mj@ucw.cz,
	Johannes Sixt <j.sixt@viscovery.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Jun 14 22:28:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfGeW-0003hA-JM
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 22:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434Ab2FNU2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 16:28:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756393Ab2FNU2T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2012 16:28:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E3CB8F38;
	Thu, 14 Jun 2012 16:28:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Rjkt63mFe2fR
	h+mtU4YpEzOeXZA=; b=ifMFAPymfEZdYkjuZKw7KxOnu55Ds8KM9auuJq9ydTOP
	oZKUDa3TaDdGr2GQJUbQgm5PFRQAZk/rkdLaRG5jxwqzSKY4c7xU1YwpB238y4cM
	xNh1Y4OBNGEoUyexV9RqvfFd88NBjMNOFtLa1+1H4HRkS4ICXxgG29Yrh+/7GlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gVg6TM
	2CCt631SM/r0Zw2tJhr1lxAVlPq35D8uJ+Kqm38DfWkAt5r7Lg99d9xzSVpyuQwW
	57Ki3Ntn+VkhqI8e95m0OoC9RSicl6yeF4msGPZLEYbBQ+MVVJjRLqCRkqMYRXhA
	TvAzeBV2FVZOH08r6eDhpLltsc03rd0Tgzics=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75E998F37;
	Thu, 14 Jun 2012 16:28:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E926E8F36; Thu, 14 Jun 2012
 16:28:17 -0400 (EDT)
In-Reply-To: <4FDA3668.3000900@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Thu, 14 Jun 2012 21:07:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79D04806-B65F-11E1-BA94-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200031>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> On 06/07/2012 10:29 PM, Junio C Hamano wrote:
> ...
>> Please keep a bugfix patch to only fixes with tests.  Style fixes
>> should be done later after dust from more important changes (e.g. a
>> bugfix) settles.
>>=20
>> Thanks.
>
> Does this need a v2?
>
> Zbyszek

That is a question to be asked with Alex on the To: line, not me, I
would think.  I saw "Ah, I see. I will try to do better next time."
in his response to your review, but haven't seen the "next time"
reroll yet.
