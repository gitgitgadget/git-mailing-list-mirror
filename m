From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] warn about http server document being too old
Date: Wed, 16 Oct 2013 14:40:18 -0700
Message-ID: <xmqqli1s51z1.fsf@gitster.dls.corp.google.com>
References: <523D030A.6080309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 23:40:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWYpY-0000QY-G9
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760247Ab3JPVk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:40:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760196Ab3JPVkV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 17:40:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF7BC4B02C;
	Wed, 16 Oct 2013 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=K3PJi7uX5KSCqt8Uk5S4tk3Voe8=; b=jtndvRvFYRs8H/lH4UaL
	ak8GexU1ipOEhLMQBbvKVWqeBCa0ZcFYMaWPIoxx/gwjz7FBsO72T+cPG0FnBt2y
	ystUHqK2GOMiw95TFP38ETxvFhSZvyHwt6jdqpf+pGZTlwDwT2OJ54BHJN1IVqL8
	wWQEYa50bwapFt9M3MYYoLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ycowAtYOtBypq+sRqrk1cOU0wM2baHgH/2lZ+HFhTOvV1r
	Uxe8+q2K0TNoa3L72cRx+ZEO+o13dVWjBOiY2CNr/NiEwWBHbumwZzMQIKrtoQc/
	z6ftydr/J2KPqk1pml7pCXDO17haQdCplG1b107vPq9BG8+PA4tun86zDjPhE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4A2A4B02B;
	Wed, 16 Oct 2013 21:40:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 176434B027;
	Wed, 16 Oct 2013 21:40:20 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8E01A2A2-36AB-11E3-AD71-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236271>

Sitaram Chamarty <sitaramc@gmail.com> writes:

>   - describe when it is still applicable
>   - tell people where to go for most normal cases
>
> Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
> ---
>
> ref: http://thread.gmane.org/gmane.comp.version-control.git/159633.  Yes
> it's very old but better late than never.
>
>  Documentation/howto/setup-git-server-over-http.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
> index 7f4943e..90b19a0 100644
> --- a/Documentation/howto/setup-git-server-over-http.txt
> +++ b/Documentation/howto/setup-git-server-over-http.txt
> @@ -3,6 +3,11 @@ Subject: Setting up a Git repository which can be pushed into and pulled from ov
>  Date: Thu, 10 Aug 2006 22:00:26 +0200
>  Content-type: text/asciidoc
>
> +NOTE: This document is from 2006.  A lot has happened since then, and this
> +document is now relevant mainly if your web host is not CGI capable.
> +
> +Almost everyone else should instead look at linkgit:git-http-backend[1].
> +
>  How to setup Git server over http
>  =================================

I tend to agree that it is a good idea to have this kind of phrase
somewhere in the document, but you cannot place the material above
the top-level title.  AsciiDoc does not seem to like it.
