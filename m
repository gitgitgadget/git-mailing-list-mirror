From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] diffcore-pickaxe: respect --no-textconv
Date: Fri, 05 Apr 2013 10:31:40 -0700
Message-ID: <7v4nfkdgub.fsf@alter.siamese.dyndns.org>
References: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
 <7d36738417942b594c185953115a244ad6f3c7a0.1365105971.git.simon@ruderich.org>
 <vpq7gkhqvbu.fsf@grenoble-inp.fr> <20130405131630.GA23017@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:19:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWLw-0002u6-46
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162196Ab3DERbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 13:31:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162176Ab3DERbn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 13:31:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62B40131A0;
	Fri,  5 Apr 2013 17:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OIWiyJ5L9nKuysNIJkDsSIDMWXU=; b=RzVwgl
	Bq5zAcfrZb/t8Jfl2wv6GyHk/Gt5FV6iHRpayZNbCvqJDgHQfwhq5U1C2HooldXU
	3U91aKY3vRh07T1gkf8YpWiaAgT0OPcP+yjBHqyO1RhdWcdjjbSELUi5fw2pv83K
	55p2x1cg/5zVAh+Zw2s7B99zzt5HAvriM6qtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rI82w7NZE3isYxkjaHAZCtBOo0M9AbVm
	jnpOIb6ryGMXfiXnH17fVjgSl1mvX/PbabM6wXPv2sUfhQu8lAJFVyLFfK2yosRI
	zP+zBtq7jAeB9K32w2v7Uw820167m9780xzJH8cPS22nHeqfzr7IAZGBiSvzgPJp
	bz9ODemlNeE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56FB91319E;
	Fri,  5 Apr 2013 17:31:42 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC2781319B; Fri,  5 Apr
 2013 17:31:41 +0000 (UTC)
In-Reply-To: <20130405131630.GA23017@ruderich.org> (Simon Ruderich's message
 of "Fri, 5 Apr 2013 15:16:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ADE6BD6A-9E16-11E2-9850-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220200>

Thanks; will replace the one in 'pu' with this.
