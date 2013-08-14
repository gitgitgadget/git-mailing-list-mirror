From: Junio C Hamano <gitster@pobox.com>
Subject: Re: New special handing of '@' character broke my use case
Date: Wed, 14 Aug 2013 11:20:59 -0700
Message-ID: <7v8v04t9pw.fsf@alter.siamese.dyndns.org>
References: <520BC017.7050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 20:21:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9fgz-0007cx-Tg
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 20:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758620Ab3HNSVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 14:21:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758263Ab3HNSVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 14:21:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F5B0371D0;
	Wed, 14 Aug 2013 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SEkU1k3czWqBfXNWHp62MevZGsI=; b=Fajhmp
	hfIq7BHqfYUp+1Wvl5WI0GnxHw7qWvAJlEu1mLgP2RcQFwOawnWNAlWaqJW62CfJ
	ibIdLH3EF5alwBEQ5o3OAKsxUmcXoUNcuXMFmhp1W6DChruPHjcHujKzVXjZL1l8
	OUtf4IhQGdoDAn2zexHO6izObFPWAeAdAOR5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dCx6MHXK8c/6KlVl69cLGMZEJm6TsStj
	sB1ipxu68DrARqA8X0jH66EmYLCcBcpsMVlDXuBv7A3Y39L+BbQhXClkaPGp6xaT
	zud9avTYJ8uHPyRLk7yaYsY6m+zrb+SX7OTOQrti8rj/WpozPgePebzEUQy4btur
	slWjHY2ZoqY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1338F371CF;
	Wed, 14 Aug 2013 18:21:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2908C371CC;
	Wed, 14 Aug 2013 18:21:02 +0000 (UTC)
In-Reply-To: <520BC017.7050907@gmail.com> (Stefano Lattarini's message of
	"Wed, 14 Aug 2013 18:36:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4680C9E0-050E-11E3-B425-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232306>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> ...  But in that case, I'd like some assurance that such a character
> is not going to be turned into a magical character some time in the
> future ;-)

I'd say that any special letter could be considered a fair game by
the next person who would want a funky short-cut.  If you used "S"
or something, e.g. "git branch S/ropic/1" etc., it would be very
unlikely to conflict with any such future changes.
