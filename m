From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] completion: backwards compatibility fix
Date: Sat, 19 May 2012 22:11:55 -0700
Message-ID: <7vaa13bfms.fsf@alter.siamese.dyndns.org>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carsten Mattner <carstenmattner@googlemail.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 07:12:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVyRX-0000aU-VI
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 07:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991Ab2ETFL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 01:11:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876Ab2ETFL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 01:11:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D89C6109;
	Sun, 20 May 2012 01:11:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pFPbZ00quwqspU55r/ySBamZtcc=; b=HZ/O/F
	nJ9d9kicW61VggL+KxF+JCjJfurQqxnATB9WnH6yJq4sD5tFFBCYFAjdDlF9QrQE
	7S3MJYO1kjOKoY4vI9AHrfn7L5m2sgmX1QjeYr5aEZAYQQLfv3XPsVIbqSD5LKKq
	BGbYNe5/OcAM2DuBYVwV+mUgksS4nrBOV4dvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HxzYTte+lQU6e0HEMc36mn4JibkI7HGj
	DWMF7GVReOMQKEycaeUE4NGGgXuG1U4LiPzGI+2XvdForiyNn6it33mLiaMvuJX0
	wee/u91Lt7B5861UcLb8cKwiJuuE81NZBf6OUgbf9kE8YO379hKS+R82RzKds/Vh
	0jZqGujri7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 446466108;
	Sun, 20 May 2012 01:11:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C91A16107; Sun, 20 May 2012
 01:11:56 -0400 (EDT)
In-Reply-To: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sat, 19 May 2012 04:41:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 522D891E-A23A-11E1-9B34-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198049>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> These two patches are meant to fix the backwards compatibility of _git, and
> _gitk.

Thanks.

Even though I think these two should be squashed into one "fix regression
that made _git and _gitk behave differently" commit (because otherwise the
result of applying the first one makes _git/_gitk disappear, shifting the
breakage from "older usage fails inside _git" to "older usage fails to
even find _git", the end result looks good.
