From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: make usage match manual page
Date: Mon, 11 Mar 2013 12:58:41 -0700
Message-ID: <7vli9t909a.fsf@alter.siamese.dyndns.org>
References: <1363031055-13562-1-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Mar 11 20:59:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF8sJ-0004wA-7v
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 20:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183Ab3CKT6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 15:58:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46897 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942Ab3CKT6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 15:58:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72F23AA14;
	Mon, 11 Mar 2013 15:58:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kHciyhQJGs4nSxQCPpqUnlH6ZVo=; b=dqPfA+
	cMz5Ow2v/r3T6Pz95eFCc6bWoeyWYLYg0dYqiXRBojrN7XvdjKN39p38/CML3reS
	kf5DbbdlRkA0BDl2swjdPhvCoip63TILNDH+6QaMUVG4iQM6hPK74jgS8je+7X8j
	05sGJtNraWmV4JFC1UL1vrPVnwFxpLLuB04hw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lEJokLl8k8cEpX7sgyjjRZqIYbe/omfh
	VfAFB6kYpxu+OsMXGl2rHMBMAn15UnEpBUUamJN+nAzdC99R0h+jbJWaPLHXE4H5
	DD1ae1wk/YF+6Vf3zh5pkVyyomeijSujskcomXkYER75WYhU0/BBCrUVU+Zf9kCp
	liBnFNSJ3X4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65EF5AA13;
	Mon, 11 Mar 2013 15:58:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCA77AA12; Mon, 11 Mar 2013
 15:58:42 -0400 (EDT)
In-Reply-To: <1363031055-13562-1-git-send-email-kevin@bracey.fi> (Kevin
 Bracey's message of "Mon, 11 Mar 2013 21:44:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1354D8DE-8A86-11E2-86D9-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217905>

Kevin Bracey <kevin@bracey.fi> writes:

> Re-ordered option list in command-line usage to match the manual page.
> Also makes it less than 80-characters wide.

Thanks (s/Re-ordered/reorder/ and s/makes/make/, though).

Is git.c the only one whose "-h" output does not match the manual
synopsis?

>
> Signed-off-by: Kevin Bracey <kevin@bracey.fi>
> ---
>  git.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git.c b/git.c
> index d33f9b3..2a98624 100644
> --- a/git.c
> +++ b/git.c
> @@ -6,10 +6,10 @@
>  #include "run-command.h"
>  
>  const char git_usage_string[] =
> -	"git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
> +	"git [--version] [--help] [-c name=value]\n"
> +	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
>  	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
>  	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
> -	"           [-c name=value] [--help]\n"
>  	"           <command> [<args>]";
>  
>  const char git_more_info_string[] =
