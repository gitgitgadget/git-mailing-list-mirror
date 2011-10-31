From: Junio C Hamano <junio@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Mon, 31 Oct 2011 10:19:12 -0700
Message-ID: <7v8vo1qdtb.fsf@alter.siamese.dyndns.org>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
 <4EAEAE13.50101@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 31 18:19:31 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RKvWC-0005Zd-6S
	for glk-linux-kernel-3@lo.gmane.org; Mon, 31 Oct 2011 18:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933498Ab1JaRTS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 31 Oct 2011 13:19:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64612 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932861Ab1JaRTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2011 13:19:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4DF55D2F;
	Mon, 31 Oct 2011 13:19:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CmQ4c5uq/YAm
	MC5Fr96fw8XUTyY=; b=UAVBhsF+VOo/lNwwEWfZOpHN4FTdxexYRz5zCH0AfNQt
	34hAT+3Hz2Ljl69TCpG2VzI+dJnP3/vSNuGB2RyyxfAxNWI8HX0j+KinsIsXg1U5
	jJjk8ZkOBRyJv63nspFDMSaCr2cKIZWkNEh9wEgskt/UQ+5R6a0u8mpEDPKMOic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vjItZZ
	95zb8d5U6zVUYjAbGaFigJw2+KAFfN09fqP0GztUwMv2Ep2UzeEPlBzUpgnvpMir
	i1IaGtYd/3LRJmSHltgmdSbi+EGCPq2uffDF1dOm9pN67VpfxGniuc9Lfobpgzgw
	d0tc80zT2CP+lKjDC4cnrZS7Bk3TfCV4DHyX0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C9F85D2E;
	Mon, 31 Oct 2011 13:19:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 352F15D2D; Mon, 31 Oct 2011
 13:19:14 -0400 (EDT)
In-Reply-To: <4EAEAE13.50101@atlas-elektronik.com> ("Stefan =?utf-8?Q?N?=
 =?utf-8?Q?=C3=A4we=22's?= message of "Mon, 31 Oct 2011 15:17:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74A5FAC0-03E4-11E1-9430-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184509>

Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:

>>  * HTTP transport did not use pushurl correctly, and also did not te=
ll
>>    what host it is trying to authenticate with when asking for
>>    credentials.
>>    (merge deba493 jk/http-auth later to maint).
>
> This seems to break pushing with https for me.
> It never uses values from my '~/.netrc'.
> I'll come up with a detailed scenario later.

Thanks.

I have been pushing my updates out to code.google.com via authenticatio=
n
token stored in ~/.netrc over https, so it would be nice to see what
breaks for you that works for me. There probably is something subtly
different.
