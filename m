From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Wed, 02 Jan 2013 11:07:41 -0800
Message-ID: <7vmwwr2yki.fsf@alter.siamese.dyndns.org>
References: <20130101172645.GA5506@thyrsus.com>
 <7vfw2k8t7k.fsf@alter.siamese.dyndns.org> <20130102003344.GA9651@thyrsus.com>
 <7vr4m331bn.fsf@alter.siamese.dyndns.org>
 <20130102183710.GB19006@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Jan 02 20:08:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqTfX-0000Uf-TC
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 20:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab3ABTHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 14:07:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404Ab3ABTHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 14:07:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5948A652;
	Wed,  2 Jan 2013 14:07:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FPluHeHuZIctztumwtH8Im7Wafw=; b=MNbdJN
	BXl2F+bYH2ai6CL106priY6+9uHPlUKb66Tb9R7MkQZOYvp9rpzlq/ipHsvCSh5J
	NUPwPbxJHEUT6Xu7+Wk0ZgdbfqRp8lsBauyRPCp7YL8SL7+cWjJ0zahYkbOhYVkg
	7q3+a4dsEUTWGLk9pmETOzgE2oRaC4DjARbwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wMetXwnc6Yq6ZRDZOezMRwx1Jn+eMjde
	VwbjyWC9pLdmKxCgNr77YgTUh+EsUSA3I8HgYAcuOHGv0o+9O/jyMKkRtfPy35zN
	RJ06ufMViiDRqJxYP9Aa3cHJBYP8DOThdPuVdvVvEUjEN8jRE9Lyy42YyCV471/3
	FZonJA2JYDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7375A651;
	Wed,  2 Jan 2013 14:07:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 342A0A650; Wed,  2 Jan 2013
 14:07:43 -0500 (EST)
In-Reply-To: <20130102183710.GB19006@thyrsus.com> (Eric S. Raymond's message
 of "Wed, 2 Jan 2013 13:37:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF861030-550F-11E2-A819-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212534>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Junio C Hamano <gitster@pobox.com>:
>> As your version already knows how to detect the case where cvsps is
>> too old to operate with it, I imagine it to be straight-forward to
>> ship the old cvsimport under obscure name, "git cvsimport--old" or
>> something, and spawn it from your version when necessary, perhaps
>> after issuing a warning "cvsps 3.0 not found; switching to an old
>> and unmaintained version of cvsimport..."
>
> This can be done.  As this may not be the last case in which it comes up,
> perhaps we should have an 'obsolete' directory distinct from 'contrib'.
>
> I'll ship another patch.

Alright; thanks.

Don't forget to sign-off your patch ;-)
