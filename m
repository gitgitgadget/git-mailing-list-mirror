From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] status: document the -v/--verbose option
Date: Thu, 23 Apr 2015 11:26:31 -0700
Message-ID: <xmqqvbgm3dm0.fsf@gitster.dls.corp.google.com>
References: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
	<1429792070-22991-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:26:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlLpe-0001A9-Um
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 20:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbbDWS0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 14:26:34 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030406AbbDWS0d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 14:26:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 008154B522;
	Thu, 23 Apr 2015 14:26:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZXjzzCwLtb2l6MnevXVMYGr1PdI=; b=kT1l6S
	vghKh6DzPK8oQF9IWBLn2iIF6eww+k4+Mttuf0Wnnyw4d23C3qlcZxb2u4YQrYrA
	NdlPx3ZdiQB5tJttz0PhbMWQkdx/75wPMinxyd0B7xXIB6nMxaIBnlx8GCz5+/HJ
	kv8dlTCEACv/8BU1+d3sCmKJj6MGzV/smQOWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ed9AQKcaKDh81JT9osYOb4Utn4PVkKUT
	o8PI/hpLyqGOJ3J8kG7wOdFop06tHeR8ydJBvJdRHfMV0gAeOllMoUzQeE7gI7FI
	7IHwLAMiuzR0/GnKH0us2Msqu+96264T7+oPCLd8V6vxhEk/MmRCmoEx63pezT8z
	ZGodS0L+0Nk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED8EB4B521;
	Thu, 23 Apr 2015 14:26:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 695044B520;
	Thu, 23 Apr 2015 14:26:32 -0400 (EDT)
In-Reply-To: <1429792070-22991-2-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Thu, 23 Apr 2015 14:27:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 443B59AC-E9E6-11E4-8202-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267698>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Document `git status -v`, including its new doubled `-vv` form.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Will queue on mg/status-v-v series, which did add description for
"commit -v", but "status -v" did not have the description to begin
with and we missed it.

Thanks.

>  Documentation/git-status.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index b3319f7..9ec5897 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -41,6 +41,15 @@ OPTIONS
>  --long::
>  	Give the output in the long-format. This is the default.
>  
> +-v::
> +--verbose::
> +	In addition to the names of files that have been changed, also
> +	show the textual changes that are staged to be committed
> +	(i.e., like the output of `git diff`). If `-v` is specified
> +	twice, then also show the changes in the working tree that
> +	have not yet been staged (i.e., like the output of `git diff
> +	--cached`).
> +
>  -u[<mode>]::
>  --untracked-files[=<mode>]::
>  	Show untracked files.
