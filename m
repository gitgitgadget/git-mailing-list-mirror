From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone.txt: remove the restriction on pushing from a shallow clone
Date: Thu, 11 Jul 2013 22:54:49 -0700
Message-ID: <7vy59cnx06.fsf@alter.siamese.dyndns.org>
References: <1373607462-12836-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 07:54:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWJk-0005MT-5h
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 07:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab3GLFyw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jul 2013 01:54:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab3GLFyv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jul 2013 01:54:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FDA52A470;
	Fri, 12 Jul 2013 05:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JqRMOT8RUjwI
	SWf6lAeJb8zVXks=; b=bC/3fdHBAze5V+Ms9zPFWpH5YKVHo6fv9whxud0mRSD1
	1Xiqa0RvhClwsOvpsIlgIP/JX4RN183mQMPJDjMJOXsUOIor3ez9aZDbvdIE4111
	XdG7adN5ORyVf47+FPEp3GntKVlzpr+3582GdrF/hiRkIYa3mjMJ+3tR5Pvv/YU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TOvqzN
	f80M+TVEeVu9UA7H10p9DvgInQbvo0z//WBOI4tOqssImAezCTa6EpVYrbP2mIkr
	ZU6chsLzd7YOBdLyKHAL9BroHdLL3jR/421iGA3huX7BG/Rl/nZG8s7CRLoPLD1g
	eVZU4iTHT8cVxQe7A0uUB7WbxcjXCJjsLvVaI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 466322A46E;
	Fri, 12 Jul 2013 05:54:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A96D52A46D;
	Fri, 12 Jul 2013 05:54:50 +0000 (UTC)
In-Reply-To: <1373607462-12836-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 12
 Jul 2013 12:37:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90FE0968-EAB7-11E2-A535-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230163>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +	number of limitations (you cannot clone or fetch from it, nor
> +	push into it), but is adequate if you are only interested in
> +	the recent history of a large project with a long history.

Ahh, sorry for the noise.  You still say you cannot push _into_ it.
