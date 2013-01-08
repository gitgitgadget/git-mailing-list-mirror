From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: Fix biridectionality -> bidirectionality
 typos
Date: Tue, 08 Jan 2013 09:32:07 -0800
Message-ID: <7vboczfunc.fsf@alter.siamese.dyndns.org>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
 <1351995218-19889-8-git-send-email-felipe.contreras@gmail.com>
 <20121128202320.GA22522@odin.tremily.us>
 <20130108154737.GA4662@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:32:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsd2N-000274-58
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 18:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756713Ab3AHRcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 12:32:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41857 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756346Ab3AHRcK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 12:32:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E179A3CE;
	Tue,  8 Jan 2013 12:32:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GA0cOyUH7jGSfn/BElV69sZUhHs=; b=Nm236h
	Ew9hCQSclhkYB+PB5O94bMfCAdHEELoo26T02bxw213YxosmaT8CS1flJl0qq67I
	gh4prNmAblTL1ticfrXZKQWF0C4KHtzAaQmuN+87s7u7qwSqb2GaIG8UlGxIB8wg
	R46ZBdd78kuwlj88CyCkuHlf3i9G9gHK7sz6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WmBvGePbSJcctHlUia/C0rOUeOkT9Fr2
	DcgZC/rKJ1WBtYJoOZO9HmddqTO+nEVSY4Ld5bW2UI0LXz9N4Apn2rbh5AXpL4PK
	2aecVY5D8qJBNXK5zqaARMUPVclFtSv9+U6HzPfJIolIJWfbp2wAQSjqGQw0DHZP
	Fv9ihHjg3iA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0114CA3CD;
	Tue,  8 Jan 2013 12:32:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D428A3CC; Tue,  8 Jan 2013
 12:32:09 -0500 (EST)
In-Reply-To: <20130108154737.GA4662@odin.tremily.us> (W. Trevor King's
 message of "Tue, 08 Jan 2013 10:47:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54588784-59B9-11E2-9AA6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212981>

"W. Trevor King" <wking@tremily.us> writes:

> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>
> I was looking for one of my older messages to the Git list, and I
> found this, which seems to have fallen through the cracks:

Thanks; didn't Documentation/SubmittingPatches ask you not to do PGP
multipart but send patches in plain text?

> On Wed, Nov 28, 2012 at 03:23:20PM -0500, W. Trevor King wrote:
>> I'm not sure if this is the most recent patch iteration for this
>> feature, but I just saw this typo in `pu`.
>> 
>> On Sun, Nov 04, 2012 at 03:13:29AM +0100, Felipe Contreras wrote:
>> > +# Commits are modified to preserve hg information and allow biridectionality.
>>                                                                ^^^^^^^^
>> s/biridectionality/bidirectionality/
>
> This fixes that instance (which has since landed in master) and
> another similar typo.
>
>  contrib/remote-helpers/git-remote-hg   | 2 +-
>  contrib/remote-helpers/test-hg-bidi.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 016cdad..c700600 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -31,7 +31,7 @@ import urllib
>  # hg:
>  # Emulate hg-git.
>  # Only hg bookmarks are exported as git branches.
> -# Commits are modified to preserve hg information and allow biridectionality.
> +# Commits are modified to preserve hg information and allow bidirectionality.
>  #
>  
>  NAME_RE = re.compile('^([^<>]+)')
> diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
> index a94eb28..1d61982 100755
> --- a/contrib/remote-helpers/test-hg-bidi.sh
> +++ b/contrib/remote-helpers/test-hg-bidi.sh
> @@ -6,7 +6,7 @@
>  # https://bitbucket.org/durin42/hg-git/src
>  #
>  
> -test_description='Test biridectionality of remote-hg'
> +test_description='Test bidirectionality of remote-hg'
>  
>  . ./test-lib.sh
