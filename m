From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation and Code: Fix misspellings and grammar
Date: Fri, 22 Jun 2012 15:55:19 -0700
Message-ID: <7vd34rlzxk.fsf@alter.siamese.dyndns.org>
References: <1340404814-29790-1-git-send-email-muhtasib@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leila Muhtasib <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 00:55:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiClM-0005ut-F3
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 00:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab2FVWzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 18:55:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab2FVWzV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 18:55:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BB65990A;
	Fri, 22 Jun 2012 18:55:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A6h78rfP2gdg4K4ikS5P0peVldY=; b=AIzqKr
	r9+wvavN18IDa+GkIw/qSDUCWaH4g/h2+uFKbfmFOWgOQhZlHrhJjc+DvqHlt5l9
	KdvopKEf/QlUR2JuTjraKIboPGP07ZtWiH87UP/7CPFN3VN5vhg+QBTmtay5o7Ti
	wqMeZiAHUZCFo+3AvPuqieHA59M2ijZOuaH0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SoH98cWYOsyRNAnfhJQzpRdWEBTZ5j9t
	y3mIIufoURYnn6yJUdYi4eK1J1SHCtkpx2xZFN4YF4dssrHLagY/hoxRWJ5+PRju
	xq2b6V9crzZn/HVVeJbemdATuTOk7uqyPe+GdAyRdTdDxXgF+Q7fhkt0rqmQufgC
	390A9tPmhTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 121E89909;
	Fri, 22 Jun 2012 18:55:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 960BD9907; Fri, 22 Jun 2012
 18:55:20 -0400 (EDT)
In-Reply-To: <1340404814-29790-1-git-send-email-muhtasib@gmail.com> (Leila
 Muhtasib's message of "Fri, 22 Jun 2012 18:40:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57D52032-BCBD-11E1-8B99-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200485>

Leila Muhtasib <muhtasib@gmail.com> writes:

> Signed-off-by: Leila Muhtasib <muhtasib@gmail.com>
> ---
> Let me know if you'd like me to break this up into separate patches.
> I ran 'git grep occured' to make sure I got all of them.

I am tempted to suggest "one word per patch" ;-)

Also you might want to take a look at 

    http://thread.gmane.org/gmane.comp.version-control.git/199033

> Do you think it's a problem to fix misspellings in printf output?

It depends, but in a sense, typos in comments are a lot lower
priority (nobody is hurt if we do not fix them, and if such a fix
interferes with topics in flight, it is more nuisance than it is
worth and it would be greatly appreciated if you hold off typofixes
until the dust settles).

Program output affects the end user experience, so it is more
important.

Changes to strings marked with _() for l10n should come early in the
development cycle so that translators have enough time to prepare
for it before the release.
