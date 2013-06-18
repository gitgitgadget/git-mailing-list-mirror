From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH mz/rebase-tests] rebase topology tests: fix commit names on case-insensitive file systems
Date: Tue, 18 Jun 2013 08:45:01 -0700
Message-ID: <7vsj0f779e.fsf@alter.siamese.dyndns.org>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
	<1370585503-11374-1-git-send-email-martinvonz@gmail.com>
	<51C00C07.6080600@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 18 17:45:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoy5o-00071n-Bj
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 17:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961Ab3FRPpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 11:45:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589Ab3FRPpE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 11:45:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79CD02950A;
	Tue, 18 Jun 2013 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0qYFg5KGifRvwlhhhuGUI+tUSgA=; b=PThd84
	nerIOD9YD+0kH7/IbBa+9hnRAwLpw2qLY9Tm8w1oGjGQaaxuLzSE42yLkkvefP9m
	gJryvQANPnw/N9X9KB22r9a8oTb4QivsZPgEyyrIwzYuhWrnsTw8SKQNn2lyjE2L
	FVwp6HVAB2jpJqr96Ls35bWLwPmH5N491GCWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kKOg5CCRgX5YzsEwBeMU6j4y2coZibmL
	ap8Xa4j6if+74lOCuy4wokl2TsTbnIEJL8ocCqNr9uvYDVr/Rfdf+PmydNrogeHp
	A9+D4g4k6sGjXZix0cOMvlMqtfu43iG5kLVyKq89MB7p9fzW6S5k3E/o5IchIPQM
	2LwW3ATuL90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D69529508;
	Tue, 18 Jun 2013 15:45:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2A8529501;
	Tue, 18 Jun 2013 15:45:02 +0000 (UTC)
In-Reply-To: <51C00C07.6080600@viscovery.net> (Johannes Sixt's message of
	"Tue, 18 Jun 2013 09:28:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A60C544-D82E-11E2-B68C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228253>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> The recently introduced tests used uppercase letters to denote
> cherry-picks of commits having the corresponding lowercase letter names.
> The helper functions also set up tags with the names of the commits.
>
> But this constellation fails on case-insensitive file systems because
> there cannot be distinct tags with names that differ only in case.
>
> Use a less subtle convention for the names of cherry-picked commits.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Knowing that the tests would take their time to complete on Windows,
>  today was the first time I ran them, and there were some unexpected
>  issues. Fixed by this patch.

Thanks, will queue on top of that series.
