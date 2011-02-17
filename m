From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 (v2)] submodule: no [--merge|--rebase] when newly
 cloned
Date: Thu, 17 Feb 2011 15:37:27 -0800
Message-ID: <7vr5b68c7c.fsf@alter.siamese.dyndns.org>
References: <1297959526-8089-1-git-send-email-olsonse@umich.edu>
 <4D5D7A06.6050700@web.de> <7vzkpu9zo0.fsf@alter.siamese.dyndns.org>
 <201102171517.15906.olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Fri Feb 18 00:37:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqDPs-0001BB-IM
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 00:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab1BQXhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 18:37:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33764 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1BQXhj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 18:37:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5B8FB4BC4;
	Thu, 17 Feb 2011 18:38:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AlzKxnA0hbWK80MvvJU883j+lOc=; b=TGxSiL
	+nuYvBVW79+I/IRNyHtOLNa4rb9q9HLatA6PruKADJ8437cTpWcsiBgxKiEFCqgT
	aRLxPSgk8iknnZDnJkRjMzNJhiYnMkpxDLV/3D6ogvyAkDJv1L5w81q84vnGtzZ2
	st1cHunzY6uQ2PdFdTUC2Iyo/Llz7M54PBZvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r8AZjqMEBb1DU9bQ6QZ9YUvyu7UW9jsF
	JRUCHXCa2dKTNdhs4tFyY2NeVtOAFVKPgpBegIAWjgwI5brsN645YG+91Ll65Vqb
	Q7mpMIsbVSbqFeYzjKCNJHI99lR7IGby7h4s9DMHYFDzyDwK6NF6LDNyNV1gMFRr
	FtG4mKI5heU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B9AF4BC3;
	Thu, 17 Feb 2011 18:38:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DFB4C4BC2; Thu, 17 Feb 2011
 18:38:35 -0500 (EST)
In-Reply-To: <201102171517.15906.olsonse@umich.edu> (Spencer E. Olson's
 message of "Thu\, 17 Feb 2011 15\:17\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D08C938-3AEF-11E0-B96A-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167135>

"Spencer E. Olson" <olsonse@umich.edu> writes:

> This looks fine by me.
>
> What about the testing patch?  It'll be a few hours before I can resubmit 
> with "git submodule status submodule" changed to "git status -s submodule".

I just squashed the patch from Jens in, with Ack from him.
