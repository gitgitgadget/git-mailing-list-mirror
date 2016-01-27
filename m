From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/19] Let Git's tests pass on Windows
Date: Wed, 27 Jan 2016 12:24:28 -0800
Message-ID: <xmqqvb6e7oub.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<cover.1453818789.git.johannes.schindelin@gmx.de>
	<xmqqbn88at2y.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601270936440.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 27 21:24:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOWds-0004xm-Tf
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 21:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934996AbcA0UYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 15:24:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934924AbcA0UYb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 15:24:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 497CD3E0C9;
	Wed, 27 Jan 2016 15:24:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XaRF2tQQiBST5c+26G01JoqBe7A=; b=ZpVWuD
	oIarHPQgusGMd1MhB+WJG9UsBoB8xKdlgreAO6nWz+ARfyoGINlDL679cirqaGEY
	gVyU5y5A1NGDFeXPWoAf0l0OfNoAajzRKEWz7HvO0bNczPKxPNSdM7Hc5zybsIib
	B2rEBdW77QFx6UShqlwzcVs5OEPsXKQpKn+qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F6zNwaghfc1dAOkVbXJRkI/fxevR8eFr
	/zZRf7uyCFEnCrQBrJnhbdpuq4+90UUdRqTPn/upp7/7AFhC0sOSnSbMlBLiPn4W
	V3uJUecHrXOk57lDXgZXA24wlm1mqDAFjEtplPyQAVdDARPwOphlLL5S6HJ6CzOg
	CEYXx4gfM20=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 40BE23E0C7;
	Wed, 27 Jan 2016 15:24:30 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B8DCD3E0C6;
	Wed, 27 Jan 2016 15:24:29 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601270936440.2964@virtualbox> (Johannes
	Schindelin's message of "Wed, 27 Jan 2016 09:38:46 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7E5C9F0-C533-11E5-8A42-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I made a couple of other adjustments anyway, so expect a new iteration
> shortly. This time cross-checked on Linux.

Thanks, will take a look.
