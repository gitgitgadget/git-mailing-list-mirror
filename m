From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Remove i18n legos in notifying new branch tracking
 setup
Date: Thu, 07 Jun 2012 11:44:03 -0700
Message-ID: <7v8vfzgdxo.fsf@alter.siamese.dyndns.org>
References: <1339070715-31417-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 20:44:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Schgq-0002GD-Pz
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 20:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab2FGSoI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 14:44:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51616 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099Ab2FGSoH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 14:44:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A29E68D8D;
	Thu,  7 Jun 2012 14:44:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=juyjf5HAVsVB
	xE0Z+vmu2XgfREc=; b=OtNNX4vv5VpLm+OOgYRKfCV0FGRlRsveE3lo4NFijB4I
	3chrjXsSPAHLQTw4uVZBCA5xFOKPF5gE8YlsmNochcsNXSPQ0bENnX7D8l9+NSR1
	lbB8XVS6ygrZOUKgIfE2M6O8RXBht1WbVBjgP9ixkWPy1vKLGctKvGr4SDVC4Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RBl+9Y
	F4C+Cq2Zdphb/Y0WieSIFHpsT3HAIEsGuLYKn5laydVt6MHvh6J29SNSDKmZbNTO
	bfqLSyBk7+S1HhFT1kvuP/XfHzGqNivgDgQ3GHcGngP9VRHnCo5H79v7ZjzXVDyy
	wrPDNoUKJqlgWAztFOlx8Ed+pj3ptk/h5aS9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B0B18D8A;
	Thu,  7 Jun 2012 14:44:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AC408D88; Thu,  7 Jun 2012
 14:44:05 -0400 (EDT)
In-Reply-To: <1339070715-31417-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 7 Jun
 2012 19:05:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2037C40-B0D0-11E1-B212-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199436>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  More compact code compared to the lasst version while maintaining
>  -Wformat's effectiveness.

I'd hesitate to burden translators with new set of strings this late
in the cycle.  The changes look reasonable, though.  Let's merge
this early in the next cycle and mark the strings for translation.

Thanks.
