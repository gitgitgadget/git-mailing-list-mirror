From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setgitperms.perl dirty index problem
Date: Mon, 24 May 2010 22:37:22 -0700
Message-ID: <7v632cwnhp.fsf@alter.siamese.dyndns.org>
References: <201003190149.03025.trast@student.ethz.ch>
 <hp2jkj$mu0$1@dough.gmane.org> <7vbpe3qe09.fsf@alter.siamese.dyndns.org>
 <4BE095D9.6090403@mhg2.com> <htebs9$ann$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>
X-From: git-owner@vger.kernel.org Tue May 25 07:37:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGmpb-0005I3-54
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 07:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746Ab0EYFha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 01:37:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab0EYFh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 01:37:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74415B67C0;
	Tue, 25 May 2010 01:37:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AmK2MUnrGhvOcFX3dSy4NMVnAEM=; b=g+Flmp
	fQR26es7D3ljBw03QJ+OqcWNJcpvPpo0f7UHFeY1RKX9ZF678cUIygilV2tW0VYT
	IXXpIWDSmXMwCrzB7D4Fcgq2DMDp8C0+A/pB2k14QkcbRHcHAi5nX9k/y5UPOp2Z
	7uv4ZmPMQWrwEkX9CcpNSOcoBJamp4amvM/48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jEkE3dNdpRKyAycNuOTQZkY6pUnjwPHg
	chFF6D+Ro/EvvUH1KdcBcZvDQCU1KggVWOO3AqLabG83a5nC+0FRc4BeRt5rRVX7
	W28FwfSNeazCyWPVAcbRb1xiTyePuPufJcbzewIaDoi/GmjWy9iHiGgHz6MmELn4
	xVEwISiiZyM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 31EBFB67BD;
	Tue, 25 May 2010 01:37:27 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CC20B67BB; Tue, 25 May
 2010 01:37:24 -0400 (EDT)
In-Reply-To: <htebs9$ann$1@dough.gmane.org> (Scott R. Godin's message of
 "Mon\, 24 May 2010 13\:09\:28 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9A6DD6F0-67BF-11DF-8EF0-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147664>

"Scott R. Godin" <scottg.wp-hackers@mhg2.com> writes:

> On 05/04/2010 05:47 PM, Scott R. Godin wrote:
>
> Hadn't seen any response to this so I'm reposting in the hopes that
> this will make it to the next release.

Could you fix the "format=flowed" and also sign-off the patch?
