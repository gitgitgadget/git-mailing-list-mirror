From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V3 2/5] Help.c use OPT_BOOL and refactor logic
Date: Tue, 02 Apr 2013 18:13:14 -0700
Message-ID: <7vhajo76xh.fsf@alter.siamese.dyndns.org>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org>
 <1364942392-576-3-git-send-email-philipoakley@iee.org>
 <7v62048qxm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>, "W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 03:13:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNCGr-0000Ub-E3
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 03:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759699Ab3DCBNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 21:13:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758910Ab3DCBNR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 21:13:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A5BA101EC;
	Wed,  3 Apr 2013 01:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lbzYFNxqX0s+vQ5qe2Tw/SB2Rzw=; b=nBd7mS
	xxPetEfY7H5cP0HiVy3Pfvf21Nn9J5X2DlWsQhLo2+yrVR64jpuCcbKR95Gr2Uri
	vyLBvicXV7e3Z6BnkocJ2urOixXQybITOik1jhM/PQI7N+RqN/dmirDpI2SC0QB6
	RIfxMbPeY7WCUZBdppRJNPecggirEiBFILwt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T0gy6VuVK+9p4u4aWLFzLrkMrQvPTAZc
	Ku8G2xOuQgRZ01lpVEEju1/tdtuBmWiE8WCqOev1oCHwQj21lmbSslMkr81rKZNL
	mi8r2yODOgCRwv6zm5BIXbIO8NaleTUOmOAvy6XNYuBZGwuRDjLcA/gYKqNiollQ
	JfO37uPc788=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20368101EB;
	Wed,  3 Apr 2013 01:13:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48A5E101EA; Wed,  3 Apr
 2013 01:13:16 +0000 (UTC)
In-Reply-To: <7v62048qxm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 02 Apr 2013 16:15:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9D6F770-9BFB-11E2-9787-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219908>

Junio C Hamano <gitster@pobox.com> writes:

> You are creating a gap in the output so that you can add some more
> stuff in later patches, which is fine, but I do not think we call
> that kind of change a "refactor" ;-).
>
> The change looks fine.

I'll queue what I suggested on 'pu' for now.

Thanks.
