From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] t0000 cleanups
Date: Mon, 30 Dec 2013 11:24:43 -0800
Message-ID: <xmqqd2kervk4.fsf@gitster.dls.corp.google.com>
References: <20131228092731.GA26337@sigill.intra.peff.net>
	<20131228222129.GE5544@google.com>
	<xmqqwqimry2j.fsf@gitster.dls.corp.google.com>
	<20131230185125.GI20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 30 20:24:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxiSJ-0005LQ-7b
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 20:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148Ab3L3TYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 14:24:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33609 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129Ab3L3TYq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 14:24:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0AFD5F36B;
	Mon, 30 Dec 2013 14:24:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ncbiw3R5X1TAzHvkurqFiM4v5VI=; b=fBY5z4
	h2iuEzfaE/ntpasF/lht8CA+a2GDOw1l+NzukBRdOsD19CxbzfGhF4lio3dIpXwM
	uCE/TTOwvZ0uUMMh+MqJbIuwlCZL0I2Qr1uIw52JQ5Fr3zDadoT50mDJLal7TuCn
	zr4AmuyBWCB3IVK5GM51e40xlI6dr80DhZ37o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=egMBjxwguGO4SHmDnhQMmmqPo9AzQvTj
	FaUcjVbWW3PrRxB5EdJeINoIO0m1PrQKcELiDeAefEE/ehw4CZatfn8xTsn8a0GN
	JBvlJKA0pID2HpAdkEVlvrqJd6YCu0/klgUHQ97i/cZ1qAJsHc5r1rE0k93iAPyR
	66qglXuDNqE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D275F5F36A;
	Mon, 30 Dec 2013 14:24:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E7765F369;
	Mon, 30 Dec 2013 14:24:45 -0500 (EST)
In-Reply-To: <20131230185125.GI20443@google.com> (Jonathan Nieder's message of
	"Mon, 30 Dec 2013 10:51:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0A40EA5A-7188-11E3-A617-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239816>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Does that make sense?

Sure, sounds good to me.
