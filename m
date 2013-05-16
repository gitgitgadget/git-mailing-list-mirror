From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "remote-hg: update bookmarks when pulling"
Date: Thu, 16 May 2013 15:55:04 -0700
Message-ID: <7v1u964jsn.fsf@alter.siamese.dyndns.org>
References: <1368708195-1044-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 00:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud758-0005P5-2J
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 00:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186Ab3EPWzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 18:55:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57696 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492Ab3EPWzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 18:55:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBB7F1F18D;
	Thu, 16 May 2013 22:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J+RyJQaVcDnOklhBTb9Kwl6xTvM=; b=CYttRe
	Umh5H1iqHIZKd4ofI57433EfM6XI57XwPJ24BZ7A8toLZXVLpDuG6ZiZfSd4JiGM
	PM8WlHOe04jsWomlYJvfF7EEL9TW3kWJ31sEbBovcYagxtVYfNoP8AtURAWdIcvD
	xpo1pDxL6+gGvN/UC8phVSuWJuMhvPzQuOVRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fg3BBHDtVmrd1wBJjiJ1Y6OXUQyoTYA9
	qondOjnC8JfwAeG37lL66NuUKxudmPmTd1QEVaoFldS504Ics/V0A3g0JxWNmgZy
	0iOPrfmH4M/fHCSgjH8Hh0Jif0jiO/+w/oBdQgSHlesQjxuPth1RrBpVX9j3uT4P
	4HAKBUyZM6k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E04741F18C;
	Thu, 16 May 2013 22:55:06 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 670461F18A;
	Thu, 16 May 2013 22:55:06 +0000 (UTC)
In-Reply-To: <1368708195-1044-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 07:43:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6DD4EAA-BE7B-11E2-BFD4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224625>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This reverts commit 24317ef32ac3111ed00792f9b2921dc19dd28fe2.
>
> Different versions of Mercurial have different arguments for
> bookmarks.updatefromremote(), while it should be possible to call the
> right function with the right arguments depending on the version, it's
> safer to restore the old behavior for now.
>
> Reported by Rodney Lorrimar.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> Intended for master (v1.8.3).

OK, will revert before I start today's final integration run.

Thanks.
