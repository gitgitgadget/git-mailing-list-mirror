From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/9] Add --graft option to git replace
Date: Mon, 21 Jul 2014 13:09:59 -0700
Message-ID: <xmqqfvhuiico.fsf@gitster.dls.corp.google.com>
References: <20140719145951.9564.61331.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 22:10:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Jud-0007Gp-Ch
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 22:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbaGUUKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 16:10:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61796 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284AbaGUUKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 16:10:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E3402B6B3;
	Mon, 21 Jul 2014 16:10:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N+57S4WSyjIEeGNwFjhBlI64SjU=; b=F6ud76
	oA6UQodUcYXRRvq4xKaRNM9EzEjHma3gUUzGnudTncQtScYvoDEv7uUwu7fHdZOv
	GpngpmTHCt9UiVNODU+e8aHzBy/4xo2gIUjnRPTVI6MMQ3xYqRLd1rhff9lSnfLa
	SYoE0sv7ZbDLNbxHiolpwkrE4fU17afdLiW5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fvWnj9gGgEHx6WutHWagTe6l2UlLYRcI
	rpKJYWoU8r1+Jk5c9lCTWGr8iMPPL2FPUhVCf4ywfvCNV5kO9DXlW5bjmvStqzGF
	ko7GEb69iCJBugaWguQo8nl//qIe5xptNzGIIXgPNO4UCiVts8EVPJ3XlPn7FPrl
	FjmuNqXixvo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 624B22B6B1;
	Mon, 21 Jul 2014 16:10:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 46F642B68A;
	Mon, 21 Jul 2014 16:10:02 -0400 (EDT)
In-Reply-To: <20140719145951.9564.61331.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 19 Jul 2014 17:01:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FF9666CC-1112-11E4-A5BB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253993>

Thanks, will replace and let's move it to 'next' this week.
