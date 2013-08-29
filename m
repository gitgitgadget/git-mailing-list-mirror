From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] Call it "Git User Manual" and remove reference to very old Git version
Date: Thu, 29 Aug 2013 11:12:41 -0700
Message-ID: <xmqq8uzk5pt2.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<1972849803.34382.1377626115372.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:12:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6iA-00083y-N6
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569Ab3H2SMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:12:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35039 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756214Ab3H2SMp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:12:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0758A3D560;
	Thu, 29 Aug 2013 18:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OI94k/XngU1paRYw9S9EWm7fHR0=; b=Wtpk85
	PlTJII0OkHOsStDsWSanJVmsbdi4bKMWm2EDe8iWc4H2MIsK7gWCHgpQzGwZu+lb
	C1NJT0iBonK51DRNhZSaHgUo4YKPZsp/sRuqIzoP6DURJ9pHOVwhsVrmJsOBYSlQ
	VEigFtULnFk7UHMTQ73AnY3I56sbOfuzybzDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oF+L4gz+1PqL3kUdXL1Ejc2wnXQF4mZE
	A5PYvejbMRgI2l4QoGzJXBhmFX0HGzyLnCB3sbqBcWkzmp96VVHdSp32sdwtCAS5
	kNbpLqLQ7WyDVdho+Lv7Mjd2gO0eUHZLORhlQKIY1MlYYN9gg6ON7JOFm1v/YGfL
	/Y5fm1WMEdg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCC1F3D55F;
	Thu, 29 Aug 2013 18:12:44 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2006F3D55C;
	Thu, 29 Aug 2013 18:12:44 +0000 (UTC)
In-Reply-To: <1972849803.34382.1377626115372.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 19:55:15 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 99D97A5A-10D6-11E3-9543-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233301>

Thomas Ackermann <th.acker@arcor.de> writes:

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/user-manual.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index fe723e4..103ec9a 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1,6 +1,5 @@
> -Git User's Manual (for version 1.5.3 or newer)
> -______________________________________________
> -
> +Git User Manual
> +_______________

The removal of the parenthesized part is good, but it should be
User's Manual, I think.
