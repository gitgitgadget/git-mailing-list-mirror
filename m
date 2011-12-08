From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Disabling Delta Compression on a fetch
Date: Thu, 08 Dec 2011 12:10:40 -0800
Message-ID: <7vvcpqhlj3.fsf@alter.siamese.dyndns.org>
References: <070681D4-F87B-435E-8A3B-144E59DE722B@cpanel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Todd Rinaldo <toddr@cpanel.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 21:10:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYkIq-0001AK-OK
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 21:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988Ab1LHUKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 15:10:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855Ab1LHUKn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 15:10:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE7666B9D;
	Thu,  8 Dec 2011 15:10:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4pxYX5jHYFz9i1SZPuJLWA7NHZ0=; b=tVFusA
	te1KWT4ETxbwlxDIOV662WantTx0UnJqw5NgY7vnj1fJVzwNqqYhlRiv7fDNespN
	ZyMnigV1XwsSIWRfaXM0svyKzOLuvppgfdQ8wvKph6tD6eVDqnQoVaSv3Ev1ULxR
	bEOc0hx3TPxV7sWqRCalw2Hf/4ksd/d4tGF3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A0CONZlJDFnUfU5KpKo141CixcVaJ+hU
	Jf+CRCgX+3rb3dWrcwg1x60OK45JWb2dZz+8XIq6Gf8c7aPmt2FpVluYzPLzmB6f
	o172mn/ea/+BegHnTiUx7UcgPKBn7z0hZEUPdyT+g3z8uRnOztSqZuO7bFwb5ywK
	A3ct4RvNs5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4E7A6B9B;
	Thu,  8 Dec 2011 15:10:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 656886B9A; Thu,  8 Dec 2011
 15:10:42 -0500 (EST)
In-Reply-To: <070681D4-F87B-435E-8A3B-144E59DE722B@cpanel.net> (Todd
 Rinaldo's message of "Thu, 8 Dec 2011 11:34:26 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B496C79C-21D8-11E1-8B89-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186592>

Todd Rinaldo <toddr@cpanel.net> writes:

> The solution I've come up with is to set pack.window=0 in /etc/gitconfig on the gitorious server. 

Wouldn't setting core.bigfilethreshold be a more appropriate solution?
