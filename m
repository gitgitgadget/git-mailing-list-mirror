From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/2] format-patch --signature-file <file>
Date: Wed, 21 May 2014 14:59:36 -0700
Message-ID: <xmqqk39eoks7.fsf@gitster.dls.corp.google.com>
References: <1400706472-13471-1-git-send-email-jmmahler@gmail.com>
	<1400706472-13471-3-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 23:59:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEY6-0003AG-O9
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbaEUV7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:59:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51751 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753713AbaEUV7l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:59:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2EAD618B12;
	Wed, 21 May 2014 17:59:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F7HzVXh4Vhm58Mq7ltxLCcjb8RI=; b=eeibCF
	+c5nLICN6xvIefWMg5sioVp69FbyXEqf6LuuqxVck27GTtLBQcr0REbUshWWyd0B
	blGJwtDH0j8adACTvq3ALEMyt9zVCUaNqOs2fbG2LR0bWWUgIFRJNud/zW5hpbYH
	J0LGDyKD8B0aAxFMXulO9NOSTow+nFlGjmkFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vCIDN/D3OJrsPGqVn3Al1EJRnSB9/71o
	4JE+XVlQoUJTi7aLQKFD611Q9c76AARiRCr/3/+3eG6lNA5ryCBPii8fdiBSIuVO
	ifJAjVgBPNXpJzJH77YXDstp94XksK2ayMERdyPYJUMGqUHd8h3o0xZgPzw0QJgb
	ZgbQjgqjS04=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 235CE18B10;
	Wed, 21 May 2014 17:59:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BC52618B0B;
	Wed, 21 May 2014 17:59:37 -0400 (EDT)
In-Reply-To: <1400706472-13471-3-git-send-email-jmmahler@gmail.com> (Jeremiah
	Mahler's message of "Wed, 21 May 2014 14:07:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 33AD6D26-E133-11E3-9B28-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249842>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> +	if (signature_file) {
> +		if (signature && signature != git_version_string)
> +			die(_("cannot specify both signature and signature-file"));
> +
> +		struct strbuf buf = STRBUF_INIT;

builtin/log.c:1460:3: error: ISO C90 forbids mixed declarations and
code [-Werror=declaration-after-statement]
