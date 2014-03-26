From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 01/12] Add data structures and basic functions for commit trailers
Date: Wed, 26 Mar 2014 16:06:35 -0700
Message-ID: <xmqqwqfgftl0.fsf@gitster.dls.corp.google.com>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
	<20140326221531.11352.50524.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 00:06:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSwuI-00079S-Lj
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 00:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756334AbaCZXGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 19:06:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861AbaCZXGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 19:06:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1FD278FB9;
	Wed, 26 Mar 2014 19:06:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=r/2yg2C0U1jipcDla5fFEw1m3iE=; b=POzg3lHwYUXoDGVjv2Kr
	33kGVoAq2LITpsN9KdQ5lwcPyKz4YDug7W80d5lZeAscxBtMtuad/eKKuFInxTLu
	3dQwx3HthECDhHCrk/PaDa6M3O5tIQV0e15IM1S0yz5NwlTXH4V2VJ5PYyrtAvQV
	mjbcmqCMVnLA4bH13SIUUO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oVBWh41vdo2M1ZJ49l6IwyzfxrwqTMZAHEWAPIlqSAliTL
	ASUIuE5+8fHrkqQfklX4cRxxEszyO66PX3JUvLaJCZLm5ceI6XV3CNlBca4UwjCt
	cq0+RqD8EEmDtC0f+VpE9b9X7Y7uVl+xHFsUcsRZ+jcRnl6WW42sGwL7Ob298=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BABD978FB8;
	Wed, 26 Mar 2014 19:06:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0890278FB5;
	Wed, 26 Mar 2014 19:06:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 48410C8A-B53B-11E3-900F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245254>

Christian Couder <chriscool@tuxfamily.org> writes:

>> Subject: Re: [PATCH v8 01/12] Add data structures and basic functions for commit trailers

As pointed out many times for GSoC microprojects students, limit the
scope with "area:" prefix for the commit title, e.g.

    Subject: trailers: add data structures and basic functions

Please also refer to what has already been queued on 'pu' to avoid
wasting review bandwidth and mark patches that are unchanged as such
(but do send them to the list for review, so that people who haven't
seen the previous round can also comment).

As far as I can tell, this is the same as 8d1c70e5 (trailers: add
data structures and basic functions, 2014-03-06), so I'll queue the
remainder on top of that commit already on 'pu', which incidentally
will preserve the original author timestamp from the previous
incarnation.
