From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Documentation: Add diff.<driver>.* to config
Date: Wed, 06 Apr 2011 12:48:53 -0700
Message-ID: <7vwrj7i2je.fsf@alter.siamese.dyndns.org>
References: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
 <1302115611-1950-1-git-send-email-artagnon@gmail.com>
 <1302115611-1950-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 21:49:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Yj5-0006TI-Sg
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 21:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748Ab1DFTtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 15:49:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455Ab1DFTtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 15:49:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 92E1A45AF;
	Wed,  6 Apr 2011 15:50:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EaEvga8TezMrXjE+ZedR96HoLvo=; b=GLi6Pr
	rfQ1Tapkt2PWnwmxF/FWD403AgCcthlel4vbo6kMmbs4fhcZUfrFglpX+1s5AyEB
	Bzk+zagi4k6mXAwKqK0pOsJ7B7bm2GjWrY9Ksl2f389b2QTjNErYO9pdsAhpbjWi
	At5ichuqJnwhUoXGgWRg0UIo8euTpXtu4KPIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MpSPEE7MNbdp4mVZwb8RiKZyVNurqCOg
	DPE8dApmz1l3FZhd0Qv26Y74L+SBQPdYcJpZgcQigdD0M5Hqu+bvjlio5+aTbRGr
	mMflglXx7V02yHQ6P8ngNFHpdNfv3RuQxYY73bNg0Ya6hiWi9ykgpZYXW6ZUNVj8
	V9uV8Sya6k0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 60C7C45AD;
	Wed,  6 Apr 2011 15:50:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 31D0A45AC; Wed,  6 Apr 2011
 15:50:49 -0400 (EDT)
In-Reply-To: <1302115611-1950-3-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 7 Apr 2011 00:16:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2ECC0806-6087-11E0-B55C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171008>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +diff.<driver>.command::
> +	The custom diff driver command.  See linkgit:gitattributes[5]
> +	for details.

This is about "custom", but I thought it was pointed out that ...

> +diff.<driver>.xfuncname::
> +	The regular expression that the custom diff driver should use
> +	to recognize the hunk header.  A built-in pattern may also be
> +	used.  See linkgit:gitattributes[5] for details.
> +
> +diff.<driver>.binary::
> +	Set this option to true to make the custom diff driver treat
> +	files as binary.  See linkgit:gitattributes[5] for details.

... these two don't have much to do with "custom".  You seem to have
dropped "custom" from the remaining three, and I think their description
without "custom" makes more sense.

It is not a problem for me to just amend these two and lose "custom" when
I apply this patch (if there is no other glitch in it, of course), but I
am wondering if these are intentional.

> +diff.<driver>.textconv::
> +diff.<driver>.wordregex::
> +diff.<driver>.cachetextconv::
