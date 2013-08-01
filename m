From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2013, #09; Mon, 29)
Date: Thu, 01 Aug 2013 14:12:29 -0700
Message-ID: <7vtxj9qfnm.fsf@alter.siamese.dyndns.org>
References: <7vk3k9yol3.fsf@alter.siamese.dyndns.org>
	<51F94DFD.5020101@ramsay1.demon.co.uk>
	<7v4nbav9ys.fsf@alter.siamese.dyndns.org>
	<51FACA67.8090207@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de, mhagger@alum.mit.edu,
	mlevedahl@gmail.com, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 01 23:12:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V50An-0008E9-Lj
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 23:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab3HAVMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 17:12:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab3HAVMd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 17:12:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3504935304;
	Thu,  1 Aug 2013 21:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1jzyGfEbV3z0I65ZZFUQzVEVPoE=; b=mlEKq+
	Z083b+1VrxuUVaxSmXpcrOP2oKtb9NjOkHi8EWdSBL6Q6i3frsdw8mszD4Efdz9T
	JXVxDtl/mmKBPRKTOiq14j9iUCs+a8xsIp6G5/gD7TFOGSYXMupUpHeMutEHHx26
	jodujRmzbOVETHsFGmZEqBmKYC6OKYG+iIJ/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MVJMWG9iAo2T8viCJ+WwDcIMHzSZrr8j
	czm/sfC9gD7ALCJOb8OEoOnMsQ1ooHiP6I/beOSIFqX3fVKOWbTECV7NW6cAIkC7
	rpEJ2INzSp8GhqYF8lrEGxVUPPt+3nZNjT9rTHeYIgU6inM1yyTUJWGvpBgHFWwp
	jx0uwWQeXFU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 105B935303;
	Thu,  1 Aug 2013 21:12:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CE2135301;
	Thu,  1 Aug 2013 21:12:31 +0000 (UTC)
In-Reply-To: <51FACA67.8090207@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Thu, 01 Aug 2013 21:51:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13E0B352-FAEF-11E2-94C3-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231506>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>> 
>>>>  I am personally in favor of this simpler solution.  Comments?
>>>
>>> I had expected this to me marked for 'master'.
>>>
>>> Has this simply been overlooked, or do you have reservations about
>>> applying this patch?
>> 
>> I am just being careful and do want to keep it cooking in 'next'
>> during the feature freeze.  The more users work with 'next' (not
>> "work *on* 'next'"), the more confidence we would be with, and
>> hopefully this can be one of the topis that graduate early after
>> the 1.8.4 release.
>
> Hmm, this patch is a bug-fix for a bug that (currently) will be
> _introduced_ by v1.8.4.

OK, let's merge it then.  Thanks for being patient with me.

> Do you want me to try and find a different bug-fix for v1.8.4?
> (Although that would most likely be more risky than simply taking
> this patch! ;-) ).

Absolutely not, and I 100% agree with you.
