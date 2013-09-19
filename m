From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] perf-lib: add test_perf_cleanup target
Date: Thu, 19 Sep 2013 10:19:11 -0700
Message-ID: <xmqqk3icu3u8.fsf@gitster.dls.corp.google.com>
References: <1379419842-32627-1-git-send-email-t.gummerer@gmail.com>
	<1379419842-32627-2-git-send-email-t.gummerer@gmail.com>
	<xmqq7gefz6m0.fsf@gitster.dls.corp.google.com>
	<87fvt1ghr4.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@inf.ethz.ch
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 19:19:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMhss-0006ft-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 19:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002Ab3ISRTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 13:19:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660Ab3ISRTN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 13:19:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70E7142687;
	Thu, 19 Sep 2013 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uAhKOwSWhDZLliQuIN8sakAKtJk=; b=nsp+8X
	UdQ4WQYR/g50przhTO5eYYMCv8xFUIvPr/GiC1QWTxGFFQEDrLiu9UiVPdY4tb+s
	n8D2vzbSblxUa93hHx3WPlCdTTlS4ihLcVHwvImnith9S6EZVsiU0vvZ79nwzPGp
	7nKuhxBTZXacWadBN+uOw7xUM8YZBG9a2vJEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rwChiz668IN/5+/c9d59ZgJyfTCLMq4b
	eEeJ0612VL+F/GbJ9n2bldBOG6A362le3cgxpzrTNb24o4IcYUUfNhz6ugoTYbBX
	A88UVwzdq3Rdvzaj+Z764zCappcRTIISxMQ7gx+NSATv7zwRHcPtpmfXCSUB8DAB
	2x8Afb4E324=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6561C42686;
	Thu, 19 Sep 2013 17:19:13 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C04E34267F;
	Thu, 19 Sep 2013 17:19:12 +0000 (UTC)
In-Reply-To: <87fvt1ghr4.fsf@gmail.com> (Thomas Gummerer's message of "Thu, 19
	Sep 2013 13:42:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9A697F36-214F-11E3-AA22-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235021>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> When one performance test fails, the testing is aborted and the cleanup
> commands are not executed anymore, leaving the trash directory in the
> failed state.

Ah, that I overlooked. In that case, the comments in my previous
message do not apply.

Thanks.
