From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.c: Spell the null pointer as NULL
Date: Thu, 24 Oct 2013 14:42:55 -0700
Message-ID: <xmqq1u3amjkw.fsf@gitster.dls.corp.google.com>
References: <5269804F.2080800@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 24 23:43:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZSgJ-0004TK-1A
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 23:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979Ab3JXVm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 17:42:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840Ab3JXVm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 17:42:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C18F84D300;
	Thu, 24 Oct 2013 21:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=u5FW13
	Xp5/tIMiLkFm2FWtoA/2JZbL+lV9QjTisgJDXYuC27YJwTRLge8SFvWWm+uuopFx
	99kk0NgGIIkkTqUJYcehyzEDFeLORkiQCrVQqe7ft8xM5f2IR22EizrOwBfAO6dA
	MEfgOVkAeR8j/s3CR8NHT5PNY+g/wh5RVhzxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KYNhmc8XG/tXTXrpouiSplysr34CKniE
	Dr258SxYIy1C+sVzvaLIbfMBo4U/L/3fFhBovFGpHz71dVz2Dtdxn6EiEkO48Pmc
	t/vD300PMf9NCZDhQPDZpJnpakTwuwQpjYZhDTqSBfAEK4+s11OTb6kS/CS5q0Ap
	y5VS8/Kb06s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B23994D2FF;
	Thu, 24 Oct 2013 21:42:57 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BB554D2F7;
	Thu, 24 Oct 2013 21:42:57 +0000 (UTC)
In-Reply-To: <5269804F.2080800@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Thu, 24 Oct 2013 21:17:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3EE6B70C-3CF5-11E3-9BAD-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236630>

Thanks.
