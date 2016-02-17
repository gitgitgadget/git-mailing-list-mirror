From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Wed, 17 Feb 2016 11:03:11 -0800
Message-ID: <xmqq60xnjh1s.fsf@gitster.mtv.corp.google.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
	<448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	<vpqh9h7f9kz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:03:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW7Nd-0000RD-TY
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 20:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161496AbcBQTDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 14:03:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030388AbcBQTDN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 14:03:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 074DE42096;
	Wed, 17 Feb 2016 14:03:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dzjan9wswAv89b1XnzBDrCLrpGE=; b=B4W99i
	NERx8GNHll7g2xndw6CEU7hias9aP1tqxKpz2u9oZuJTEmqzELaCKx5WQ5Fshl1s
	kdd+wqdlSH7HflWwt6d5PIidtTSl+B/XDSXy3fMnlNPj0P8NvA1Mq/dGbcNsPsCb
	BIs5kRMM9IKcJOZ2OWvODoKEW034d8Jf1iEkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oPZhGw+eOi1Ddg2UTgSxJwr7jpmstW/Y
	7ZpiRHEysz8XbL+mDhDuGqJ4orDi5WVLDn/VEZNRl7LrCj2Ro3rF/FcxbDHXj58q
	zX+niHsW4C1udY77aKYVfWAjiF9OJOD14Hx7kFDBX9UXdeOEsCy5MvZNQNB2Ndxt
	PKCTAVIFmIo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0C7442094;
	Wed, 17 Feb 2016 14:03:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4657E42093;
	Wed, 17 Feb 2016 14:03:12 -0500 (EST)
In-Reply-To: <vpqh9h7f9kz.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	17 Feb 2016 19:58:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 176A7994-D5A9-11E5-AA5A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286535>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Feel free to start writting an idea for
> http://git.github.io/SoC-2016-Ideas/. It'd be nice to have a few more
> ideas before Friday. We can polish them later if needed.

The top of the page says it is shared between Git and libgit2;
should that be really the case?  We later say we only have capacity
for two mentors, but the mentor pool capacity is not shared between
two projects.

I am wondering if we heard from libgit2 folks if they want us to
host them (or they want to participate in GSoC at all).
