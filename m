From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/4] Show extra branch refs in gitweb
Date: Thu, 12 Dec 2013 13:46:13 -0800
Message-ID: <xmqqfvpxspy2.fsf@gitster.dls.corp.google.com>
References: <1386762884-7564-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, sunshine@sunshineco.com
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 22:46:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrE5N-0004lo-Nd
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 22:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab3LLVqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 16:46:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33215 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608Ab3LLVqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 16:46:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FB9259B4A;
	Thu, 12 Dec 2013 16:46:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ftpambhnBeR5VKyX8P3QMOokuSo=; b=oWxfr5
	fo1LB+nJso9eHjcAyRg7zg+V68tQV6vQLPy53ausRFh1FXd4A4atCluScSUS1/Hy
	xs6EKfp767/g+qRVnuJrPCF34w7qni0aZbsphxVgbIk3iMLS2uQemciN9BJH+hrJ
	/ll4mJDvlacKtpopXZ5ldo0BFuJuSQYzNaDBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XWy83Rr/4NY02G3Und13UC9nL+XN/Q0q
	5XDj/yATXuU3bT45kQhufoNzxTF8/UthohRRDt9O4W6tmyl8dsy5XUEgBlPP5B34
	7RVRaTeXbzcuIy15qLKOM+PKi7mrn1sOLW8yOF53xQqMNbqksyzBg6e3lQs881Gl
	igVT6QP62go=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24C7459B49;
	Thu, 12 Dec 2013 16:46:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5128F59B47;
	Thu, 12 Dec 2013 16:46:15 -0500 (EST)
In-Reply-To: <1386762884-7564-1-git-send-email-krzesimir@endocode.com>
	(Krzesimir Nowak's message of "Wed, 11 Dec 2013 12:54:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D34A8AAC-6376-11E3-8639-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239247>

Krzesimir Nowak <krzesimir@endocode.com> writes:

> First patch splits some code to a function.
>
> Second patch fixes validation functions to return either 0 or 1,
> instead of undef or passed $input.
>
> Third patch adds the extra-branch-feature and some documentation.
>
> Fourth patch adds some visual differentation of branches from
> non-standard ref directories.

Thanks; will queue.
