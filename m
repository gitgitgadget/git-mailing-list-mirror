From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/9] remote-helpers: fixes and cleanups
Date: Fri, 26 Apr 2013 15:16:12 -0700
Message-ID: <7vwqrpuedv.fsf@alter.siamese.dyndns.org>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 00:16:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVqwF-00017j-VS
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 00:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab3DZWQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 18:16:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47323 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512Ab3DZWQO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 18:16:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5463519CA8;
	Fri, 26 Apr 2013 22:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D36YMrQnCqVojHvIab0U4W7DLqg=; b=fon3s2
	APXERDiwkLIQ85nUb4T50iqut6WwTSIJCar77fF1HNskOoaIY7oO20hMzOXNOqVY
	74HnNzQ5tHS3fgtGn3W6MzbNbKmfQ7x1LkOoz+UamiE6Gdfu7df+7Snm8KNgBFTC
	j2CJ1G6dx+WOVR5Pb8EmVR12jib2cD4nDwK4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K2i7KyUxwANmO4GNWtfIYSKwnzgacdBY
	uB62wbUFYJpGM7eY5wH/xjy62Sx3vXUBdJNSsLBaN5eoCCRigxGI4ShbGiUbLgpA
	jo77m44LuYqSqDdsD0UGcP81q2f25rwxyW/waK25/l8uqPM1HuWa/E3+0Sm+1Gt+
	eiKitthiFIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 487E519CA7;
	Fri, 26 Apr 2013 22:16:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA9D519CA5;
	Fri, 26 Apr 2013 22:16:13 +0000 (UTC)
In-Reply-To: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 26 Apr 2013 16:12:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E830FA2C-AEBE-11E2-A227-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222596>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Updated the commit messages, so we say Bazaar instead of Mercurial, and stuff.
>
> Here's a bunch of cleanups mostly to synchronize remote-bzr and remote-hg.

Thanks.  Will queue on 'pu' without looking.
