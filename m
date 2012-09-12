From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] attr: "binary" attribute should choose built-in
 "binary" merge driver
Date: Wed, 12 Sep 2012 10:01:30 -0700
Message-ID: <7vhar3dvkl.fsf@alter.siamese.dyndns.org>
References: <1734879571.321704.1347454681726.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 19:02:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBqK7-0007WY-UE
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 19:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760619Ab2ILRBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 13:01:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760607Ab2ILRBd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 13:01:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E929E9D18;
	Wed, 12 Sep 2012 13:01:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q780atyWBNOr0mbL6JX1OBTz7OU=; b=J0GaX/
	buymdmHsWt+lEMiarkLQkJLCVQ0D6qnMUx3a79Bb8sgZxpWO+KnHC8DNXojNfWrJ
	boNWsE5OHDpy8ZbUV3SSk5Kawdd/fOrI39SKTbOaoyOZyADpdWCHOZBDbbldoYp7
	GnPS6kV+lWWA3eDAA4tgKhmoiQlblymBGAPeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=stcwqwk2ZgkpS7T3Wkh+UcSI/vDcPBxm
	vToeveOwC7VkwwSaCQO3wvjfFyzbWUtDb3rOfPy6o7w4Swx212GOYmcm9S2Py7qc
	3gR2+ngmEFEiofgQdoz1wjtGtfk7T6L5fEVEinCg4+qBDb6toA4UJi8Gko9gEh4b
	gqdHDyyn99M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D71589D17;
	Wed, 12 Sep 2012 13:01:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0D849D14; Wed, 12 Sep 2012
 13:01:31 -0400 (EDT)
In-Reply-To: <1734879571.321704.1347454681726.JavaMail.root@genarts.com>
 (Stephen Bash's message of "Wed, 12 Sep 2012 08:58:01 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80749BF2-FCFB-11E1-9E7C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205309>

Stephen Bash <bash@genarts.com> writes:

>> Perhaps something like this makes it better.
>
> Patch didn't apply on top of the previous two for me,...

Look at 'pu' and see how it applies.

> ...  The only remaining
> question for me is should -Xtheirs resolve "deleted by them"
> conflicts?

I do not know, and I do not care to worry about it too deeply, which
means I would rather err on the safe side and have users inspect the
situation, make the decision when such a conflict happens and
resolve them themselves, instead of claiming a clean resolution that
is possibly wrong.
