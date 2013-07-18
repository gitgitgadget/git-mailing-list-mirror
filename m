From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Documentation: remove --prune from pack-refs examples
Date: Thu, 18 Jul 2013 11:07:21 -0700
Message-ID: <7vehav3fom.fsf@alter.siamese.dyndns.org>
References: <0A7070DB-118A-44B2-A554-246459D0CEF3@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 20:07:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzsc6-00080I-AL
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 20:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933176Ab3GRSHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 14:07:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62234 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932619Ab3GRSHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 14:07:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BE7F31A98;
	Thu, 18 Jul 2013 18:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+uYB5secAU+xOWnbIJAKXNoO9nM=; b=MrrsuU
	fADBeT/A4OiLIVoYFJfwkF5qPPEeEL9JNwpax2sj19gQKnhD2HKU/BFg+smaO+kI
	cE6Xl2d04mkeYx8MAix371A1DDe4Z+gQf5DtoTgBVnkR0I2t4Ax29Gmh0MogAYzK
	6e5KPJZh3pAUu/wkQ1uls+E+sQm0Oq87seB4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YmIPolwosPPl1PC7LNm/gA9YFcfdH3kO
	/41FNFfyJTgRqDyF7Nsu4q0zxh8Vo7yhRUst7+yV4wyy2L63ZHlc5lDQbJTHMgbm
	pNIgq+4vfnD07AuBvdSCmUBDh8xdweJzvI1++TDxtvc8Ll/tCwmF3ML5CTzsdgyW
	OA0UJJAl4d4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9061D31A97;
	Thu, 18 Jul 2013 18:07:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2A7431A93;
	Thu, 18 Jul 2013 18:07:22 +0000 (UTC)
In-Reply-To: <0A7070DB-118A-44B2-A554-246459D0CEF3@JonathonMah.com> (Jonathon
	Mah's message of "Thu, 18 Jul 2013 09:53:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4F7459E-EFD4-11E2-B685-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230719>

Jonathon Mah <me@JonathonMah.com> writes:

> The option has been the default for a while, and doesn't otherwise
> appear in the page.
>
> Signed-off-by: Jonathon Mah <me@JonathonMah.com>
> ---
>
> Forgot sign-off in v1. Also, I was unsure whether to rewrap the
> lines (and if so, to how many columns); erred on the side of
> minimal changes.

Thanks.


>  Documentation/git-pack-refs.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
> index f131677..154081f 100644
> --- a/Documentation/git-pack-refs.txt
> +++ b/Documentation/git-pack-refs.txt
> @@ -33,8 +33,8 @@ Subsequent updates to branches always create new files under
>  `$GIT_DIR/refs` directory hierarchy.
>  
>  A recommended practice to deal with a repository with too many
> -refs is to pack its refs with `--all --prune` once, and
> -occasionally run `git pack-refs --prune`.  Tags are by
> +refs is to pack its refs with `--all` once, and
> +occasionally run `git pack-refs`.  Tags are by
>  definition stationary and are not expected to change.  Branch
>  heads will be packed with the initial `pack-refs --all`, but
>  only the currently active branch heads will become unpacked,
