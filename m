From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/11] Introduce a performance test for git-rebase
Date: Mon, 12 Mar 2012 13:59:51 -0700
Message-ID: <7v1uoxr0vs.fsf@alter.siamese.dyndns.org>
References: <cover.1331561353.git.trast@student.ethz.ch>
 <e6a6af53264368a25e71719901f3227042e21f5c.1331561353.git.trast@student.ethz.ch> <87ipi9yaws.fsf@thomas.inf.ethz.ch> <7v399dsiw2.fsf@alter.siamese.dyndns.org> <87obs1po5a.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:59:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7CLW-00029D-IN
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 21:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757318Ab2CLU7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 16:59:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756897Ab2CLU7x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 16:59:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 729D67456;
	Mon, 12 Mar 2012 16:59:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MHGG6sb3JQ8q5766vNxH/ktyCaA=; b=fMNGDR
	xiHLCp6c5CD+U3MAyv7pC+6ZI9pMMNCNaEonRxDvGHdM/Rv0bVuLGrjA5+eSuHLf
	Lu4hYCDkYcWboYaMuR4el/Bsg6Zw1KdvD4h+zSIPVr8rQh1T0OJ0MjwPuQIm13n9
	dBEbgi1e1M9UAo723MLZVHhbpdyMnb1XyaMRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xkHhhWuD2htg+JELHeMp4SQFCKcZZfFj
	nNHXvvuBwc8klucu10VcNK0AdTVxDolvBUDetOMnjQnVLGOQSnU9BSiPK949Xw10
	t8p8p46yPWdM5izWGIMnjAPaOPXeTrU4Q+S3JBt6CWxyVlSve3Iy12uQFw8xtv5W
	dQB6CCz8mKw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A50D7455;
	Mon, 12 Mar 2012 16:59:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 033517454; Mon, 12 Mar 2012
 16:59:52 -0400 (EDT)
In-Reply-To: <87obs1po5a.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 12 Mar 2012 21:20:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50868F46-6C86-11E1-8D64-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192946>

Thomas Rast <trast@inf.ethz.ch> writes:

> Ah, but that's a trap, or do you have an apply --3way series sitting
> somewhere ;-)

According to rumors, it is more trivial than a typical summer
project for a GSoC student, so...
