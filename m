From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2.5 1/8] t4051: rewrite, add more tests
Date: Tue, 31 May 2016 14:23:19 -0700
Message-ID: <xmqqeg8h53co.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
	<xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com>
	<5740AC28.6010202@web.de> <5749AF59.2070704@web.de>
	<5749B1EA.10707@web.de> <xmqqinxwpgfn.fsf@gitster.mtv.corp.google.com>
	<574DED66.6050008@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue May 31 23:23:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7r8L-0001MY-6F
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 23:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630AbcEaVXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 17:23:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756629AbcEaVXW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 17:23:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CC571E3CB;
	Tue, 31 May 2016 17:23:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=yTcyl0
	0k4kjq3z/mTD95urZqlr3J3bgSKPTExwKKMqatRckO2D2S7KortrDV3NcqqxIJ2G
	1ZTDbYam0oafYOb8bXQuesPxp7uNX8OxMwH9Hic+1NNfdIzgSHBjm436EwigQFlP
	xaN1TqYY1WqlkaReyCrYLmYhj+D0NF8/5bT+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=El8nvuckOS4wg7j040MAqL7c5Wem4xYx
	z4fIL29M6rdR4gwM02gyMQaR3eu5ys1eCDzWl8H1NtuZuqic8kmaU+tiH9U3VkX8
	UAlEtOVVD0CMAyWYKjex0p1YDwqr7+axsAZnsZ50q1lRBfpDzV8tceKLZFC9dN1G
	XfiO3tJtezY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 65B511E3CA;
	Tue, 31 May 2016 17:23:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E3DEE1E3C9;
	Tue, 31 May 2016 17:23:20 -0400 (EDT)
In-Reply-To: <574DED66.6050008@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Tue, 31
	May 2016 22:00:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E646EA4A-2775-11E6-BC19-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296015>

Thanks.
