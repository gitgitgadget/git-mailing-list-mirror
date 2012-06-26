From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Master and origin/master diverged
Date: Mon, 25 Jun 2012 21:11:09 -0700
Message-ID: <7vy5nad86a.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
 <4FE4C0F7.2080309@gmail.com>
 <CAE1pOi2MN_c76UBeRzdRbU8s+0LzYVoVcJ13V0di=HQobj+aDg@mail.gmail.com>
 <7v1ul6nbju.fsf@alter.siamese.dyndns.org>
 <CAE1pOi1JU1QvYOJeV2qC3EN=b==HE1nn+DvXBGNro0mROctsvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 06:14:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjNAN-0001dF-RM
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 06:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015Ab2FZELM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 00:11:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760Ab2FZELL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 00:11:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC42B9C8A;
	Tue, 26 Jun 2012 00:11:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zisc/EKEVNVFK5xys3s1zNHHeGg=; b=uw3TjZ
	0YMzWFv8WYrM1LEl8DlQX+V1INGEJR5NfUwd0v2tiw1utjaSEl4df8+litks8mz9
	IT5xHPxPYtyp6PpOof2+l4c80lHpT7GU/cldd/wQ3gx7XF3iuX5l0AxnvPSplnXN
	IXvqev4ONFAIuw0LIsO/RWgILXe7KifaGi1m0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H2TfzvrOw9W+DgIbo0ctSfuEZW/NTqwK
	4uK3yw5T+9XtRpsb8QIbP9QQVghE4CeHukuDtAH0W83eN3AEWOlWSrs3PUoccq/7
	uRuCyL8QapVqdr1ji4vnYYn/9bk5QZ8Fn32i18OzVWh8/0qZWdqIWLu02r0TNCcs
	tY0Z7ztYCCI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3B3E9C89;
	Tue, 26 Jun 2012 00:11:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BAFE9C88; Tue, 26 Jun 2012
 00:11:10 -0400 (EDT)
In-Reply-To: <CAE1pOi1JU1QvYOJeV2qC3EN=b==HE1nn+DvXBGNro0mROctsvQ@mail.gmail.com> (Hilco
 Wijbenga's message of "Mon, 25 Jun 2012 19:58:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F61653B8-BF44-11E1-A423-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200628>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> I agree and I was thinking of doing exactly that. So after your
> friendly nudge I sent them an email.
>
> The first (very prompt) reply said they didn't support "custom hooks".
> When I explained that I was not asking for a custom hook but that I
> simply wanted a Git setting changed, I was informed (again, very
> promptly)  that that was quite impossible. :-(
>
> In my opinion, it should be fairly simple for them to create a web UI
> to set Git config settings (I can understand they do not want to do it
> manually) but they do not seem very interested. A bit surprising and
> certainly very disappointing.

Well, there seem to be other Git hosting services with commercial
support and this might be a marketing opportunity for them ;-).
