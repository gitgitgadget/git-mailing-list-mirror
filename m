From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 04/21] notes.c: Reorder functions in preparation for
 next commit
Date: Wed, 13 Oct 2010 14:59:57 -0700
Message-ID: <7vy6a1hhya.fsf@alter.siamese.dyndns.org>
References: <1286586528-3473-1-git-send-email-johan@herland.net>
 <1286586528-3473-5-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:00:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P69N1-00016s-9v
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab0JMWAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 18:00:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0JMWAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 18:00:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE805DEB18;
	Wed, 13 Oct 2010 18:00:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=2h6UfRyWSkzChbNwBmTbOMfuYK4=; b=gxsQsGnC7aKX7YDDkDlU121
	GuhHrM2OT1vwOW4jVkgkij1oh+uE1PhkWIbjUKQ1tYzRkgdJIQVPFt83Ghj0sRUx
	2KIPTGhR0JDenuVA99mqETtTwzXbNGmiT8N7YzmaXyaNbPSaUBpDrrWVnI8JSCMO
	T7HAtqX3mRspfefyLX08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=A/zDe8zdi9S3wOvJQzptu0O0bWTmLOK2KMg+RGMHWRH4qDgg+
	CXckcJEOQ6AO3yRzq8KPFhdgDk9xCCXKUBwodPZVudaa/2GXLurxroXZHWLeLpt/
	Jz/z/4YXC885Dnc20I9qASwOnM3xQgnZylwAn5OuchSSslTI6jFwm9DlVw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E892DEB0C;
	Wed, 13 Oct 2010 18:00:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12D11DEAF6; Wed, 13 Oct
 2010 17:59:58 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3C6DAE16-D715-11DF-961D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158991>

Hmm, why doesn't this patch apply?  What is this series based on?
