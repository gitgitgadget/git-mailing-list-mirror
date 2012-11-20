From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Tue, 20 Nov 2012 13:07:58 -0800
Message-ID: <7vzk2cq8y9.fsf@alter.siamese.dyndns.org>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
 <1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
 <CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
 <CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
 <CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
 <CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
 <CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
 <CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
 <CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
 <20121116204017.GX12052@goldbirke> <7vr4ntkzy4.fsf@alter.siamese.dyndns.org>
 <CAMP44s0y3UPVT+ndELaKNsWXAPG3kv-Xq_Wf6ONDF3Z99A5zMQ@mail.gmail.com>
 <CAFj1UpFbuHVhPOQVB9-sPjW2aBN=H+OUyYnz00qASZ5ssbwmGw@mail.gmail.com>
 <CAMP44s30wYnkQdq8yup3z-t=FEf1R+k8OC-o7-uY=19z9VHDPg@mail.gmail.com>
 <CAFj1UpHs08seVH8Kb3CuoNTaF+x6vA+ybVTEu0TyLX8NYuuidQ@mail.gmail.com>
 <CAMP44s1i59VtX9xMmM-j3Gzcufg6jtKy34MMuwrfenmSw3oLAg@mail.gmail.com>
 <CAFj1UpFTu7GnpKSvs6qGH6XjAT16RAk4rmdX0sPFOo9ABg8BKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 22:08:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tav3S-0002fr-Ha
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 22:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab2KTVIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 16:08:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139Ab2KTVID (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 16:08:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 476DDA697;
	Tue, 20 Nov 2012 16:08:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Z/3UOZ/J0apMcvU171WBYnQuNU=; b=B23iRi
	C4pwEJeJfRZPJI8QLQGUCFpilnEY4c5fYaP1/9gHw4z++QHQ2iDfGVxzy2mVjDaV
	W+KcaPLLwRtqsuRyOCxnsDGNQBZ2VYACvT3cs5Lfp2F7IJmmQJZdY9nHadQfuqSa
	Le2tzTQlEvF+27YG/xk+AA/t8mTNsFri45DB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VyqnZR5PGYn6i2AtEkv9zdWo37h0Gct3
	cu5HrNzr3ecMHtIwC+Bsbk+1YAGvFFwLTU3SLJCKjRanMUyUXavlsJizHWvq3e+I
	5pyhyzWjpA2Cq/zsoC/BhtR1WPZr3iORrNR+5m+fW6nwOKVEvXLF+S1Vn2mB6rTT
	1GB3njlFWuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22766A695;
	Tue, 20 Nov 2012 16:08:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55785A68E; Tue, 20 Nov 2012
 16:08:00 -0500 (EST)
In-Reply-To: <CAFj1UpFTu7GnpKSvs6qGH6XjAT16RAk4rmdX0sPFOo9ABg8BKg@mail.gmail.com> (Marc
 Khouzam's message of "Tue, 20 Nov 2012 13:20:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D82C538-3356-11E2-B6E6-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210113>

Marc Khouzam <marc.khouzam@gmail.com> writes:

>> This one is already merged to 'next'.
>
> Awesome!  I didn't notice.
>
> If I want to suggest an improvement (like checking if the bash
> script is available), do I just post a patch here?

Yes, as a follow-up patch (or two).

Thanks.
