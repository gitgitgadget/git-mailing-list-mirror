From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: reword --author error message
Date: Fri, 16 Jan 2015 10:35:25 -0800
Message-ID: <xmqqbnly376a.fsf@gitster.dls.corp.google.com>
References: <54B7CCCD.1070708@drmicha.warpmail.net>
	<84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net>
	<xmqq4mrs7x5h.fsf@gitster.dls.corp.google.com>
	<20150116093220.GA3006@peff.net>
	<xmqqwq4m3a8k.fsf@gitster.dls.corp.google.com>
	<C67968DA2DD34039AF6EC8B61AA1CA47@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Jeff King" <peff@peff.net>, <git@vger.kernel.org>,
	"Gunnar Wagner" <gunnar.wagner@irisgermanica.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 19:35:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCBkA-0000YH-Nl
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 19:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628AbbAPSfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 13:35:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751935AbbAPSf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 13:35:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C2914307CE;
	Fri, 16 Jan 2015 13:35:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jMZfSTYQMzzvnolAOyYyyyRLamQ=; b=O7pD8J
	kNXwaYkfWiEBW6xYzwOnzHlgGE73goVNQXvvP4jEZF2x2RFH4O5TlyFtoeFJ4GZt
	fmTM+YhZRMllGcxOIRsnCTw3C5mSK20YZyDO9E5V62WCnluTUuK0Bc2jwalbNFSZ
	OecKvr5ezG2C5tWAf22cnsV4zXtWZzhlv4vwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EebyYM3r6nrzEsLphsr7hkiglMPAAQUt
	+z7K4igXb1Z55DQ6X4Ot6x9pWc9tr4TbxhScn0bil1Kb3HsFAG3py2nyvzr2fxV5
	g8ph3X5e5F429KOHHtZFoe8UEwi6gLFspdMKrhWbiMXCGI9nM4km/rlHi3/LFiNN
	guLQU5sbqp4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5755307CD;
	Fri, 16 Jan 2015 13:35:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B960307CC;
	Fri, 16 Jan 2015 13:35:27 -0500 (EST)
In-Reply-To: <C67968DA2DD34039AF6EC8B61AA1CA47@PhilipOakley> (Philip Oakley's
	message of "Fri, 16 Jan 2015 18:33:00 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 70DC010C-9DAE-11E4-8A87-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262556>

"Philip Oakley" <philipoakley@iee.org> writes:

>     die(_("--author '%s': not 'Name <email>', nor matches any existing
> author"));

Sounds good.  Thanks.
