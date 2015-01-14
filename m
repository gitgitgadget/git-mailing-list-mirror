From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t1050-large: generate large files without dd
Date: Wed, 14 Jan 2015 13:59:18 -0800
Message-ID: <xmqqh9vt81mx.fsf@gitster.dls.corp.google.com>
References: <54B5579B.4080607@kdbg.org> <20150113214733.GA16582@peff.net>
	<54B59D24.7030508@kdbg.org> <20150113223849.GA3144@peff.net>
	<xmqq4mruckrp.fsf@gitster.dls.corp.google.com>
	<20150114112659.GA23474@peff.net> <54B6D188.7010500@kdbg.org>
	<20150114210016.GC1155@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:59:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBVyH-0008F9-PY
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 22:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbbANV7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 16:59:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751079AbbANV7V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 16:59:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A3DB2DF4F;
	Wed, 14 Jan 2015 16:59:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BytA83MgoYW4xk74wcmdgnTGnA4=; b=eWyuGe
	j1usoj0+9GyUF6O+JLZvbDm3JJyRrfCUirS+dPGxMzbYpDMLdffq36fAiXjfwNlY
	f75WF+k9gwmWrh8/vq8vEIXZbq25Yx5F5y0mRnV7BLlNMaP6qER7Xs23DdcGjsTD
	7uyCwkEsZR+XGSAanSI+ez3xMtKbMn+fO5NEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fr+nQ4ErSsil/qYfmuHOa/FmPN+t33F3
	Z+PtELbm+aYbHWM0BIevZnSmZcHVdnzMbC+4ggxVYPVZj6XkRFMkofVt7Qg07NAB
	qecumWrTCszl+TUuzM5CkY+QULsdpE46F4XeLvosLYPRx/XVkM4ZaiRKzz/vaQLa
	09VeD6eVe8k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FABC2DF4E;
	Wed, 14 Jan 2015 16:59:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17EBF2DF4D;
	Wed, 14 Jan 2015 16:59:20 -0500 (EST)
In-Reply-To: <20150114210016.GC1155@peff.net> (Jeff King's message of "Wed, 14
	Jan 2015 16:00:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 97753ADA-9C38-11E4-9055-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262436>

Jeff King <peff@peff.net> writes:

>> @@ -162,7 +162,7 @@ test_expect_success 'pack-objects with large loose
>> object' '
>
> Funny wrapping here. I imagine Junio can manage to apply it anyway, but
> you may want to check your MUA settings.

Thanks for a warning; luckily this was the only breakage and the
result looks good.
