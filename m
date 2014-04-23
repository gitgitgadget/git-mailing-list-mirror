From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] test-lib: Document short options in t/README
Date: Wed, 23 Apr 2014 11:24:53 -0700
Message-ID: <xmqqr44nzyx6.fsf@gitster.dls.corp.google.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
	<1398154767-1276-2-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 20:25:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd1r0-0001Dx-SQ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 20:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955AbaDWSZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 14:25:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756702AbaDWSY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 14:24:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEC7A7DC70;
	Wed, 23 Apr 2014 14:24:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UDwYK7N534FuhLDRRXQBJKMfIuU=; b=xczwxF
	FRTJgvwPCXu1qorxTmDBxDluDlybTHBr3QoJtiNiJed1i5ET9lQ/4/cMrxWyYaCb
	ssAIpYaccWFg0fhPcO5QLV6CM+PODUZ+qmM/XgVpyx51uPqqam6jhO9PRtrycWYt
	NIlXJVJUr07ATigvarzb0BLmSBde7pbCWp/Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wet3+k4bCcudXQHOcMYBbrFZahTTNzm3
	XKgRVUiKrXbYkwgtcYKXA3nxEtK272QqQ1FszzF6y6jPa6OEziD0RKF6tgGteYJP
	GzScn7gHloHuE8XHoqSKa5iDaVE6/eT+uqVQreLx3ucZT0FhFyVXLGFNHC36088+
	wApjmu+Cf5s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C45597DC6F;
	Wed, 23 Apr 2014 14:24:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D45337DC6C;
	Wed, 23 Apr 2014 14:24:54 -0400 (EDT)
In-Reply-To: <1398154767-1276-2-git-send-email-ilya.bobyr@gmail.com> (Ilya
	Bobyr's message of "Tue, 22 Apr 2014 01:19:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9151E914-CB14-11E3-AF28-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246864>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

> Most arguments that could be provided to a test have short forms.
> Unless documented, the only way to learn them is to read the code.
>
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
> ---
>  t/README |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/README b/t/README
> index caeeb9d..6b93aca 100644
> --- a/t/README
> +++ b/t/README
> @@ -71,7 +71,7 @@ You can pass --verbose (or -v), --debug (or -d), and --immediate
>  (or -i) command line argument to the test, or by setting GIT_TEST_OPTS
>  appropriately before running "make".
>  
> ---verbose::
> +-v,--verbose::
>  	This makes the test more verbose.  Specifically, the
>  	command being run and their output if any are also
>  	output.

I was debating myself if the result should look more like this:

	-v::
	--verbose::
		This makes the test more verbose.  Specifically, the
		command being run and their output if any are also
		output.

As a straight text file, your version is certainly a lot easier to
read, but at the same time, the entire file is written in more or
less AsciiDoc format (the list of prerequisites and the list of
harness library functions need to be converted to the "item::" form
for the text to format well, though) and I've seen some efforts by
others to run text files in Documentation/ that were originally
meant to be consumed as straight text thru AsciiDoc, so the latter
form might be a small step for futureproofing.

My conclusion at this point is that the original is good for the
current need of the project; if somebody wants to include this file
from somewhere in Documentation/technical, a conversion to use
multiple "item1::<newline>item2::<newline>description" headers can
be done by that person as part of the "make it fully AsciiDoc"
effort.

Thanks.
