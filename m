From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report about symlinks
Date: Mon, 04 Aug 2014 09:36:05 -0700
Message-ID: <xmqq7g2otdoq.fsf@gitster.dls.corp.google.com>
References: <web-416867478@relay1.vsu.ru> <53DABD69.7010004@web.de>
	<xmqqppgkw55g.fsf@gitster.dls.corp.google.com>
	<53DCF14D.8040705@web.de>
	<xmqqk36ptrs6.fsf@gitster.dls.corp.google.com>
	<CACsJy8AKa2NBJT6+w87JqDM9eL5nw=3OjMCj-kq=yoyE6Oi_Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Nikolay Avdeev <avdeev@math.vsu.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 18:36:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XELFI-0001BS-Cs
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 18:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbaHDQgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 12:36:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52074 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbaHDQgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 12:36:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E10682D365;
	Mon,  4 Aug 2014 12:36:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F/D+l8riGQMlbltU82RB+1NruY8=; b=RJCVMC
	Xw2+uXCwAkCctLuRVTYiDxm4/tu4w16iH8KI8fbcaRXpvrRUUYDasUDrwLWparun
	llTxStknFUyTHy5H3xN1dR+KI14CUZUJ8wkHl+1VJwimfYH/7NzArQsnOSgs+DZE
	Ia/5LgLrOlP3RY2W49jx2k1L0QS+1/uCzns4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=alisq2Az2TgBVfdBAlLrEesQI7nDJpHW
	iJZ2HEUQizwo0BzRblxDcfTo96nTZOIdOUce/R4HOdL264eNK2h1Bwmpt1R07xhs
	R1rigEBxQcr316IftnGMe4OtQoKVYuRTIebawwIWAEhbS+taqUdgoGEQ2h1peJ+V
	BDWPPUDQw5k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5FD52D364;
	Mon,  4 Aug 2014 12:36:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3C74D2D350;
	Mon,  4 Aug 2014 12:36:07 -0400 (EDT)
In-Reply-To: <CACsJy8AKa2NBJT6+w87JqDM9eL5nw=3OjMCj-kq=yoyE6Oi_Ew@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 4 Aug 2014 18:03:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6F1617B2-1BF5-11E4-9E7E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254744>

Duy Nguyen <pclouds@gmail.com> writes:

> Just checking, you meant CE_UPTODATE, not CE_VALID, right? CE_VALID is
> only used with --assume-unchanged

Yup.  Thanks.
