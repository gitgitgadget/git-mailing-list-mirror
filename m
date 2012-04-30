From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git-branch: remove lego in i18n messages
Date: Mon, 30 Apr 2012 10:38:46 -0700
Message-ID: <7vzk9tf7bt.fsf@alter.siamese.dyndns.org>
References: <1335799995-7667-1-git-send-email-avarab@gmail.com>
 <1335799995-7667-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 19:38:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOuYn-0006kA-BA
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 19:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355Ab2D3Rit convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 13:38:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528Ab2D3Ris convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 13:38:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92CB57DA0;
	Mon, 30 Apr 2012 13:38:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DW0Cq3Zszt4S
	Be5q4Hi4bo+hDyQ=; b=abWsc4T3j9SF/zEdkje1t7hAlqnJpYeVQZbKM8/srtBc
	MLLIkPnTtG3fgeUJAdgpw3q3zKxiHteEi6AL0ErhZnCb8Azc0JHgtSu9r+fGA6yf
	wODjRRnrTwjMiacyTduzRVTOKQsseoxOfF16W1r0VvKQYbC88oqz2GOziIaMNYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DD+qy0
	QCYk5GVyXPp6t9eyhOxPwuoI5NadnwSAvMcAEZBQIji2pL78R6y9lVsO49eFlxip
	yupSn01+E7n536ys2kmoQ+UMdvFrV/B7IIrgVbAmk9ltmrYrboMWMJUIFkdHYgip
	2lKPuKWKlUtqq6manblH8/mp4NGSDj06iRl5Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 820B17D9F;
	Mon, 30 Apr 2012 13:38:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E01A7D9D; Mon, 30 Apr 2012
 13:38:47 -0400 (EDT)
In-Reply-To: <1335799995-7667-4-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 30 Apr
 2012 15:33:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 577E32A0-92EB-11E1-AB91-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196583>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Instead of making translators translate "remote " and then using
> "%sbranch" where "%s" is either "remote " or "" just split the two up
> into separate messages. This makes the translation of this section of
> git-branch much less confusing.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---

Looks good.
