From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t/README: Document the Smoke testing
Date: Mon, 02 Aug 2010 15:44:27 -0700
Message-ID: <7v39uwk52s.fsf@alter.siamese.dyndns.org>
References: <1280780684-26344-1-git-send-email-avarab@gmail.com>
 <1280780684-26344-3-git-send-email-avarab@gmail.com>
 <AANLkTim2EY7AACe=UzbG-k7oteV6UMmfPAQMEOFn0iZ7@mail.gmail.com>
 <4C5732CE.10906@gmail.com>
 <AANLkTi=EuTD0M3eNo+PXW7Z2Ra2yzf-i+L4DFQVg8JZ7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitzilla@gmail.com, Sverre Rabbelier <srabbelier@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:44:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3kT-0006Sr-2n
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780Ab0HBWok convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 18:44:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab0HBWoj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 18:44:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30AEBC9908;
	Mon,  2 Aug 2010 18:44:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3HeAiE4vY7jl
	vpnPBoEFGZiEWTc=; b=OKDnIDGw1HxOsCJeki1FhtihkYrr6d0YaOUeCxM4m6fh
	ogOfMb+wNxqSdD+CbG7zGU9gqQMRi+gtooJujunxjw5AJT2tUglgh2kzA6vc1mjC
	sLnyLgel2JpggRiuDj1o/PXJKwq3YyLAYOeQyhNPGx9ugmLrndC7KeMaVOLyUC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MFWn+f
	vx8dVLadXxDWUp3KXDvAnzO4gRv+pb3+23WsrkAIXREIpOeFRHiyfcLvI73dGPmK
	W+ULhyK/Ri8UyO6LrHr1NmpThEPtLmtms01eMvctw3GXONYoptC7HWnzG4gXpXlD
	WXsT+JksJD7KAwfaGdbvbbnSp6wmUgJMplmNQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B91D1C9905;
	Mon,  2 Aug 2010 18:44:34 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C34EC9904; Mon,  2 Aug
 2010 18:44:29 -0400 (EDT)
In-Reply-To: <AANLkTi=EuTD0M3eNo+PXW7Z2Ra2yzf-i+L4DFQVg8JZ7@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 2 Aug
 2010 22\:00\:26 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85CAF27E-9E87-11DF-8055-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152479>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Aug 2, 2010 at 21:04, A Large Angry SCM <gitzilla@gmail.com> =
wrote:
>> On 08/02/2010 04:54 PM, Sverre Rabbelier wrote:
>>> Can't we run this somewhere a little less "shabby"?

"shabby" is not a good word to describe a service somebody volunteered =
to
maintain for the public good.  Be civil, please.

>> And what's on the site tells us almost nothing about the tested syst=
ems.
>
> Can you be more specific? What information do you find lacking at
> http://smoke.git.nix.is/app/projects/smoke_reports/1 ?

"Platform Linux" does not tell much about the tested systems, no?
