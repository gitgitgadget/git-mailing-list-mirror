From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] ls-remote: introduce symref argument
Date: Tue, 19 Jan 2016 10:14:30 -0800
Message-ID: <xmqqegddbfnd.fsf@gitster.mtv.corp.google.com>
References: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
	<1453159250-21298-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, bturner@atlassian.com,
	pedrorijo91@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 19:14:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLane-00052J-51
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 19:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbcASSOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 13:14:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932371AbcASSOd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 13:14:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 721F33BEC7;
	Tue, 19 Jan 2016 13:14:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tO97MqT7VS3vaOSOpQpFzBbMqe8=; b=jK5zbu
	UH/v+W1hVOEWEx00o6WhzDZ9ci+51jcKm8dx/qMt+4joO+uG82T/GQJy4O86whvG
	oJBmYVtgV0NYITMyaWE1g6z6N+S+15cKyDfgqtQ3hbUkGwrVAfFOpi7xB3Urhw+I
	9t65nEyApSWQsAN+L89KhQzJJ7u7hmI1+zxOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xupCbYxTsD5ESE4Et3NAGj713q+Xbol5
	dZWr0PPLerBSkGuqmGC9rMWhwULlTiE8IprL6W9TzgjaVmkK6TrjJF+irMMOBtOp
	2SrlguZbXMHLmx2BlEPXbnuBDvyIuE5lIMHiY+sdy4lL8wm+r5Gm2Nz2C9FbfyZ7
	nYhEEYwUs00=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 69D133BEC6;
	Tue, 19 Jan 2016 13:14:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 97BE63BEC0;
	Tue, 19 Jan 2016 13:14:31 -0500 (EST)
In-Reply-To: <1453159250-21298-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Tue, 19 Jan 2016 00:20:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7C95D274-BED8-11E5-B14C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284366>

Looks good to me; will queue.

Thanks.
