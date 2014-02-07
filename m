From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 07/14] trailer: add interpret-trailers command
Date: Fri, 07 Feb 2014 12:35:08 -0800
Message-ID: <xmqq7g96veyr.fsf@gitster.dls.corp.google.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.48784.chriscool@tuxfamily.org>
	<xmqqiosrwzoh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD10aGq+cUcaiMHRKsLLKvF1eYUuM+G85MRHqhwBXZVv-g@mail.gmail.com>
	<xmqqk3d6vlow.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 21:35:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBs9A-00073l-2m
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 21:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbaBGUf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 15:35:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40465 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580AbaBGUf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 15:35:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84FCA6AD59;
	Fri,  7 Feb 2014 15:35:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ac0/zUxyFiI8kzroW3Lt6khgIuQ=; b=JSPIMI
	67M5R98xxi78nzWF6YNGFNsvL9hnbAjoQJu+Hhs387xcorXoWaAocZdByO2pLCsT
	l+0GPp07xUBxeSSSfD2h5hEQLI73+h4hpN4DqtSWHFeWXQdKvkUoBr2G9VHI5HOw
	8q/mHSAgNHPw93oO4apVGVY6pFLkEoxVvJOtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tqccu3uEpBMjYiw/+OvGc7nu0bITHPmV
	/K3LAlVyP8oMRas/8oUAeEbDY+qwPfeoS6LDc4BcI7v7b0P4g+aGMrzNkB1YqfzE
	Ft5wXO7lDn1tVuVeZB0G00zC/oS1wIcGVMl1KdthgYcdC31JV1Fe1BepQXFZxssk
	nprLAPTTp5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 559B86AD50;
	Fri,  7 Feb 2014 15:35:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5FA96AD46;
	Fri,  7 Feb 2014 15:35:18 -0500 (EST)
In-Reply-To: <xmqqk3d6vlow.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 07 Feb 2014 10:09:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5BF09968-9037-11E3-B0D5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241793>

Junio C Hamano <gitster@pobox.com> writes:

> ... RUN_SETUP at 7/14 and then change the same line to have RUN_SETUP
> when you start to need it could be an option; I am *not* suggesting
> that.

Sorry, typo.  s/could be an option;/;/
