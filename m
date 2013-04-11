From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Thu, 11 Apr 2013 16:05:40 -0700
Message-ID: <7vd2u0hdmj.fsf@alter.siamese.dyndns.org>
References: <20130410211311.GA24277@sigill.intra.peff.net>
 <20130410211552.GA3256@sigill.intra.peff.net>
 <CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
 <7vfvywj4au.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QJJnSRVVJscLsTnXk5zdGbA2utefF5SO7=90+ttENew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 01:05:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQQYu-0005eJ-O0
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 01:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765905Ab3DKXFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 19:05:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761178Ab3DKXFn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 19:05:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4C7F152D6;
	Thu, 11 Apr 2013 23:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dmnXbyyb/8AAUTMDwNZYjOywnRk=; b=XiElKS
	jhYIVdTQ4wqvXhPp+XyanQuiZbC96AGJaxvRYXSmIFyOe7I9ob2a2h4YjpyVuLtC
	Itn5m9cey4FO4QGbdLDlqiv01FEiPpUaSfJ2aA+x9tb8Hx0QHPRSudwplkMLmNQP
	UjeKhbLgMVFKnF8oVKlbvdfTw3FMlX20vvdcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yf3FhW20hSrF1rtRjAs5RakzeD2B43SB
	xFZA1VDIWa90GzjplgZvsTX3xfCNs4FHWQHaB4vUCK/vw+LVl/E+c0vMliuQ5eJx
	bwEX2ZMPjHye3z97cHXAojvG/p3A0gGbsEI+xuikmUsU5yiYcuFo6vqF6ozs1Z2t
	COkR/zaU4vs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB05C152D5;
	Thu, 11 Apr 2013 23:05:42 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CD1E152D3; Thu, 11 Apr
 2013 23:05:42 +0000 (UTC)
In-Reply-To: <CAMP44s2QJJnSRVVJscLsTnXk5zdGbA2utefF5SO7=90+ttENew@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 11 Apr 2013 16:21:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5559D156-A2FC-11E2-AA74-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220940>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> And if you must, you might was well label them with "REMINDER", no,
> wait, that's what "TODO" comments are for, where people can see them,
> and not *forget* them.

Yeah, good point.
