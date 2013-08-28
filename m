From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar to disable display of #
Date: Wed, 28 Aug 2013 13:10:44 -0700
Message-ID: <xmqqwqn58tkr.fsf@gitster.dls.corp.google.com>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
	<1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq1u5da8dp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 28 22:10:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEm4t-0002Ds-Dk
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 22:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab3H1UKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 16:10:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076Ab3H1UKu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 16:10:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 188D83DA38;
	Wed, 28 Aug 2013 20:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RiBeLidf5udxsWZau2UxcAa0fOo=; b=JSFUdC
	6PAmPvnnAnANtnhDBplH2kD07fyXCDTbUuOURgLWfvF6v5HGlGfKJoJ5j01+ZyOC
	tMrLW+gDbaQRgBkkbzgG/VlNBqgHApEJlJF4R8sS7aBSSATwPiBRZJ+m1eKoVxQj
	cMiS+vlZzbMtbumq95JmUSOEH0fhchFCQun7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f9m5u+/fujlvSfIxOTDo9Txuw5yOU9vg
	BrndEwPFEl8E3+AP+jkOFMZvdic92UypBvmnOFQHhpvYL4uu7wdnxBnohUIit3Ry
	+H4OPOTXX5oO5Jjn5+KohG7n0sz4ZNrD2iH4pRnKRqKWvEwPgHRt5hAKOPM3bT2u
	K2PvlgK2HXc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC09A3DA34;
	Wed, 28 Aug 2013 20:10:49 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 558143DA2D;
	Wed, 28 Aug 2013 20:10:47 +0000 (UTC)
In-Reply-To: <xmqq1u5da8dp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 28 Aug 2013 13:05:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED61CD44-101D-11E3-B7EE-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233207>

Junio C Hamano <gitster@pobox.com> writes:

> "status.omitCommentPrefix" that defaults to false might be a better
> setting, I suspect.

Or status.showCommentPrefix that defaults to true; I didn't mean to
say a setting that defaults to false is preferred over one that
defaults to true in my message.
