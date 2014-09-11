From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pretty: add %D format specifier
Date: Thu, 11 Sep 2014 09:56:46 -0700
Message-ID: <xmqq61guf641.fsf@gitster.dls.corp.google.com>
References: <5410C998.5060701@exec64.co.uk> <5410C9EF.9080509@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Harry Jeffery <harry@exec64.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 11 18:57:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS7fx-0004e5-My
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 18:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbaIKQ4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 12:56:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59111 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755154AbaIKQ4t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 12:56:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B95E839E07;
	Thu, 11 Sep 2014 12:56:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=do5HbW20o39G6iaeB9xlgAciqzA=; b=AUa5zd
	L1HrjrGfEsCP2Jsvv8iYrrPYGjf/vXXiuhlPgT35tfmCaA39KBOXwUboJblQD82d
	S3JcoJwKylj44XKNsvyOEPTjUdhChiWOZqh5fY/8/a2/sjvwpXapLH4JBY4fA/BJ
	SSbZapICF2kd8QO4rYlSdY9UpL80Hu0NqRhH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AYrfyDiXspgAI2yZx39j8fevya6aOjTu
	B/asmPNuu5AvcNouwuiiJimkXokjonSlT5qO4vqM3la0VIjJYxMeLjw/vlBIHvQT
	u141QbfqomulEIXqv+0HOTgLcZawzuCLbNGOIpnXpUeUUiumKmqdNqshGwAQRYJY
	YDHxCZ5hJVk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AEC2539E06;
	Thu, 11 Sep 2014 12:56:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2132D39E04;
	Thu, 11 Sep 2014 12:56:48 -0400 (EDT)
In-Reply-To: <5410C9EF.9080509@exec64.co.uk> (Harry Jeffery's message of "Wed,
	10 Sep 2014 23:00:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9E6950D6-39D4-11E4-BADD-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256852>

Because patch 1/2 alone does not make much sense without 2/2, it
probably would have been better to do these as a single patch.

And of course a few additional tests to t4205 would not hurt ;-)

Thanks.
