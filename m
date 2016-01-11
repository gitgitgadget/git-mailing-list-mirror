From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] Refactor skipping DOS drive prefixes
Date: Mon, 11 Jan 2016 07:58:05 -0800
Message-ID: <xmqqegdoyupe.fsf@gitster.mtv.corp.google.com>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
	<cover.1452270051.git.johannes.schindelin@gmx.de>
	<c70ed05f275a44fbfae831b4cb67e59a0ce05724.1452270051.git.johannes.schindelin@gmx.de>
	<CAPig+cRRaMbEGibYnQBTfGFQT6fybNU8e6ZAkX11V-TLAo9AfA@mail.gmail.com>
	<xmqq8u3z20aj.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601111029540.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 11 16:58:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIerL-0003vJ-88
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 16:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933711AbcAKP6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 10:58:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932474AbcAKP6J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 10:58:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7CF67375E6;
	Mon, 11 Jan 2016 10:58:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MTyhEO7sB2eGO10BhfmtswCvhrs=; b=jPO0d6
	lYAm6BSh+Ckvl2AAQD/7rtgEnBYSXHjtQPqEEQmTpj7FVfXQ4m/iOToCU6lWaeIj
	uOdycpulAKnr2+4haL83+JQ8/WfSiV3UtZ1lIhkx/0x4kAipOafl91VUYhRxm940
	JdjZkctCa6ajWxkU3/BIECY6os2Co2acs+0zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jWwYWhMsH93ObQ50JFlivPbWRQS/nv5V
	VsElhr7mA6f2Gg2676UtZbUXCR9c0HRT8uypAF6rIU3KUqQxGxjR65pmIF+1OIOp
	IrJxq6Ka517wwUyUgCSVvsnPPzQKKwtAqoBHA/458LW7cgiSt8cXM0TjX7SGKIDh
	h3VoLtxZ9ms=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 750F2375E5;
	Mon, 11 Jan 2016 10:58:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D9680375E4;
	Mon, 11 Jan 2016 10:58:06 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601111029540.2964@virtualbox> (Johannes
	Schindelin's message of "Mon, 11 Jan 2016 10:32:36 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1AC1BBB0-B87C-11E5-BEE8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283662>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In any case, I think this change (if it is really considered desirable)
> could easily be an add-on patch by people who care about this ;-)

Yup, in case if it was unclear, that is what I meant.
