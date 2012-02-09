From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-master] tag: add --points-at list option
Date: Wed, 08 Feb 2012 20:29:26 -0800
Message-ID: <7vfweky6hl.fsf@alter.siamese.dyndns.org>
References: <20120208205857.GA22479@sigill.intra.peff.net>
 <1328742223-24419-2-git-send-email-tmgrennan@gmail.com>
 <20120209014430.GA21661@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 09 05:29:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvLdW-0004Ff-G8
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 05:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757775Ab2BIE3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 23:29:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757706Ab2BIE33 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 23:29:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9044D745E;
	Wed,  8 Feb 2012 23:29:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=oONjPixwKTTE+O7H/Qqqux1eBbo=; b=htwAXeTs1PnlUzAhdqlQ
	d0DuL87I663hmx9/2p4JexL0OR5+DWgK8Zu5osg1ubWxLxShntzmkGT6kqQJn7L8
	ljwh6wBveQ2qoTOacZS5/Svif72mASCqLPkwQw3Q6ny1s0qfqkPssNCTuUxgIeFb
	sOwhLXQBh2SonZvEoOi24cM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=B6jzri3wRU25Mh+GaFoMA7L3URZ2oyqkdUMhZzzpdVGElS
	Hpzzycz7plA8qzYCdR71h/Imm0UsswtAoUiIx/CQ8tpNSgAoX1RtZlPh2a0TdgVF
	5PC+9j2syKgj2TiS5Vu0l0PLYAQZ/KJw96YKbE7O/uxsiU08377On88NTFtqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 872E1745D;
	Wed,  8 Feb 2012 23:29:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EE8D745C; Wed,  8 Feb 2012
 23:29:28 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7509390-52D6-11E1-9A68-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190271>

Jeff King <peff@peff.net> writes:

>> Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
>
> This version looks fine to me. Thanks.

Thanks, both.  Will queue.
