From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #07; Fri, 28)
Date: Sun, 30 Mar 2014 00:51:35 -0700
Message-ID: <7vlhvsnmyg.fsf@alter.siamese.dyndns.org>
References: <xmqqtxai7ym6.fsf@gitster.dls.corp.google.com>
	<53360457.1060008@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brad King <brad.king@kitware.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Mar 30 09:50:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUAVk-0000al-Je
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 09:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbaC3HuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 03:50:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62544 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbaC3HuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 03:50:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A9E77149A;
	Sun, 30 Mar 2014 03:50:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cPZs1LjvoJCQGEjokFTt0EujXRM=; b=UBjx1L
	arzmaXg/5Qu5YFlVONem/e3Q2wsddYYuKFOOOcrzhWVq6GirllAzkTvoBQ/GCXq4
	ELL8zxkNzCPn2fTyAOl77+8Jvi/g55IK6q4mW6BMHcWpBI/THbtcgBHvk8l0O+Q5
	QixPM9CW23lpGv+WxnTCEHbIh3avE29LbTd3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UVKMhVVkqPmvaPnj1ePlt3fUDm0i9OBZ
	qZemb1rZGlpH59EG59Jd57ERaVBGUzmRpMk/F0iQ2ztjIIOhLANdSe1at6jCwhyb
	8ZggxWu6690MDkmldLt5QRvgJshOYgYpNoTjsAqKYB3AsW6MKj7+Tb2Ld34eo4eT
	TEGKvtgCdF8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E584271499;
	Sun, 30 Mar 2014 03:50:14 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F78371498;
	Sun, 30 Mar 2014 03:50:14 -0400 (EDT)
In-Reply-To: <53360457.1060008@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 29 Mar 2014 00:23:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: ED9D712C-B7DF-11E3-8D7A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245454>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 03/28/2014 11:21 PM, Junio C Hamano wrote:
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.
>
> Junio,
>
> Have you overlooked my ref-transactions series [1], or just not gotten
> to it yet?

Mixture of 20% of "too busy" and 80% procrastination, trusting that
an important and interesting topic will get a few rounds of reviews
under competent sets of eyes before I get to it ;-)

> If you would like a version of the series that already addresses Brad
> King's comments, you can get it from my GitHub fork [2], the
> "ref-transactions" branch.  I'd be happy to post a v3 to the list if you
> prefer, but the only changes since v2 were to a commit message and a
> comment so it seems like overkill.
