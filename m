From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GUILT] handle branches with slashes in guilt-graph
Date: Tue, 18 Oct 2011 12:15:40 -0700
Message-ID: <7vy5wif6w3.fsf@alter.siamese.dyndns.org>
References: <4E9D57BB.2030707@opera.com> <m2r52adu65.fsf@igel.home>
 <7v39eqglle.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Per Cederqvist <cederp@opera.com>,
	Jeff Sipek <jeffpc@josefsipek.net>, git@vger.kernel.org,
	ceder@lysator.liu.se
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Oct 18 21:15:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGF8m-0001Hi-4C
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 21:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478Ab1JRTPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 15:15:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52034 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753451Ab1JRTPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 15:15:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFD436F25;
	Tue, 18 Oct 2011 15:15:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QudWwqcxkdAh2SIdXMTE+YX2PTU=; b=ruc4/d
	XGpxILh7keryEJF672oJJiX21kuq8AgaceoN1KgAsNOGcyglE7pWPZAXXV9yiTQr
	pvBbEFWxPIhUDvSEJPLRwB3MxhIOdvf17Gxlcxuq8C7TvRWOsCN45PLhEXBUBzMt
	T/YLqVxHElWD3MuSx3BNMJ5IPXj8RV4N6Qt7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vc+zvjaePe8QCPYWLToTWU+s+2T2+Yyj
	fly85s5+0aUvsnJ9M++pipGl9IgATjzt2F2iAsO8MJtzXB6Q8HQbf5E/HtnXMH0m
	kHzXDo3NUcBQxxVnvsK7nGzZfT9ZGf/jJMo3CTZ0eHmpdsVHyniJssN83ThmXPBe
	L1FV5pEolNA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A57E36F24;
	Tue, 18 Oct 2011 15:15:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 234AF6F23; Tue, 18 Oct 2011
 15:15:42 -0400 (EDT)
In-Reply-To: <7v39eqglle.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 18 Oct 2011 12:12:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92685FCA-F9BD-11E0-BA40-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183898>

Junio C Hamano <gitster@pobox.com> writes:

>> Alternatively, you could change the delimiter to `,':
>>
>>   \,^$current refs/patches/$branch, {
>
> Isn't a comma still valid character in a branch name?
>
> The vertical var | is available, though ;-)

Nah, sorry, '|' is not.
