From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] Documentation: git-init: flesh out example
Date: Tue, 05 Aug 2014 15:14:48 -0700
Message-ID: <xmqqegwuoa7b.fsf@gitster.dls.corp.google.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
	<1407002817-29221-8-git-send-email-linusarver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Arver <linusarver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 00:15:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEn0W-0000tO-Tz
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 00:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbaHEWO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 18:14:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64121 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322AbaHEWO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 18:14:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D45F2EEC9;
	Tue,  5 Aug 2014 18:14:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3pNBLpydQs4IygEu8fgnv3hRrcs=; b=A7AlTa
	uoXMocVBQDVv6w/BaroAOTxTRAuyBTCNYtYeryqULbEG/p+vRp/mPDPoKPBRF5Y6
	1Rcb/AJDUFMoerUsYTY4ZxeQbeiijOubWAvwvmtoceRIfM1s7A9VD1k2eLI1auTQ
	7AhEF5BLsrfXD5mfn3NeyChrWeE+owugWoO3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uFQXv+BOqbqNZek+XYQ1htLsLjjd22Sh
	m9AtOmxDoNig1rltr2GcyX3pEtZbSttqi9j5qvCgIGXr04EfndjF8ms0GXRhgSOB
	KE0Xyw4LlDIBBt7kFZj+Sn8Id41bv8V36zzjGZ6c+YUHV3dySu7+WlkIpaNrX0ld
	gsZHhqMGze4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 338D42EEC8;
	Tue,  5 Aug 2014 18:14:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7CFEC2EEBE;
	Tue,  5 Aug 2014 18:14:49 -0400 (EDT)
In-Reply-To: <1407002817-29221-8-git-send-email-linusarver@gmail.com> (Linus
	Arver's message of "Sat, 2 Aug 2014 11:06:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EA82F67E-1CED-11E4-A181-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254835>

Linus Arver <linusarver@gmail.com> writes:

> Signed-off-by: Linus Arver <linusarver@gmail.com>
> ---
>  Documentation/git-init.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index b94d165..16e9f9c 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -138,10 +138,12 @@ Start a new Git repository for an existing code base::
>  $ cd /path/to/my/codebase
>  $ git init      <1>
>  $ git add .     <2>
> +$ git commit    <3>

I agree it is a good discipline to make the initial "pristine"
import immediately after "git add ." without doing anything else.
Perhaps the description below wants to make it more explicit?

>  ----------------
>  +
> -<1> prepare /path/to/my/codebase/.git directory
> -<2> add all existing file to the index
> +<1> Create a /path/to/my/codebase/.git directory.
> +<2> Add all existing files to the index.
> +<3> Create the first root-commit.
>  
>  GIT
>  ---
