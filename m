From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 09/15] remote-testgit: exercise more features
Date: Wed, 21 Nov 2012 10:26:29 -0800
Message-ID: <7vhaoi3h0v.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-10-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:15:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFlF-0004bT-JG
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772Ab2KUTOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:14:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48928 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755755Ab2KUTO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:14:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4DED9640;
	Wed, 21 Nov 2012 14:14:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=7hLdnY+ThHvou07hQRlYKLzY2W8=; b=arWV4kEpT2R/YhcSDDmu
	E22kzET5RPQt3Qqf1i6suU09N9scbm5PARajiwSjLqLNU9cgLIjDqJr+lTZ0cUrA
	fuO9h0FmwUqA/KcP0wvveGpbfWayh54NeBAhzzTWkkSSbXys6Xo0xUdNDFY0g7z4
	ML5PEIIsCV8fCpzOYGGZmvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=nk0JYz2cKGXAgEyChqK3x2N0AxXA3w7FReRskBe5+V8STy
	pa5n79Sg4yXxDnNo91w5NiwhTVx9n2Y/0wn66EmyyUeUYvKN2bamv3CMMO5Udvbh
	Wp8MAsEYwnCdZNmXLx1w1EQ9a8Ni7GfYccISVY/fLky+86FTBtiH/ftg3FgU4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE7BD963F;
	Wed, 21 Nov 2012 14:14:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 346C09632; Wed, 21 Nov 2012
 14:14:26 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA66D786-340F-11E2-A4F1-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210160>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Unfortunately they do not work.

As far as I can tell, "more features" simply mean one, no?  Perhaps

    remote-testgit: exercise non-default refspec feature

or something.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-remote-testgit        | 18 +++++++++++++----
>  t/t5801-remote-helpers.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 4 deletions(-)
>  mode change 100755 => 100644 t/t5801-remote-helpers.sh

Oops.

Again, please check the fixup! interspersed in the result I'll queue
on 'pu'.

Thanks.
