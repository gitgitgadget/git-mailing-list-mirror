From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit, status: #comment diff output in verbose mode
Date: Thu, 10 Mar 2011 16:45:14 -0800
Message-ID: <7vvczq1o4l.fsf@alter.siamese.dyndns.org>
References: <1299787140-21472-1-git-send-email-icomfort@stanford.edu>
 <20110310225233.GH15828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ian Ward Comfort <icomfort@stanford.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 01:45:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxqTy-0007mh-65
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 01:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab1CKApZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 19:45:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029Ab1CKApY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 19:45:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34D8D3DDA;
	Thu, 10 Mar 2011 19:46:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4pyk8EY2VkUnb+xJlT+8XSCzpFM=; b=AoGnoB
	RsydHYPgTMrJvT+vfYHHgulALszL2d4GiR43ejlkLwqKHLlD+X6DXbTxxAH7VYgu
	ocjw0HiA4QCWzykpiv0swqOJbfM+/6mbLQpWidpb8tp2RoAfSLVTYToUl5m1XS1X
	2hzQ9k+FD6ZKsZB16BKPq90PdMb9x37lWEaDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VXWmQ6ncJzhiJTZMpFgrSFVgY3kgzvjB
	NcaaqkYikRBEK6ClXY9/y7VAJ8dflABH4fZT1Fxuw62pnL32MpP2XN8ryO1B/V2w
	YnNcK7mUpYHEFEV8osy49pErmwUSGRdElCBIgZQO/xlE708BHp8ToULWc023oVLe
	g58d3XlA97k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 029883DD9;
	Thu, 10 Mar 2011 19:46:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E25B53DD8; Thu, 10 Mar 2011
 19:46:45 -0500 (EST)
In-Reply-To: <20110310225233.GH15828@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 Mar 2011 17:52:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CD12AA6-4B79-11E0-9724-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168872>

Jeff King <peff@peff.net> writes:

> One reason to keep the existing behavior is that editors will tend to
> syntax-highlight the diff portion without much extra effort (in vim, at
> least, the syntax highlighting just includes the diff syntax
> highlighting for that section).

Hmm, thanks for pointing it out; it indeed is a valid concern.

Although I usually strongly resist changes in order to keep the user
experience stable, I didn't think about this one, as I don't let the
editor syntax highlight anything.
