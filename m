From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [PATCH 4/5] Replace {pre,suf}fixcmp() with {starts,ends}_with()
Date: Wed, 04 Dec 2013 12:51:43 -0800
Message-ID: <xmqqk3fkjq5c.fsf@gitster.dls.corp.google.com>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
	<20131201074919.3042.92026.chriscool@tuxfamily.org>
	<CAP8UFD0jg_Vr7Zf+DiMX9RG6vmmQvmk2NvmL7j=MC-x3fLOOBA@mail.gmail.com>
	<20131203124645.GB26667@sigill.intra.peff.net>
	<CAP8UFD0By77QVH1amsh85dX6h1S3iFZcmPzs3JjPZmiD_AmOPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 21:51:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoJQG-0002S8-Rl
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 21:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933251Ab3LDUvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 15:51:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42918 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755986Ab3LDUvs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 15:51:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDF9C575FD;
	Wed,  4 Dec 2013 15:51:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/a+j7g88Xl1qIwmeDpOKuSUl2iE=; b=ccmUeO
	5gRSOla+SE3AsTfWdQDsu8lei8uOOIA33qWAQzP6+dNhN7YnS4VTse0xuCHciVAv
	TkcTNkUucmhjjysEuqSHVU5MehqOyUDk+u6gbAjh3wH9TeByAVlHB22srPpec2Do
	Khvb1jjKeKo2L1gvB0TLQoGQR+MGhqdMK+9h0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KUOQFVeycWwAR91DLjGvTaHqSdM1LN3t
	aQDjOJcadglHIr+skyq6qux5ABqDehrb+umOly1exKjdwYDDy6oTn55lll9lh/MP
	qVGG23f217ulvYPbF2aPIEID3yahb7g1ABK6XC+hBIz37j03+AsLqmtaUfhVcnEo
	ugFRBm/UYGE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC5B4575FC;
	Wed,  4 Dec 2013 15:51:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FB57575F9;
	Wed,  4 Dec 2013 15:51:46 -0500 (EST)
In-Reply-To: <CAP8UFD0By77QVH1amsh85dX6h1S3iFZcmPzs3JjPZmiD_AmOPQ@mail.gmail.com>
	(Christian Couder's message of "Tue, 3 Dec 2013 21:24:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E3F2EE14-5D25-11E3-9831-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238813>

Christian Couder <christian.couder@gmail.com> writes:

> Ok, the commit is in the use_starts_ends_with branch on this github repo:
>
> https://github.com/chriscool/git.git

I looked at the patches, and they looked alright.  The endgame needs
to be on a separate topic to be held until a distant future, though.

Will queue.  Thanks.
