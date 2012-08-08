From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] check-docs: update non-command documentation list
Date: Wed, 08 Aug 2012 15:51:37 -0700
Message-ID: <7v1ujhq9om.fsf@alter.siamese.dyndns.org>
References: <20120808183132.GA24550@sigill.intra.peff.net>
 <20120808183433.GB24574@sigill.intra.peff.net>
 <7vwr19rxua.fsf@alter.siamese.dyndns.org>
 <20120808205456.GB29528@sigill.intra.peff.net>
 <C64F75694EC040349CFE91CD69EDB2DC@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	<git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:51:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzF6Q-0001GI-1M
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 00:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849Ab2HHWvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 18:51:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757551Ab2HHWvk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 18:51:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C261A7D0F;
	Wed,  8 Aug 2012 18:51:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FdQhPnCQZwtLvPwKTOJ8czhmm48=; b=oUWx2C
	AyYJ4FK8RdLf154CQOHG1PCaNIjdnPjzYPeuLiB5x8T2q/1gWetkcirx2GwZLRhR
	zmsCY8fouSGO4gEIQT7Q3Z0lQofi95K9NYRLCpprQIzkQGSB9NgzxiSo7P6U4pvq
	YMfX2QqOqkeb/vlpkla+b1PaF6WdN0k6pjv8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H85zmJcJI0k/JZum6gcMk/nvtsxGujCF
	6wl8TxizT3uKRq6/0iLmcddeK7+3ARNuN/tLjzT1WPn1W/yR3etDX4ljfehubjJX
	ERlzj5LT+1TzauYWzpEFOZ6QjqwN55L8DptrrS1rIkOhAjQfyLzUWcqRSZJmUh6D
	owjmq61wN6k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF8A27D0E;
	Wed,  8 Aug 2012 18:51:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22A767D0D; Wed,  8 Aug 2012
 18:51:39 -0400 (EDT)
In-Reply-To: <C64F75694EC040349CFE91CD69EDB2DC@PhilipOakley> (Philip Oakley's
 message of "Wed, 8 Aug 2012 23:11:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D3D0B36-E1AB-11E1-A822-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203141>

"Philip Oakley" <philipoakley@iee.org> writes:

> One issue I notice a few weeks ago is that `git help --all` does not
> list all of the available git help pages, rather it just limits itself
> to the available command pages.
>
> This means that new users can't discover those additional help pages
> in any easy manner.

That would be a problem _only_ if these "additional help pages" are
of importance for new users.  I do not think things that come from
Documentation/technical and ARTICLES (in Documentation/Makefile)
qualify as such.

I'd be perfectly happy as long as all documents are reachable from
git.html in html-fied documentation (the man pages have equivalent
cross references, I think).
