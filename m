From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-daemon: needs /root/.config/git/config?
Date: Tue, 04 Jun 2013 12:20:51 -0700
Message-ID: <7vehch7kdo.fsf@alter.siamese.dyndns.org>
References: <20130604141314.GD22308@pomac.netswarm.net>
	<20130604160815.GB15953@sigill.intra.peff.net>
	<51AE3A88.2080203@kdbg.org> <20130604191025.GG28153@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Ian Kumlien <pomac@vapor.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 21:21:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujwmx-0002Ei-EH
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 21:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868Ab3FDTU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 15:20:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64860 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab3FDTUz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 15:20:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7914B25584;
	Tue,  4 Jun 2013 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2uHKqMaI9obZVbPJtlXVd6wNFSY=; b=nVf64w
	dbXsGAO6cYCX6t55LVLqY/7S7+zNzFANw27vFALX6ySY/0ubUjJp0zIEiAX0fbLe
	ZPeiJfx2sMpNiKp8jqMEnjFeQyDj0D4/uvI83i5OoIFHyeqT2YH/2HD4URbdTw5E
	HWs/awOp2sQjfz687Bcft2fKhnIulvN9jXp68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IBv3K3vABmyCDgp3tZ5osLFr4jDzwx6a
	XnOGjaCLUunA/5zHMIn//WvpgSRaJTj607nmZTdNsbz9ZTGFlsolklAmU6ZRggLy
	dIeoH/DG5qomV92za9s2CC4Tgb7/v5aMg9BGjCpC40p8qOSVT+ObyrGoWouQHvKg
	lwxlTrJ0tWc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 370C325583;
	Tue,  4 Jun 2013 19:20:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F51C2557B;
	Tue,  4 Jun 2013 19:20:53 +0000 (UTC)
In-Reply-To: <20130604191025.GG28153@google.com> (Jonathan Nieder's message of
	"Tue, 4 Jun 2013 12:10:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF996506-CD4B-11E2-98D6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226397>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I could be remembering wrong, but I thought it was not so much "under
> consideration" as "accepted for 1.8.4".  I haven't heard any
> compelling reasons not to apply it.
>
> Would it would make sense against earlier releases as well?

True; the patch is queued on a topic that forks from maint-1.8.2
exactly for this reason.
