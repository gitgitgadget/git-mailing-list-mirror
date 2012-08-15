From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add some bash style we prefer
Date: Wed, 15 Aug 2012 10:55:04 -0700
Message-ID: <7vzk5w59c7.fsf@alter.siamese.dyndns.org>
References: <20120814203931.GB33843@book.hvoigt.net>
 <7vipcl89kg.fsf@alter.siamese.dyndns.org>
 <20120815170601.GB43523@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Aug 15 19:55:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1hoU-0002dT-Io
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 19:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab2HORzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 13:55:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755939Ab2HORzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 13:55:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04D1B8D5B;
	Wed, 15 Aug 2012 13:55:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Drl6hUxNU3LQcP/4s6E6xXdEc28=; b=Vow6d8
	02Ys7wI1iSKOG0MEfsyI1TlW+dx0SgI1Dn+k66KyzOwC9lfADYce87nmKXBJTWK/
	VqiNA2E6e2qPbGAF7STpj41rBGZvPMGCiOEN6dgUXp3s0ynQKxa6yIvlOiSL947r
	BsAnSCZvcMnCKbMz/4pbt2zCGwkNrONiAi/fE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gjWfxPwlw2e2j2LSmpofXGTz2+99QbZG
	RiSFUVK12afoCAX2Ad/hBfIDhflUN35UC2N+zkc/yFg1zd42oAhhdn+uNLtgyAJJ
	QHF7S3pVkV+g8aRzF7AoUhFVAAhyOMXJlORQkvd+s+tehI3Ge91qP8hX1h6OYcAB
	PyDRjEuwXCE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E24C48D5A;
	Wed, 15 Aug 2012 13:55:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DC2E8D57; Wed, 15 Aug 2012
 13:55:06 -0400 (EDT)
In-Reply-To: <20120815170601.GB43523@book.hvoigt.net> (Heiko Voigt's message
 of "Wed, 15 Aug 2012 19:06:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58C79ED8-E702-11E1-989F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203478>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> During discussion of other patches these preferences have been revealed.
> Lets add them to the guidelines.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> Here an updated version of the patch.

Thanks.


>
> On Tue, Aug 14, 2012 at 02:09:35PM -0700, Junio C Hamano wrote:
>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>> > @@ -97,6 +102,7 @@ For shell scripts specifically (not exhaustive):
>> >     interface translatable. See "Marking strings for translation" in
>> >     po/README.
>> >  
>> > +
>> >  For C programs:
>> 
>> Probably not needed, as there is no such double space between C
>> and Documentation sections.
>
> Sorry about that whitespace noise.
>
> Cheers Heiko
>
>  Documentation/CodingGuidelines | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 4557711..e70d110 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -76,11 +76,19 @@ For shell scripts specifically (not exhaustive):
>  
>   - We do not use Process Substitution <(list) or >(list).
>  
> + - We prefer writing all control structures without semicolon on the
> +   same line. E.g. "then" should be on the next line for if statements.
> +   The same applies to while, for, ...
> +
>   - We prefer "test" over "[ ... ]".
>  
>   - We do not write the noiseword "function" in front of shell
>     functions.
>  
> + - We prefer a space between the function name and the parentheses. The
> +   opening "{" should also be on the same line.
> +   E.g.: my_function () {
> +
>   - As to use of grep, stick to a subset of BRE (namely, no \{m,n\},
>     [::], [==], nor [..]) for portability.
