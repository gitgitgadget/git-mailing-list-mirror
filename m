From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: introduce %(upstream:track[short])
Date: Wed, 13 Nov 2013 11:44:32 -0800
Message-ID: <xmqqfvr0dr33.fsf@gitster.dls.corp.google.com>
References: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
	<1384335406-16332-3-git-send-email-artagnon@gmail.com>
	<xmqqk3gcdr6z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 20:44:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VggMj-0005vk-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 20:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462Ab3KMToh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 14:44:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932416Ab3KMTof (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 14:44:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4D2652DA0;
	Wed, 13 Nov 2013 14:44:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OaAq4NrKnrnOAlQxbfoWLbMkvGs=; b=wJQMZM
	OyqLWQ0K7/4StzmI/BbzJOJD9ebm6aJXfaCw/41NO25PxtJVcdFFbW6WZx91W5Ow
	ZScudTnyDyN81OdCqH15WWGVNE/tmdhzIBLMRU+m6UOCG8LpOkVTwByrjNFDomQz
	hGIDzF+gK2Wxvew2XrPb6oE3fB+/vy8UvoQDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M3hgvTH/iwQoeAzPacvu0IzaxGewx8l6
	3NV9trY7sl2fSb06PgLtbBnnszAF0FXn2ezEaXm40qvdIgwqTf+9uxf/690figmR
	a/JFxM8RHPBz8HCTh+EuzOpoJiDJw8ZzOblW06jhCrJrqk22Lnv2CZxj1cUXYKJj
	BvlfQljx9sk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6A7B52D9F;
	Wed, 13 Nov 2013 14:44:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01E5252D9E;
	Wed, 13 Nov 2013 14:44:33 -0500 (EST)
In-Reply-To: <xmqqk3gcdr6z.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 13 Nov 2013 11:42:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 056227E4-4C9C-11E3-912C-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237799>

Junio C Hamano <gitster@pobox.com> writes:

> You need to squash 78465bb,...

oops; make it 2249926. 784 is a cherry-pick of it on top of this round.
