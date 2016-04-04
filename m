From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix spelling mistakes
Date: Mon, 04 Apr 2016 10:45:51 -0700
Message-ID: <xmqqd1q55kts.fsf@gitster.mtv.corp.google.com>
References: <1459688165-8720-1-git-send-email-eric@engestrom.ch>
	<xmqqbn5qfth8.fsf@gitster.mtv.corp.google.com>
	<20160403185517.GA6612@engestrom.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Engestrom <eric@engestrom.ch>
X-From: git-owner@vger.kernel.org Mon Apr 04 19:45:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an8Zb-0005iK-7z
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 19:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595AbcDDRpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 13:45:55 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752592AbcDDRpy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 13:45:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16CC54F489;
	Mon,  4 Apr 2016 13:45:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5D3TmS7qmEHqt2RF5sGGYm+ePlM=; b=BRtERO
	dabVB8Rz6klceIjyqpwKV72zp+K3uALhSk05GHbQpPyd1KRJui2QbjbgeUZGECkp
	CtoV2YoGkC5M8+7CA+lxWb5AkrgjN+VGl9SnbkXxgiq9En0XdPK3o9jdWcoDw0F4
	NKCbrv8Cwrz7cXAFYk7I9WtTkWDdnG5GQtBb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=acYemiuNcbufduky2oIvSEjmDHN/fONo
	ZeqZLKR0tShBDH5XwiN6MTqmgm1Sms6fg8+6a0JarKNSDYUTLQiAJiPGNTaF20ME
	6LC5/NYu1LmPQ+C8sGvRLcUTyqitF/UG68bbrhQATxeh2rPoPw+GO02ULs0slpmJ
	aTOfehGuEFw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E553B4F486;
	Mon,  4 Apr 2016 13:45:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 485654F479;
	Mon,  4 Apr 2016 13:45:52 -0400 (EDT)
In-Reply-To: <20160403185517.GA6612@engestrom.ch> (Eric Engestrom's message of
	"Sun, 3 Apr 2016 19:55:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1323FA28-FA8D-11E5-BB54-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290708>

Eric Engestrom <eric@engestrom.ch> writes:

> I went by word-count: "through" was way more common than "thru", so
> I kept the fix.

That is not a "fix" (as it is not touching "mistakes") but "making
them consistent".  I do not personally feel strongly against such a
change, but please leave them out of "Subject: [PATCH] typofix".

> BTW, I used codespell to fix those, I didn't do it by hand :]
> https://github.com/lucasdemarchi/codespell

Heh, cute ;-)

> I can remove the "thru" fixes if you'd prefer, and resend with only the
> other fixes.

Thanks.
