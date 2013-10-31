From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/16] fetch: add missing documentation
Date: Thu, 31 Oct 2013 11:10:59 -0700
Message-ID: <xmqqwqkt71l8.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbwi5-0004vJ-Ot
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930Ab3JaSLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:11:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754425Ab3JaSLD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:11:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4B554E416;
	Thu, 31 Oct 2013 14:11:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=7TcfezUw/yYe9ETx1Pu9ZUpZmD0=; b=oM+wvlMYPGFI7owMq8OL
	70fmNhMms4B1bqWvembiTqjs/61C7vrPFHA/AGAO7OjVNaUUOnFRAGw+OhKPmTbb
	uGOgJq3DHsUJEFdfAuNWvKto2NPNBBjmJar+gE9PzOHfoXSDfU5JaNxoLJNaCg46
	YlMGgeXp4rTqsCPrKCqTtFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=BBPkO3WMwp4zdxPS5PjyXJjpWYG1nFUGOpUOX/8fTCC/9e
	fKq4FbejwSrjuq5ZShuxlIRigOjwne1+VzjVKUKkfena5MpvcoarU9INncbwMV+d
	qFvWufosywdh3lBLxej72ueqFA5KK27AEvWptova7v4nCxKiM6Wz+uEP29Gr0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BE984E412;
	Thu, 31 Oct 2013 14:11:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96DAB4E410;
	Thu, 31 Oct 2013 14:11:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CCC4B58A-4257-11E3-AFCF-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237140>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There's no mention of the 'origin' default, or the fact that the
> upstream tracking branch remote is used.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-fetch.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> index e08a028..7e75dc4 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -37,6 +37,9 @@ or from several repositories at once if <group> is given and
>  there is a remotes.<group> entry in the configuration file.
>  (See linkgit:git-config[1]).
>  
> +When no remote is specified, by the default the `origin` remote will be used,

I recall there were typofix comments on this line.

> +unless there's an upstream branch configured for the current branch.

Also there was a phrasing comment on this one, I think.

Resending without rerolling is not very much appreciated.


> +
>  OPTIONS
>  -------
>  include::fetch-options.txt[]
