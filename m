From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Thu, 11 Jul 2013 09:35:29 -0700
Message-ID: <7vhag1rr5a.fsf@alter.siamese.dyndns.org>
References: <20130707100133.GA18717@sigill.intra.peff.net>
	<20130707100949.GC19143@sigill.intra.peff.net>
	<7vtxk645vp.fsf@alter.siamese.dyndns.org>
	<20130710110402.GD9724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 11 18:35:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxJqO-0003nV-GK
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 18:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab3GKQfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 12:35:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34427 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab3GKQfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 12:35:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D2F12F3B8;
	Thu, 11 Jul 2013 16:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EoE83pGcJ2kKB/HMgtM+qqIXTR4=; b=SAiygE
	hPST49xGJSbdRVcicfckqK9bpZLX33wXtJQbWuCDCFBw10/7TbQrymTPYz0akC1n
	ZmCT8tmJFRAzIbqtV07XdwiFWsYfISKxGgvexzfmlQPCK2SHqRfZYixQ7xTrZfEV
	ZvH3HdCXLggqrzu34luAsLewC0QT0PRGRUofg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dDQcm6fIFLJU1YNNA7Zd6EWsbo8mO89a
	OfuIVnbqw174YNHeOYuSCO1PaeNSDxrq7UqeYxJiTjp9petcqgm/sqzgNB1RhEYx
	Ra5Nru/mZ0PfvbINJyYi76iCPcM2wYhFMb+9YxVDUBRE/UnuqLQy+c1d76M7WbOk
	2cEUQTDGq3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE3C82F3B4;
	Thu, 11 Jul 2013 16:35:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DFE42F3A7;
	Thu, 11 Jul 2013 16:35:34 +0000 (UTC)
In-Reply-To: <20130710110402.GD9724@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 10 Jul 2013 07:04:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8BA0668-EA47-11E2-9A7E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230114>

Jeff King <peff@peff.net> writes:

> I started on this, and it turned out not to really be any simpler....
> So I went ahead with the full formats for my re-roll. It turned out
> pretty reasonable, I think.

Thanks.
