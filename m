From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git 1.7.12 installer blocked by Gatekeeper - needs signing with
 an Apple developer ID
Date: Wed, 19 Sep 2012 10:31:58 -0700
Message-ID: <7vr4pxhqb5.fsf@alter.siamese.dyndns.org>
References: <954DDAEA-30AF-4203-BD49-3AB163E4EF58@telenet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten Louland <torsten.louland@telenet.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 19:32:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEO8C-0002ir-Fl
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab2ISRcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:32:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62753 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756631Ab2ISRcA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:32:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 659CE9946;
	Wed, 19 Sep 2012 13:32:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=baZyMxVmcI+9Q+P2nZjVEqAMpCY=; b=xAHOX3
	1hXewDF1/BSjhGXVxIsmqEpK5yJu3iK0pCpLn+48cwUjPSfu2Zc/XBX58Adq3pId
	NwDerf3P8Jq/WJbvnNcNk3j35SHFRCMDaYnJtlEGOig5Qj/txCAdvhZdg9R0Upvh
	ivOADdnE2iD+iLre6ZG/WVVHEB0SAc4nHdLxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C+jMykhQrh8udk4svlNN4gVC0RD/BFPp
	JkdCYP+5UJweh6POvyFIF5vldqTDoyqV+2WRKRGQzN1gnS6C0QHe67KoE+PAyVGd
	k452mGaEJLAmqUZcGA048MF8tK45JD+j3DidqyYiWiDhuz/amB61eMD49SenBTce
	mP3EyYjlbVM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52DBC9944;
	Wed, 19 Sep 2012 13:32:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA1489941; Wed, 19 Sep 2012
 13:31:59 -0400 (EDT)
In-Reply-To: <954DDAEA-30AF-4203-BD49-3AB163E4EF58@telenet.be> (Torsten
 Louland's message of "Wed, 19 Sep 2012 07:59:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EABF4AE6-027F-11E2-A6D4-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205956>

Torsten Louland <torsten.louland@telenet.be> writes:

> Installing latest stable git on Mac OS X Mountain Lion is blocked
> by Gatekeeper.
>
> Could you provide an installer for latest stable git that is
> signed with an Apple issued developer ID so gatekeeper will let it
> through?

I am assuming that this is about the mechanism to block installation
or execution of binaries obtained from outside the Apple store, and
anything built from the source are exempt.

If that assumption is mistaken, please correct/educate me and
disregard the rest of the message.

I release only the source tarballs and no longer do any pre-built
binaries (I used to do so only for RPM), and Torsten must be getting
a(n unsigned) binary from somewhere; the request needs to be given
to whoever is supplying a pre-built binary for MacOS, but I do not
know who that entity is.

Whoever you are, please speak up and help Torsten and fellow MacOS
folks.

Thanks.
