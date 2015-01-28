From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correction to git-p4 "exclude" change
Date: Wed, 28 Jan 2015 12:49:54 -0800
Message-ID: <xmqqwq46fx59.fsf@gitster.dls.corp.google.com>
References: <1422425284-5282-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 22:24:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGa68-0008Jj-B1
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 22:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997AbbA1VYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 16:24:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59233 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932308AbbA1Ut5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:49:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31B7933F47;
	Wed, 28 Jan 2015 15:49:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EnBplBzm8Ep37gzqZYHxHXC3azU=; b=FX5FIb
	Bx05Feck1VqLU7hx4PtNMviAM5LF8NA6X1XHMr3ugovjPyHufqtisSRhtILjhUDC
	N7Of9kazHv0L5AuIxM7brenKqpSjSnjOkWZHtXdF6Zgnkr4KLnbASHkkJLxfffFE
	twFx6cl/BzPwzgotslErnrC8+GL5L/0iqZFhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a//q1/xAp/Owv2XsFPwfJ+MNZdjgw14g
	GniLF/AOeXtPmRTQ6hq+Uu0BCC71dbHuQqQPSJOu0ZX5jchxLn1r9TjiEr8QNE7+
	zAUma7CNchi+EJ78OWjVK1gBvEMp2RwxlDc/waRzOD5aJLbGr6fFUgAIHqk/Rf0S
	J2RzZTBPTks=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27BC333F45;
	Wed, 28 Jan 2015 15:49:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CBC233F43;
	Wed, 28 Jan 2015 15:49:55 -0500 (EST)
In-Reply-To: <1422425284-5282-1-git-send-email-luke@diamand.org> (Luke
	Diamand's message of "Wed, 28 Jan 2015 06:08:03 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 36FDEEF2-A72F-11E4-AE76-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263118>

Luke Diamand <luke@diamand.org> writes:

> My previous change for adding support for "exclude" to git-p4 "sync"
> was incorrect, missing out a comma, which stopped git-p4 from working.
> This change fixes that.
>
> I've also noticed that t9814-git-p4-rename.sh has stopped working; I'm
> going to follow up with a fix for that once I've worked out what's
> wrong with it. There's a small shell syntax problem (missing "esac")
> but after fixing that it still fails, so I'm not sure what's happening
> yet. It was discussed a while back.
>
> Luke Diamand (1):
>   git-p4: correct "exclude" change
>
>  git-p4.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.

Will keep out of 'master' for now.  It may not be a bad idea to
squash this fix (and any futher ones if needed) into a single patch
when we rewind 'next' after 2.3 final is tagged.
