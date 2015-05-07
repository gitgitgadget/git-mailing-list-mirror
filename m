From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/12] t5520: failing test for pull --all with no configured upstream
Date: Thu, 07 May 2015 11:48:51 -0700
Message-ID: <xmqq3838p6jw.fsf@gitster.dls.corp.google.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-11-git-send-email-pyokagan@gmail.com>
	<xmqq3838qoeb.fsf@gitster.dls.corp.google.com>
	<CACRoPnRXJOxUkT5sKQf2bLnWVQ-+xFPu8D2PbX2b_9XVEGwQnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:49:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQr3-0007uD-Au
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbbEGSs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:48:56 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751096AbbEGSsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:48:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1C6A4D9AE;
	Thu,  7 May 2015 14:48:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2XveFZxdiOGeU30li2IfZmfLY4w=; b=yCMmh+
	izU6swKqbfgqqc2lz/qOzhgkCRKg85dkyDWfNgOuSgChwEoFtexuJCG3xIZJCtMt
	c8Z6fJDfoxDxpa1t+9M894No6CHQ7zU2DXVk1ofza0XI5g71sXtrm/b3f0ajK0g8
	2gpBu+cW3VaCRFgutnonfX7XrmMHzRk+5q7Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VHNGDDSmsPyRq99BhAUv8YAE8rlZl5HD
	kQYEXMnbQK0CMzwDjmAHbkJiJpwlESCk3OKOTFSTwRC7eIG/CNIOgL9jGD7DDeak
	k62AKbJqOiUrUtGxGau3YXwMdzqJDQoS3RCY78fvrUqpeFmmswy5yqpy820Fij3M
	ukTFiHmwEGA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8F604D9AD;
	Thu,  7 May 2015 14:48:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A47F4D9AC;
	Thu,  7 May 2015 14:48:52 -0400 (EDT)
In-Reply-To: <CACRoPnRXJOxUkT5sKQf2bLnWVQ-+xFPu8D2PbX2b_9XVEGwQnA@mail.gmail.com>
	(Paul Tan's message of "Fri, 8 May 2015 02:05:35 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B49A7C42-F4E9-11E4-8D01-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268578>

Paul Tan <pyokagan@gmail.com> writes:

> .... This can be
> done with the current git-pull.sh, but would be easier with the
> superior C parse-options API.

Just this part, but I thought parse-options API is available to
scripts via "rev-parse --parseopt".
