From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation more consistent
Date: Fri, 03 Jun 2016 15:42:00 -0700
Message-ID: <xmqqh9d9opxj.fsf@gitster.mtv.corp.google.com>
References: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
	<20160603220837.9842-1-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, peff@peff.net
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 00:42:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8xn8-00067Z-Dn
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 00:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbcFCWmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 18:42:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751814AbcFCWmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 18:42:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DE6E1F450;
	Fri,  3 Jun 2016 18:42:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MC7t7dNHiWfuB/Z/JGPPS2tOOfw=; b=tP1weV
	F8ecQfUaX0Xyf7YctE0ZO2GameiW93t6W6uxa1q9E75Ry5sriHkAW/dViNj6KWf1
	HkPwl45VLwSqnXRQfd9I2dfw+IFWcPqWTGPnouvcaLXFQWiriWDls93Oq0t5kQiF
	nvBiCEksAEs1PwR83iToPXuM1bGewuBai710U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NnfIhhUQoYCmmpdLqefE2/5/XxlQ7XDY
	nX1IYbn0Sk2mJ4701TrAmK8HCOffu7AVhLBG3CdC2VsgMkRZahAxU0HSnpZIxQQt
	wkbSMgv9FFcqyqknGdG2r4ogu9jSnnOlKHwlCF+RJ3AQ1QrVN5x6Hi33L3+f0kpG
	R3YTSs3gpLc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 15F9A1F44F;
	Fri,  3 Jun 2016 18:42:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97EEA1F44E;
	Fri,  3 Jun 2016 18:42:02 -0400 (EDT)
In-Reply-To: <20160603220837.9842-1-tom.russello@grenoble-inp.org> (Tom
	Russello's message of "Sat, 4 Jun 2016 00:08:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63E64B18-29DC-11E6-9706-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296422>

Tom Russello <tom.russello@grenoble-inp.org> writes:

> Hello,
> as `MAN_BOLD_LITERAL` knob is now turned on by default, it is the right time to
> make our documentation more consistent.

"is now turned on by default" since when ;-)?

Just kidding; it just happened in my tree a few minutes ago but
the result hasn't been pushed out yet.

Please make sure that your Subject lines will identify what these
three patches do in the bigger picture of the whole project well
when mixed together with 400+ other patches that typically appear in
a single release in the output of "git shortlog --no-merges".

The way we do so typically is by prefixing them with a short token
that identifies the functional area they worked on; something like
"doc: " would be appropriate for these three.

Thanks.
