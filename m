From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 5/5] t3910: use the UTF8_NFD_TO_NFC test prereq
Date: Sat, 04 Aug 2012 15:04:44 -0700
Message-ID: <7vboiq9uv7.fsf@alter.siamese.dyndns.org>
References: <7vboj115as.fsf@alter.siamese.dyndns.org>
 <de831564718b0d52d6ba6e9cb13020defdbfa359.1343641675.git.git@drmicha.warpmail.net> <501CB52D.6080208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 00:04:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxmSt-0004pj-SB
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 00:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967Ab2HDWEu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Aug 2012 18:04:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833Ab2HDWEu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2012 18:04:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36E2E87E9;
	Sat,  4 Aug 2012 18:04:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8okS4SydzQuz
	5ty9UcGkjYrg+ps=; b=QezuxicLGiNq6Wxhu9rYZfSFaWbX8K9tvjiIHmqKq9R5
	M3cIe5Ipc4AaqhDP0387VwKjukWSwWA/s9my1hcMWLGex/weZAzVlWO6hhGCgPH3
	0AEx9Gj6jnlxQUzQU9t6TbDhcEZtr09428orZUTOglGv2wkr92fMJQN2m4z1r3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yO3wvM
	rU65YMwNgA99BPOZaW3j5ivK41RtJsoZxmqwsT78m1fmgyMQmkz1GHl62Azthf1I
	q91xD3d3ui+iwL5+pHEMBi9D/iIGLeVtp74875DAi7CetvI8+WAbR0z14x1urflQ
	RMrtWIly2jt4DG/fDLQdoUWBBWR960QNdz3oU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23C3987E8;
	Sat,  4 Aug 2012 18:04:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D95487E7; Sat,  4 Aug 2012
 18:04:46 -0400 (EDT)
In-Reply-To: <501CB52D.6080208@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Sat, 04 Aug 2012 07:37:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 672B16B0-DE80-11E1-A70F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202892>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Am 2012-07-30 11:57, schrieb Michael J Gruber:
> (Sorry being late)
>
> That line:
>>skip_all=3D"filesystem does not convert utf-8 nfd to nfc"
>
> shouldn't it be the other way around?
> skip_all=3D"filesystem does not convert utf-8 nfc to nfd"
>
> (and may be the following may be more easy to read:)
> skip_all=3D"filesystem does not decompose unicode"
>
>
> Side note: t0050 uses another term:
> "will test on a unicode corrupting filesystem"

I am OK with either of the last two.  Thanks for noticing.
