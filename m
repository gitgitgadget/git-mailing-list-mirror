From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff-options: document default similarity index
Date: Fri, 05 Jul 2013 02:00:40 -0700
Message-ID: <7vbo6h8jpj.fsf@alter.siamese.dyndns.org>
References: <1373013737-2448-1-git-send-email-frase@frase.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fraser Tweedale <frase@frase.id.au>
X-From: git-owner@vger.kernel.org Fri Jul 05 11:00:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv1sk-0000gL-UX
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 11:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215Ab3GEJAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 05:00:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753718Ab3GEJAm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 05:00:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 254E32B000;
	Fri,  5 Jul 2013 09:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iQE4cT0cjVEUKWxFwVZhGpGRlBI=; b=kLTLxO
	6Y/jUjrZ676oX0Jp5wgCATvbf5cpKjr8TRERd1hDGCRTZk5UHvGhN1AwLiPuLfhk
	DL4inno30ewlq7OOSj2UUPkGnSZCLT+D2UOaPJkyTp+XT6nYHLJ3muWQCkDM0r/r
	iUrPl6WUkwtAQjQ1Oo9Ll3mifQBWGHTnXIkSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YJRZ5OypvtV/+Kl86hszil0Wtkx3RaPH
	wQZg1226nrtfvDXptnFuaiLmyKOHqSFcojjVHqrLOKuFxO/wtlXe2W3bagi5MgDd
	Iuk3iQV16hY4vgVv3HWVL+wXfDJ0a13T6tZhJWnKqAO6m30tysYJlvwVtBdfFUDy
	6nyNmncxbFk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D6CA2AFFF;
	Fri,  5 Jul 2013 09:00:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 995B22AFFD;
	Fri,  5 Jul 2013 09:00:41 +0000 (UTC)
In-Reply-To: <1373013737-2448-1-git-send-email-frase@frase.id.au> (Fraser
	Tweedale's message of "Fri, 5 Jul 2013 18:42:17 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E934206-E551-11E2-90C7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229644>

Fraser Tweedale <frase@frase.id.au> writes:

> The default similarity index of 50% is documented in gitdiffcore(7)
> but it is worth also mentioning it in the description of the
> -M/--find-renames option.

Is it?  I am not sure if it is worth it.
