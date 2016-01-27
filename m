From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/2] Let merge-file write out conflict markers with correct EOLs
Date: Wed, 27 Jan 2016 12:22:07 -0800
Message-ID: <xmqq4mdy93io.fsf@gitster.mtv.corp.google.com>
References: <cover.1453819314.git.johannes.schindelin@gmx.de>
	<cover.1453912583.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 27 21:23:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOWcg-0003wE-Ic
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 21:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967548AbcA0UWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 15:22:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934609AbcA0UWK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 15:22:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 666323DFDD;
	Wed, 27 Jan 2016 15:22:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Vv7C4bEDjrkYlg8XMqr0uyb3/0=; b=Navv5q
	2cbbxvsQFuCWKaHiYenq1q06Gm4SQtt8VMKi7grHoEnJwbF1ZUSWs184hWRrr0ju
	veCv3gtOcpa/q0JdyGCJkRzCFZvGjg34dsz2HSTbUHemdhkLk0xfassL9VbJwXve
	XwUejcCpEThf7YRlsvh/Sl22sZY2bk5Rtri0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r3i5KQI2jcYY0abDz1956vXZbDa96jvN
	NcEjAzjTB0lQyww+HhhCTwZeG8fnaFmw4yOYzwvd3yxscYK79eImntOHtkrsAPrJ
	DnX1EWPRsyRP5QZdpDqEdRim7uBr33bK3YCHUDw8gDmrJiXU+DVopICGPxg5g+S9
	btSE2pCGB00=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5EBC13DFDB;
	Wed, 27 Jan 2016 15:22:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CD35A3DFD7;
	Wed, 27 Jan 2016 15:22:08 -0500 (EST)
In-Reply-To: <cover.1453912583.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Wed, 27 Jan 2016 17:37:25 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A3F2ACB4-C533-11E5-B865-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, will queue after looking at the interdiff since v4.
