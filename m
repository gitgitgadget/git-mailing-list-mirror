From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] intersect_paths: respect mode in git's tree-sort
Date: Wed, 20 Aug 2014 13:40:07 -0700
Message-ID: <xmqqfvgquc7s.fsf@gitster.dls.corp.google.com>
References: <20140820021428.GA22266@peff.net> <20140820033539.GA2773@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:40:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKCgC-0006Wf-Qp
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 22:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbaHTUkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 16:40:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60945 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaHTUkU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 16:40:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B393B30D68;
	Wed, 20 Aug 2014 16:40:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4qn3GPbIdhoJTOq29c0VqcZ4EPE=; b=l5zkum
	aL/OOQRRgw/GMpX16d3rlLkVqBQPIswWv1O41LAtEDPzEHmA+rNEeDG7DuMXzmw/
	WVF2u+DI1Rmkp6AJop/nk9cbX5Gy1pizW6wUIKy/YEYBJK3vVe/jQpffmNID4Ahe
	TjYW9oDbdIBZEYt4oFWQ5AD2fHpoJwCk07qoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h6NbehtilSnK89f4VU+Cl4oBERdpbyWa
	Ps4r785CHlmg5hV4WJO1eWlMzPrNBn7EzXC9mxgJmlLe49+pqrs7jr1GZfMoPxLc
	kZ1BmxegDBTEn0KMmFS9c2rZibb16Ydy1ktJrD0z33Ih6dWn0QOfWoa5+DLbsBXz
	+O0eH7rHOQY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 706CC30D64;
	Wed, 20 Aug 2014 16:40:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AA13030D5A;
	Wed, 20 Aug 2014 16:40:09 -0400 (EDT)
In-Reply-To: <20140820033539.GA2773@peff.net> (Jeff King's message of "Tue, 19
	Aug 2014 23:35:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2D4663D4-28AA-11E4-B84F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255585>

Thanks.

Will queue on top of v2.0.0-rc0~146^2 (tests: add checking that
combine-diff emits only correct paths, 2014-02-03) so that we can
merge the fix down to 2.0 maintenance track later.
