From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] Large blob fixes
Date: Mon, 27 Feb 2012 10:43:47 -0800
Message-ID: <7v7gz89kws.fsf@alter.siamese.dyndns.org>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:43:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S25YB-0001W0-Vn
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671Ab2B0Snv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 13:43:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60418 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543Ab2B0Snv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 13:43:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C896861A9;
	Mon, 27 Feb 2012 13:43:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8WXjYB8Ib8GQ
	zUMn0VHCoiNRr7o=; b=UIOV5+dcB+4NZ2UIqeztiTItSbmEnpbYJEQRxk6Sl9hp
	uAU4YrWPhO1xi9GWsKToScjLFVzKybGXfikkRSfcN7TNWVlSgDBN2FMsXIll0AYq
	lOO7+gg1iZBzKU5eNygDUTf2ByJdM5LX0xEpc+j8YyHsjUggSbcdNPSnknRf7WU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DNNtRy
	2VNXNxnHmqidL1oSC8BHH7cO4arrirHs9I7OZF6J08A+/68dTekjJagbBtSfbYtH
	MnpGutEVd+oLW7fQ42S0ojbwIqEndJqvPK/C0G+j0hRTDg+tTosLXGTezzcSxc/8
	jo+YuWQlvHXAYm0reF52voKHvdZT2Ch/LVzLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C01EE61A7;
	Mon, 27 Feb 2012 13:43:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05D0F61A4; Mon, 27 Feb 2012
 13:43:48 -0500 (EST)
In-Reply-To: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 27 Feb
 2012 14:55:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCA007AE-6172-11E1-878C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191648>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> These patches make sure we avoid keeping whole blob in memory, at
> least in common cases. Blob-only streaming code paths are opened to
> accomplish that.

Some in the series seem to be unrelated to the above, namely, the
index-pack ones.
