From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: avoid linking to the C library's isalpha()
Date: Mon, 25 Jan 2016 14:04:32 -0800
Message-ID: <xmqq60yhfh8v.fsf@gitster.mtv.corp.google.com>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
	<cover.1452585382.git.johannes.schindelin@gmx.de>
	<05cb9e00756e8a364f972cd227804764f6a6380c.1452585382.git.johannes.schindelin@gmx.de>
	<56A279DA.8080809@kdbg.org>
	<xmqq60ylv3bk.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601230924090.2964@virtualbox>
	<56A3CE34.20808@kdbg.org>
	<alpine.DEB.2.20.1601241152060.2964@virtualbox>
	<56A4C534.6040503@kdbg.org>
	<xmqqzivubpac.fsf@gitster.mtv.corp.google.com>
	<56A6980C.6040701@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jan 25 23:04:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNpFW-0002Wo-9f
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 23:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbcAYWEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 17:04:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754830AbcAYWEe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 17:04:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B34040B72;
	Mon, 25 Jan 2016 17:04:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=OIZLs+
	2t18xtsxqClPpTWBAOCqHDbkflXCD2r6/HEnTkBRAXfvzib6iDurTDNmRoCtdK+0
	c5h+kZgNDc2Q6AHIy+z4XOkE3n0IEbXj/iIdCfyPwiDr198p6cCroG96lwaZPsxn
	VJJX3P6PQ0wDxIEqk/5iHAaGvtorc77/jWluE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mwtfVmjNJ5cZCRnGTA3jjFu5rZtjISRd
	faATKrC1PgpbyVYLrUs3weeuvRJPqwqEdhQkhSu0BtNLPp5Rem+5fIlopUuE3P+g
	RmI3YZRwLrDJoC4zcRDGQscfVCZt2S+abWrKoJ+Ns8Pj8qX3vRKmT0StVYqmpx77
	PV7j/yumRQ0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 11B4C40B71;
	Mon, 25 Jan 2016 17:04:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 77D8740B6C;
	Mon, 25 Jan 2016 17:04:33 -0500 (EST)
In-Reply-To: <56A6980C.6040701@kdbg.org> (Johannes Sixt's message of "Mon, 25
	Jan 2016 22:47:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9D9424D6-C3AF-11E5-9AAA-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284762>

Thanks.
