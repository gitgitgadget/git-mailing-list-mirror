From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Show extra branch refs in gitweb v6
Date: Wed, 04 Dec 2013 12:37:28 -0800
Message-ID: <xmqqob4wjqt3.fsf@gitster.dls.corp.google.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, sunshine@sunshineco.com
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 21:37:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoJCS-0001jY-1l
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 21:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174Ab3LDUhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 15:37:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55660 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932420Ab3LDUhb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 15:37:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBB3557222;
	Wed,  4 Dec 2013 15:37:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EjKoPAa14+KmY6no4ahVqc9wTb4=; b=VdiI+6
	E+1oDp6c+cJCQx+KT8OR25qYVvG11S3YBdrJ46tnZz3pUeV18a8xmxz5bluY3B91
	UKlxlr4HeII4XsLIvTfH0B2rzm58pYIkOkAVriYFxZ9aDSc5xuvFywqWAffFbm3Y
	cZvMXPmJnbzi714SLl1tJWI9eLBs34605igxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uh0b7+NnFMfMVQIwMj05xzqSJPFs7X7u
	j62+YGDVBBnKU2eRhF2fxxoZZ70ZmuZw+ADg2nigi54apnKHst6ukyvnXoueeQwP
	exZT8GIWns3D3+bA0OExFYhzTnHdRj+9T2bXr3cOTrEK9Es5wMZsD2Snw+1nUzme
	+xK2okUkDiw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8E5057221;
	Wed,  4 Dec 2013 15:37:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A31457220;
	Wed,  4 Dec 2013 15:37:30 -0500 (EST)
In-Reply-To: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	(Krzesimir Nowak's message of "Wed, 4 Dec 2013 14:42:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E5334050-5D23-11E3-845F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238812>

Krzesimir Nowak <krzesimir@endocode.com> writes:

> First patch just adds a comment I though would be useful when trying
> to understand how config parsing is done.
>
> Second patch splits some code to a function.
>
> Third patch fixes validation functions to return either 0 or 1,
> instead of undef or passed $input.
>
> Fourth patch adds the extra-branch-feature and some documentation.
>
> Fifth patch adds some visual differentation of branches from
> non-standard ref directories.
>
> Krzesimir Nowak (5):
>   gitweb: Add a comment explaining the meaning of $/
>   gitweb: Move check-ref-format code into separate function
>   gitweb: Return plain booleans in validation methods
>   gitweb: Add a feature for adding more branch refs
>   gitweb: Denote non-heads, non-remotes branches
>
>  Documentation/gitweb.conf.txt |  27 +++++++
>  gitweb/gitweb.perl            | 166 +++++++++++++++++++++++++++++++++---------
>  2 files changed, 160 insertions(+), 33 deletions(-)

Thanks; I'll tentatively queue 2 thru 5 on 'pu', but people are
feeding good suggestions on it, so I'd expect further rerolls.

A tip: "git format-patch -v7 --cover-letter" may be handy.
