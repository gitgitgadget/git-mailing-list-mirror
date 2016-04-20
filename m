From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] replace --edit: respect core.editor
Date: Wed, 20 Apr 2016 08:26:58 -0700
Message-ID: <xmqq7ffsxpvh.fsf@gitster.mtv.corp.google.com>
References: <909769abaff1babdab77625bebd04e2013c6e344.1461076425.git.johannes.schindelin@gmx.de>
	<xmqqoa9536wi.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1604200832430.2826@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 20 17:27:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asu24-0001JR-IL
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 17:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbcDTP1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 11:27:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751694AbcDTP1B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 11:27:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D34313EA4;
	Wed, 20 Apr 2016 11:27:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zd6rElkdEQm3BLInpCYOu8MOYYc=; b=KKnHpG
	S6M/YTKO/A+9WXOYPopnEL04e/BLwg3XQ2MOSICJmWbnXyxXyHoFJLuqvgNrstE/
	/brrrJCm9INiYVpZeqOgLQxOR8V3yUXWxNjK2pIimpodFJd9ARKKd0nF7yesjIIC
	XkBKvlvSdFGXgfIqlQnwqG9G5KOaHxwbsP7wg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MfP68wDJxa21+YEu2Ra6KeX+jLChSRf3
	X7cRhPbRxup8+dncYMsfYK6Om+ohnI5ZMgldqTPhjV58cJ7wAleS85aec+najsIf
	mcyiRLjQuEreuSjktsPoRs2CqiFoV04V6GV1jHree6T4AS5kZCaUJ9LZJ5HHIWHh
	DVy2iGeWuAY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 127A413EA2;
	Wed, 20 Apr 2016 11:27:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E7C013EA0;
	Wed, 20 Apr 2016 11:26:59 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1604200832430.2826@virtualbox> (Johannes
	Schindelin's message of "Wed, 20 Apr 2016 08:33:10 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 53064FC0-070C-11E6-8FD4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292026>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 19 Apr 2016, Junio C Hamano wrote:
>
>> "git blame -L475,6 builtin/replace.c" points at b892bb45 (replace: add
>> --edit option, 2014-04-26) and the commit log message names two people
>> who can review this change, so that is what I am doing here.
>
> D'oh. Sorry.
> Dscho

Heh, no need to be sorry, that is what maintainers do.  If anything,
both of us need to thank them for commenting ;-)
