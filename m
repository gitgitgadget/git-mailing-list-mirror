From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Fix '&&' chaining in tests
Date: Thu, 08 Dec 2011 11:55:03 -0800
Message-ID: <7vzkf2hm94.fsf@alter.siamese.dyndns.org>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 20:55:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYk3l-0002nZ-9X
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 20:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225Ab1LHTzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 14:55:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab1LHTzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 14:55:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18349672D;
	Thu,  8 Dec 2011 14:55:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z6mQWXo3tTVDQOyeugB1fRL6Xic=; b=vxsbde
	soRF+pTyJkdYvdT9G2L/nOMMUQ1xJU9fM8EUO4GsC1oZT6bUf38evlPlvKfa+FWJ
	OHHYGMC0GbOgVUnEX1g7wa/3cflDGm9q8z2doMDIVmyuzerNvfXLS45Ycqh88BDl
	NVMnaun9VJ06nz2a11E9spJD2Ll/gfsDo4ei4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nliFuQDCQhW0vhso39kVBT/W+nTnj1gK
	Qa94dWPHJYgWpisOsI0/lXDiPqLm3DMb5bVUDcOD+25rTyuo8TYOt8EQ/4RPoQzU
	KiY1UBKlUdn1RXkvjGRmybWkFTdRL58y9Y59N4VRQPZanOvsd55TnEYe0BLUiQOd
	rntZzVZpDjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EA9C672C;
	Thu,  8 Dec 2011 14:55:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97668672A; Thu,  8 Dec 2011
 14:55:04 -0500 (EST)
In-Reply-To: <1323349817-15737-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 8 Dec 2011 18:40:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 859EB58C-21D6-11E1-BD70-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186591>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> This follows-up $gmane/186481.

I take that you meant "replaces".  It was confusing especially because you
seem to have included a few unrelated patches in the thread.
