From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t/t9802: explicitly name the upstream branch to use as a base
Date: Tue, 18 Jun 2013 09:17:24 -0700
Message-ID: <7vehbz75rf.fsf@alter.siamese.dyndns.org>
References: <1371519650-17869-1-git-send-email-bcasey@nvidia.com>
	<1371519650-17869-2-git-send-email-bcasey@nvidia.com>
	<20130618134207.GA28716@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <bcasey@nvidia.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:17:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoyb7-0004Fg-Ua
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933062Ab3FRQR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:17:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933052Ab3FRQR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:17:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44CE228899;
	Tue, 18 Jun 2013 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3JYtktDcnByaFvfRDiW61esyO2s=; b=JtvnSy
	e1bKzUFPUHwN82Sr67BloTyI+2Sl2qdU30kJOaVTj9b03zC9EfxuGCq224RvwIwK
	heOJU/WL4MANRaepmMZ1Kq7tJQP5e+wE8gCd6D+iP95jcEPMP02/mYf1zCpeHGB6
	u3+ehNpwhWYoo3MpN0QkJ65bBXpUkXv8xj0Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QqHFIeY7hQvQYa9izbFmhEqhpT4cTbmL
	/cBSTdh4jh4mdOkzi8Gh6+ZAThtCPb3z+qzVq7Qp89HW9a6i/2o3+IryHxhLrJow
	RWglUh6aq8KXLPQfan2pHArZiktF9wNQqSir3DIjzvBIUldXhx6PQpI7yVuMRbII
	x5zghBeVA9Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C50028898;
	Tue, 18 Jun 2013 16:17:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B825728896;
	Tue, 18 Jun 2013 16:17:25 +0000 (UTC)
In-Reply-To: <20130618134207.GA28716@padd.com> (Pete Wyckoff's message of
	"Tue, 18 Jun 2013 09:42:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 906DFD56-D832-11E2-AEDB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228261>

Pete Wyckoff <pw@padd.com> writes:

> Thanks for finding and fixing this.  Great explanation.  I
> tested it locally too.
>
> Acked-by: Pete Wyckoff <pw@padd.com>

Thanks, both.  Queued.
