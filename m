From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/4] githooks.txt improvements + core.hooksDirectory
Date: Wed, 04 May 2016 16:26:48 -0700
Message-ID: <xmqqk2j9cslj.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8k5eakb.fsf@gitster.mtv.corp.google.com>
	<1462402692-24712-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 01:26:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay6Bz-0008Jh-Hz
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 01:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638AbcEDX0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 19:26:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753402AbcEDX0v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 19:26:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DD6218181;
	Wed,  4 May 2016 19:26:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F+Nmejr7Qju3EYVuUjdKh9zo01Q=; b=WrSbir
	oXlAxkuUkCC0950cqxRSG+yWLtV/tCSlEOzumjA34lOG5DpwmUB1/yYJgsLqG17U
	0v+2QYPDhrSLPa/Ptut4PjQyrMy/Zlt6V+w0vJOE/TMfzkF1t1w6VDVfsKzexBKw
	dI3tgkJmnYC+6HZg5g0/yFk5wGAUEQF/V85i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RoFrXe9hHs0ijbFERGS/S8VOE92IMfUQ
	q6Fd+jXi4mfJy5M04WBPYn3wctt4EO5xIWL5+d4lLdH8iET/m1BgOr5y5NFJ+4yV
	tFdCv6kP5DXr08u+bWmHuRYg80pb2jHTgbhiHKks58xQqa3kwtD5MMT5nhv3IsKX
	hxtoUOk0GHA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 357ED18180;
	Wed,  4 May 2016 19:26:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB1701817F;
	Wed,  4 May 2016 19:26:49 -0400 (EDT)
In-Reply-To: <1462402692-24712-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 4 May
 2016 22:58:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD181FC2-124F-11E6-8AD6-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293624>

Thanks, will replace.  Let's start moving this to 'next'.
