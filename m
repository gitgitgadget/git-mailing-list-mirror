From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/11] Untracked cache improvements
Date: Fri, 15 Jan 2016 12:16:20 -0800
Message-ID: <xmqqh9ieha3v.fsf@gitster.mtv.corp.google.com>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:16:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKAnK-0005IN-NC
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 21:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbcAOUQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 15:16:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752082AbcAOUQW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 15:16:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E7DEC39BDB;
	Fri, 15 Jan 2016 15:16:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wyeSLECMGgUxx3qXL3J2maToxr4=; b=bgxc1K
	lkqp8Ky7UzrjxFepxXg2GsfVqyz/DHLJU9ywcdfrwCBeS6NpFvTrhvwZWSOuDUOR
	DCAOU1m3msajNuLP7BSzuL7Clh7pYiMQYbFePCDL6tks+4Bgrkvy8LSxxMjP/Siw
	JhObTDpJ0C2GNxW7OPCrF43kUe6iuUAowXAVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j3c7iWAmqQLXginQVa7OPOzgC4g7xTQC
	k4VGHjvwAX7LesqRq1avUEAtEY0celc80N1nsSQIzcVO+nyXfuUg7Uwq7ubiYYiK
	9ES638uIrpx/VvPu4+FYnOrlzPHJEA9AkwK6YskLYcjJhK8Mma0wrO7U8XzS0jzi
	/IqH5oAnFqM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD10C39BD9;
	Fri, 15 Jan 2016 15:16:21 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5B68C39BD8;
	Fri, 15 Jan 2016 15:16:21 -0500 (EST)
In-Reply-To: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Fri, 15 Jan 2016 07:59:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D7E289B8-BBC4-11E5-B11C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284206>

Christian Couder <christian.couder@gmail.com> writes:

> Here is a new version of a patch series to improve the untracked cache
> feature.

Will replace.  This mostly looks ready for 'next' modulo minor nits
I sent separately.

Thanks.
