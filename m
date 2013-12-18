From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hashmap.h: Use 'unsigned int' for hash-codes everywhere
Date: Wed, 18 Dec 2013 09:46:33 -0800
Message-ID: <xmqqeh5ajbly.fsf@gitster.dls.corp.google.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
	<52A37D70.3090400@gmail.com>
	<xmqq7gbd29vw.fsf@gitster.dls.corp.google.com>
	<52B1A607.5000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 18:46:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtLCl-0004hY-OU
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 18:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395Ab3LRRqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 12:46:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37715 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754944Ab3LRRqi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 12:46:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BE6459B4D;
	Wed, 18 Dec 2013 12:46:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I3kuyf2ZJ1DljVEtlS7UTHqLhuE=; b=BbAmgP
	wiinwFb7YdWru6VpyBuivpI7F6ODkw267E0xLmFDU7YZSg5HKJYFf8l2ZmLWhLxt
	ErZpVNgUkg0xaiiCceVRD2dWicwd0IGsspKIqeJwwlo+QcXNGFfc6WL+p1//XT1m
	42O9ZIUWcoP4ZP4M7dQ+O7P/fid6Mhaw5y8E8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WBR/YWP5lCx0329/ZU78M8M/hpTlwZyC
	Vz8+uSBF6snfrB2IRYHpoXayK3UNsgBD+y8kYDEWYLrZoAopYJqdbLhTOCkJB4Sa
	rjHxUHhDe8aYpVxYhcVJpN+SZTw+HEN102GD7PUxqGBmzuww0zoqBR7wq9wRc3E7
	qQkDC3O4cW8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5767F59B4C;
	Wed, 18 Dec 2013 12:46:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97BD859B4A;
	Wed, 18 Dec 2013 12:46:37 -0500 (EST)
In-Reply-To: <52B1A607.5000509@gmail.com> (Karsten Blees's message of "Wed, 18
	Dec 2013 14:41:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 57FC2ABE-680C-11E3-BA6C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239461>

Karsten Blees <karsten.blees@gmail.com> writes:

> OK, this one's a no-brainer I think. See $gmane/239430 for the
> latest proposal on the struct packing front.

Thanks.
