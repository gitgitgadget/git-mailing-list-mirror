From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 11:59:17 -0800
Message-ID: <7v4nkpmi96.fsf@alter.siamese.dyndns.org>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
 <1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
 <CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
 <CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
 <CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
 <CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
 <CAFj1UpGmoEiLeHPh8LaUGLktV55YbTthi1wMNjLDn6vFMSdMwQ@mail.gmail.com>
 <CAMP44s3rwUw1QaADgm0xVOK3ebPNVSa06QdN5voNniD2acsz0g@mail.gmail.com>
 <CAFj1UpEMugSrGv53ajvCm=F_wOFm4qr1bnsR5NRPsvgC_fRs5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 20:59:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZS4c-0001uV-U4
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 20:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab2KPT7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 14:59:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab2KPT7U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 14:59:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABCB6A4AC;
	Fri, 16 Nov 2012 14:59:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gbYEjlkHCit2KQKfqDQ3Jvvhrlo=; b=DXW3C3
	Dhu8PZOpZjwUe+GAz+4n6eqbbMu/Sa+sVFti+ikzGUZmRNx9qKiZm4B1jJq8KmRU
	NUEyLXK5viBMFJyWxMVGeypibKGNpe84JJ02NnjziqSfzPwsaFdFOoNief/6/wW6
	IknJqt4X+dMTsC78kKnsf+QqE4Gp9A12S4GdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=khykTPGn479hrM95JaTNiJHuOTAH/X5M
	DyyjQTHRPRk9rRS0UHiGeiJGiwOldsQffTnewJAZX+fo2FKYLnBqtKmVw6nGDmDn
	PRKWKCjwwPxhQrffjRPT8aPgR9b4y8lrHzOSjriDX5+rs8oOoblfW3NKYJGshlxY
	7PpXWA83iK4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 978A6A4AB;
	Fri, 16 Nov 2012 14:59:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA694A4A8; Fri, 16 Nov 2012
 14:59:18 -0500 (EST)
In-Reply-To: <CAFj1UpEMugSrGv53ajvCm=F_wOFm4qr1bnsR5NRPsvgC_fRs5Q@mail.gmail.com> (Marc
 Khouzam's message of "Fri, 16 Nov 2012 13:43:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B518FC2-3028-11E2-B0F6-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209900>

Marc Khouzam <marc.khouzam@gmail.com> writes:

> The current tcsh-completion support for Git, as can be found on the
> Internet, takes the approach of defining the possible completions
> explicitly.  This has the obvious draw-back to require constant
> updating as the Git code base evolves.
> ...
>   C) Modifications:
>           New git-completion.tcsh
>
>      Provide a short tcsh script that generates another script
>      which extends git-completion.bash.  This new script can be
>      used by tcsh to perform completion.
>
>      Pros:
>        1- tcsh support is entirely isolated in git-completion.tcsh
>        2- new tcsh script can be as complex as needed
>      Cons (for tcsh users only):
>        1- requires the user to copy both git-completion.tcsh and
>           git-completion.bash to ${HOME}
>        2- requires bash script to have a fixed name and location:
>           ${HOME}/.git-completion.bash
>        3- sourcing the new script will generate a third script
> 
> Approach (C) was selected avoid any modification to git-completion.bash.
>
> Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>
> ---
>
> As suggested, I put the 'sort | uniq' inside the script.
> In that case, I don't need to worry about aliases since 'sort |uniq' will
> be executed in bash, for which the tcsh user surely doesn't have aliases setup.

OK, so does this look OK to everybody (it does, looking at the
difference between v3 and this one, to me)?

The patch may deserve a Reviewed-by: by Felipe, by the way.  I can
add one while applying.

Thanks.
