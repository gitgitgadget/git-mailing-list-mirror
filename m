From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/9] completion: general cleanups
Date: Sat, 27 Apr 2013 14:34:16 -0700
Message-ID: <7v38ubu087.fsf@alter.siamese.dyndns.org>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 23:34:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWClD-0002za-UA
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 23:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124Ab3D0VeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 17:34:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab3D0VeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 17:34:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9BF51A938;
	Sat, 27 Apr 2013 21:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SKX+0hvLveaDO1QyCJBr08/S1RA=; b=tQ2UBF
	pkN9ygD32Ip3kU9P+TMLikPMA7A/BA4ZpqLkK2ivYs9c2n3v5XDS05LamU+8Flke
	gDMv7+7ew8rApwJnSZYyi/VADNenZHQOMrK7tX+mclhY5jY+RWixmHrxkM19/1+J
	yX0EyI/f81JcZ969zeequw9zYU4n9sUBVP7bM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CA0hFDxQ4PFJl1KG1qTWjCgEpRkRGVud
	9wM5uoJ30v+YRRovCZoOFaWaCSP4/xIEekub/69RN9aDximMmrYyPnahiOYnZAbf
	/8VtjPKvWSU0L0eE2qxwxfiSnbgLdlKq1JbrjRmOC7nPRc/Yx1h8imw9K47v7hgd
	VS1iXxW6Ifo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCC781A937;
	Sat, 27 Apr 2013 21:34:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F1791A935;
	Sat, 27 Apr 2013 21:34:18 +0000 (UTC)
In-Reply-To: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 27 Apr 2013 15:09:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 375335E8-AF82-11E2-83BD-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222702>

Overall this looks like a nice clean-up.  I didn't look at the 5/9
carefully to verify its claim that the change is a no-op, though.

Will queue.
