From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On "interpret-trailers" standalone tool
Date: Wed, 16 Apr 2014 11:54:44 -0700
Message-ID: <xmqqeh0xgl57.fsf@gitster.dls.corp.google.com>
References: <xmqq61mi1djt.fsf@gitster.dls.corp.google.com>
	<20140412.213003.73509455950485398.chriscool@tuxfamily.org>
	<xmqqy4z7lhc4.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0w9xUwuk9UZ_mu=qvjtYN1r5skidweruM8t1KbfQpQyA@mail.gmail.com>
	<xmqq38hdi2zr.fsf@gitster.dls.corp.google.com>
	<xmqqlhv5glst.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 20:54:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaUz1-0006iT-N7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 20:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726AbaDPSyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 14:54:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50729 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754972AbaDPSyr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 14:54:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B78A7D104;
	Wed, 16 Apr 2014 14:54:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PRmF5Md7EYoKBgnwe9GELV9pEGc=; b=xnH9sP
	YjQ9s8+Z0wwH9s+cekZ263bGQugtBAIXq4CcG9shG33j9uP3yaXTPnebEH/WxATN
	kN+oVSlazy7//dw2xDyBJeiKArc4VY+1EyJLadoemnUjBP18EuKlb2oNsaRPQuxe
	AXQ4TSmkZpukH2dhPDGP6nG3OfZfN6RvNYTtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wAtc23pqkup7sm8r2a5C+BZrkYx5XPMC
	hIV2hBvsbb23yy9478ItpQDuTD+ZrYmNMewXBZwt9bUUFVk/eLTwMVEWAvfz8k+t
	5B0k0a/nkNAK+QGAfngGAS10Vu8p5wTeZb9cOdjfsq82cEDdqRegiVBgArQpyRI3
	cgjFnl6UYS0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11B757D103;
	Wed, 16 Apr 2014 14:54:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7C387D0FD;
	Wed, 16 Apr 2014 14:54:45 -0400 (EDT)
In-Reply-To: <xmqqlhv5glst.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 16 Apr 2014 11:40:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 93D43C54-C598-11E3-B148-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246372>

Junio C Hamano <gitster@pobox.com> writes:

> ...  I am being
> cautious here because I do not see us making the same mistake.

s/do not/& want to/

Sorry for the noise.
