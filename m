From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] allow more sources for config values
Date: Thu, 09 May 2013 14:00:29 -0700
Message-ID: <7vk3n798cy.fsf@alter.siamese.dyndns.org>
References: <20130509161636.GB3526@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu May 09 23:00:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaXx7-000541-SC
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 23:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970Ab3EIVAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 17:00:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32928 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab3EIVAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 17:00:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 192A71D999;
	Thu,  9 May 2013 21:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DrD7jdccHZ4f/1capcq+lMYYKVs=; b=Y6M+5a
	zZsioUXbFrMwGtU9y1KWFNz7yRmVPu8He3knETld76qOG1tmEJLFNNSFZP6xJjLr
	VcBlP5M1EuL1ES8EhH4TaNgyTB+n1RLdj7D6ZwYZPlw7UHfXP8n5UcaXn/xPGSWZ
	0tRQFGsI3BbQJFJWrnl7uvC6TXkWi4dMq67p4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jhipeP/JnsWGK+Mb4Ls8pOhFQ9bVc07u
	vbXI8fcvGfEcHJjq9csxvfOVlVZ+IDto7z4mcFlUjejzfER4vkO2pXetMtrGeW7W
	pQLeUqjmUlBOUTBsfqJYd9V7w25FprNLsEoTfWVMzFr5CaI+hZjPVmgXr8q+Eu39
	E3ifmJkGNZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 076761D998;
	Thu,  9 May 2013 21:00:32 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DA021D997;
	Thu,  9 May 2013 21:00:31 +0000 (UTC)
In-Reply-To: <20130509161636.GB3526@book-mint> (Heiko Voigt's message of "Thu,
	9 May 2013 18:16:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C354170-B8EB-11E2-A78C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223781>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> I fixed all the issues I know of so this should be ready for master.

Thanks for working on thsi, but that is 'master after 1.8.3' at this
point in the release cycle.

I am declaring patch bankruptcy and will not be picking up new
patches that are not regression fixes meant for 1.8.3 or subsystem
updates to my tree.  I am mildly upset that nobody (including
myself) caught the show-stopper regression to cherry-pick, even
though it has been on 'master' for more than 20 days.

Please do continue discussing this and other patches on the list,
and please do plan to re-submit after dust settles post 1.8.3
release.

Thanks.
