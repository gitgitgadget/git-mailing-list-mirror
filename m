From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Off-line deverloper workflow?
Date: Thu, 27 Jun 2013 10:17:59 -0700
Message-ID: <7vd2r7tquw.fsf@alter.siamese.dyndns.org>
References: <20130627124656.GA2620@zuhnb712> <51CC4197.3000007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 19:18:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsFph-0004Zs-41
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 19:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab3F0RSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 13:18:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57546 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab3F0RSD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jun 2013 13:18:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 998F229EAB;
	Thu, 27 Jun 2013 17:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kDG0rKREXjfG
	klGiB2bBjbwMvUQ=; b=CV/CMdBdEUdeyAobrLOLV1rtGMrAHttfa7FaUPmIy+Z3
	d7oqJAP/tVGf34LRFTIk2AToDhvQxmSVbWzuDzTh8RuvsWtx/DT47dEufRYEb41L
	tK/T8JYUrp2IMhZpeNbXcSNUV2PIEVLyxVFhApVgskcBIZ5EkDRDiczswXjSkpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=F76lJD
	bwsY03mlrVdG3SBWsvR3wGyFwYSNt7uHiK9rthepxHq5oXnoCuKdFQkD5EP1fcgo
	VJBxSUj0mZ6Z1xQgrfWh6GNq2zGrZuwGiYqajRxym9KXyrJYcY+iBmyAhjhgmj6p
	PocaBVw5ACe4skgTlEjW+5m7wpN1RrLxfvLrg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84DB029EAA;
	Thu, 27 Jun 2013 17:18:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DB0A29EA7;
	Thu, 27 Jun 2013 17:18:01 +0000 (UTC)
In-Reply-To: <51CC4197.3000007@gmail.com> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 Avila"'s message of
	"Thu, 27 Jun 2013 15:43:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 854EE594-DF4D-11E2-B651-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229123>

Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:

> For a short time, I had the same issue. We came up using "git bundle"
> to bundle changes and exchange them via email.
>=20
> The setup was to work in two separate branches. The roaming developpe=
r
> started a new branch when leaving. After some work, she sent the
> commits on her branch as a bundle file. The origin merged the branch
> extracted from the developper's bundle and sent back the bundle of th=
e
> changes on origin since the last merge.
>
> No doubt that both side need to understand well the workflow of
> fetch/merge. Bundle files can be encrypted for better security.

Yes, the above describes exactly what "bundle" was invented for.
