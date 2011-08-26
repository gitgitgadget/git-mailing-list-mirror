From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff annoyance / feature request
Date: Fri, 26 Aug 2011 14:52:21 -0700
Message-ID: <7v4o13dene.fsf@alter.siamese.dyndns.org>
References: <4E569F10.8060808@panasas.com> <4E580D49.1070006@lsrfire.ath.cx>
 <4E581213.6070304@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git discussion list <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 23:52:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx4KC-0004np-RK
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 23:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616Ab1HZVwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Aug 2011 17:52:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33690 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755608Ab1HZVwX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 17:52:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 218F24DE2;
	Fri, 26 Aug 2011 17:52:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2/Wz5LWChOwl
	/3dfOHhd59GKyoI=; b=BZPs3/zBx9sDZUTaeFK7lVSetRTKJzydIKMEj7ObbvmP
	upaNFbNBJGoHRD57uEqYaWbN/j0Vl1NNiQUbLzRdVIUlVUNFmvPUVq+UDkyyRvb5
	91cN3cS4gzEcP2E2vTfCYfHIgD32VKwxQIr9qIiAp6xAOcJ773t3hGbkCLSTIqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sBTWya
	G2EYiPriNBitkjQT+fjZmXvFS3BpNtAVhcImW1Tz7a3jXUkZY8r35DLGaGpJ0b4V
	YNuXkObp9zFUDTUTho3MJ5LFBLoKiIdpJKM0BABCN3ToFjo/Ha5yEWI0MIUkSaQR
	eXoulMmm5X+3WqoDD0R4mQPj2XmdCz77QsfKE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18A374DE1;
	Fri, 26 Aug 2011 17:52:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BF184DE0; Fri, 26 Aug 2011
 17:52:22 -0400 (EDT)
In-Reply-To: <4E581213.6070304@panasas.com> (Boaz Harrosh's message of "Fri,
 26 Aug 2011 14:37:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD9AFCBC-D02D-11E0-AA6C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180204>

Boaz Harrosh <bharrosh@panasas.com> writes:

> On 08/26/2011 02:16 PM, Ren=C3=A9 Scharfe wrote:
>> Am 25.08.2011 21:14, schrieb Boaz Harrosh:
>>=20
>> Cheap trick: change your coding style to place a single space before
>> labels instead of having them start right at the beginning of a line=
=2E
>>=20
>> Ren=C3=A9
>>=20
>
> Nope, does not work! and I have no choice about it, it's Linux coding
> style

I too thought it was in the Documentation/CodingStyle, but I don't find=
 it
in my copy. "Chapter 7" has an example of using goto and it does have
label at the left edge of the page without indentation, but does not se=
em
to say it should not be indented.

Taken together with the output from "grep '#goto label' scripts/checkpa=
tch.pl"
I concluded that "it's Linux coding style" was a myth.
