From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Tue, 09 Jul 2013 13:39:26 -0700
Message-ID: <7vd2qrv56p.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<20130709201724.GI4604@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 22:39:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwehB-0005ok-M0
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 22:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab3GIUj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 16:39:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33589 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454Ab3GIUj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 16:39:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66B912F85A;
	Tue,  9 Jul 2013 20:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yHYvNU98rs6UThKEmExrWGNJ43w=; b=UK2ko5
	R35oTNsOOdfp6Cq4yvkORIf2RA1+5KpfUdAnawTy2uJW9Os+5OGfIJRCQJJ8jDM8
	WlXPeIu/+/mTPBdre+08zDM4bP1AhRBFYjxvzFoymBmf9xCeHhWgLjgb8OU0Ty38
	JH6Tn3phPeT/yHBmAsKMAkffKqlggR2zBgl6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=by+Sr1Jf9cBaRR0hpqmcCIvzm7ezbhyH
	FP3/fOZfNr1bD8Zh1UKiloas85QxExdPNspf1zq7367fe8oTzZQB8bZIe7Wn+LCA
	z1HN4UPK5GJ1Qfvv5OyYevxwJI36eG8OeDhZB1uPShmxYbTO9a6rYXLB2EdUtbnh
	qHydqunEcvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D81B2F859;
	Tue,  9 Jul 2013 20:39:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D18822F857;
	Tue,  9 Jul 2013 20:39:27 +0000 (UTC)
In-Reply-To: <20130709201724.GI4604@pug.qqx.org> (Aaron Schrab's message of
	"Tue, 9 Jul 2013 16:17:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A635C01E-E8D7-11E2-A1BD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230004>

Aaron Schrab <aaron@schrab.com> writes:

> How does this behave if --force is not used?

Both the usual "must fast-forward" safety and the "ref should not
have moved" safety apply.
