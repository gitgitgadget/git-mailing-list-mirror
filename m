From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] new git check-ignore sub-command
Date: Thu, 20 Sep 2012 14:26:01 -0700
Message-ID: <7v4nms9yja.fsf@alter.siamese.dyndns.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:26:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEoGG-0008PJ-0D
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 23:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725Ab2ITV0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 17:26:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983Ab2ITV0E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 17:26:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA4E1898B;
	Thu, 20 Sep 2012 17:26:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=17zV9LCOAwDKXr97zNjYQqa+Dp4=; b=Hx/zSK
	3nj6ChEpdR4SqwizqBFeHXA5g6uHH9kh0WIT4MV+AhCNk3f6FcM2V2jUSDreQKhx
	rFnev8sm4QCfkTUVQJDTkhqJAUD1w/wzm1SyNob0jNb4/8/Tiwp5DLJdMyzbz8PL
	W0S8kaXwy/bl7Wm32QI6n+9Qgf8GZ9cSWyMXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ocje/HuyK/evYI+eMy//veMBFNEa1hOP
	mplBRqrL09IjbJxWlu4J17T8ur8uqKsxrGxe5In+Tl/CH4Z8/YeDaXMTqunZXJus
	y1ZAcMT7prRZK7U2IxuNv4vIcSUfhv33v4IOdszkA/67HVWDTsmzqmjiWVQd8kz+
	UHyOCQxdnwY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE91E898A;
	Thu, 20 Sep 2012 17:26:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D17B8987; Thu, 20 Sep 2012
 17:26:02 -0400 (EDT)
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 20 Sep 2012 20:46:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7A74992-0369-11E2-940E-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206095>

Adam Spiers <git@adamspiers.org> writes:

> Adam Spiers (14):
>   Update directory listing API doc to match code
>   Improve documentation and comments regarding directory traversal API
>   Rename cryptic 'which' variable to more consistent name
>   Rename path_excluded() to is_path_excluded()
>   Rename excluded_from_list() to is_excluded_from_list()
>   Rename excluded() to is_excluded()
>   Refactor is_excluded_from_list()
>   Refactor is_excluded()
>   Refactor is_path_excluded()
>   For each exclude pattern, store information about where it came from
>   Refactor treat_gitlinks()
>   Extract some useful pathspec handling code from builtin/add.c into a
>     library
>   Provide free_directory() for reclaiming dir_struct memory
>   Add git-check-ignore sub-command

Please retitle these to have a short "prefix: " that names a
specific area the series intends to touch.  I retitled your other
series to share "test :" as their common prefix.

Thanks.
