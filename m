From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: don't hardcode HEAD in dist target
Date: Mon, 02 Jun 2014 13:27:14 -0700
Message-ID: <xmqqd2er3vml.fsf@gitster.dls.corp.google.com>
References: <20140531202507.GA9101@spirit>
	<xmqq4n035ej3.fsf@gitster.dls.corp.google.com>
	<20140602193419.GA10198@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 22:27:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrYpJ-00053K-1J
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 22:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbaFBU1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 16:27:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50546 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbaFBU1U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 16:27:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C93401DFD8;
	Mon,  2 Jun 2014 16:27:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=as0mCLj/qhOF0w0iBDY+gQEtym4=; b=yakcm9
	xf6YR96NWs9CxMp8CWe9ctk1F6qmIlWhkHbTdfgTevNZRhCXp6PNJZdslUzYVmYJ
	vqc0D70ZsMoINDfCeR41kCwomiFyiM2A54oX5/WZk/Xl0CoTpTp+uePXwzwtCE4x
	k1syg8jWYd0UIf9KJGcZ6x64uevNUPgrMMf68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GovgQ2ejAAP1la/HXpRs0Ss5Xr+/fSG1
	z9lU+rlLNpv1eZds/PJBK/xc6P3YgsIiTnwS++4csH9Z5K92GInFnlYzx5M6UjS2
	Mj8MxtIE0H+GzDjVCs0AMYRVZnCiYBqWcEh2XC12PRkvLnlOQ7oA6sFg07mzhe6w
	SLGNb/BvTVg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BD3DC1DFD7;
	Mon,  2 Jun 2014 16:27:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 094131DFD6;
	Mon,  2 Jun 2014 16:27:15 -0400 (EDT)
In-Reply-To: <20140602193419.GA10198@spirit> (Dennis Kaarsemaker's message of
	"Mon, 2 Jun 2014 21:34:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4980EB0E-EA94-11E3-B0BF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250593>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> I'd say it would make the consistency better, because now both look at
> what is checked out instead of at HEAD.

The version with your patch does not even look at HEAD; it looks at
whatever GIT_VERSION points at, which could be a very different
version that does not have anything to do with what is checked out
Can't GIT_VERSION come from ./version file, for example?
