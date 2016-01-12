From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/12] use the $( ... ) construct for command substitution
Date: Tue, 12 Jan 2016 11:51:22 -0800
Message-ID: <xmqqh9iitw3p.fsf@gitster.mtv.corp.google.com>
References: <1452599378-47882-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 20:51:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ4yX-0006N8-89
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 20:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbcALTvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 14:51:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751156AbcALTvY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 14:51:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2247B3BD8C;
	Tue, 12 Jan 2016 14:51:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T5vmbQi5g33/ga6VQSQpQpjsXAw=; b=mOU8Yj
	LUjY06JAybDsTYFE2Qzv2Jqws2SbkMWh14QhbUkTvRy1DRnuBB0ur9LPdxLqwfXN
	I4XcRU42XoACaZkbwNN65pvGnsXzRibGW7oe5CIKk4YQzaZ9Hg4yguh2DhCXDMwS
	UZ0Y0FwshGmfJ4Tbsa3FCc+PRdaQn8fw8MqiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=On3wXB9awdwi5pRwRSMvJxgF+Svcsr+A
	GQd33JcD+G2E7l5SDz9LuTF+dEwgofbiqiGDtVrjQDzTYhV/c3Y2dOYKUsaZsHts
	Sjx434rxpAlIuFwzTRcjJoVjZChPWdiDC4ls7mY68gNjfKlq4hVHJhefzczTbwug
	dtgCHZrVprQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 18AAE3BD8B;
	Tue, 12 Jan 2016 14:51:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8A0EA3BD8A;
	Tue, 12 Jan 2016 14:51:23 -0500 (EST)
In-Reply-To: <1452599378-47882-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 12 Jan 2016 11:49:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DBD68742-B965-11E5-AD7B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283839>

Thanks.  It must have been quite an effort to proofread these
without getting asleep.

I didn't spot anything wrong in the last 22 patches, but now I am
getting sleepy ;-)
