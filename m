From: Alp Toker <alp@atoker.com>
Subject: Re: [PATCH] Documentation: Fix ssh:// URLs in generated documentation
Date: Thu, 13 Jul 2006 06:48:58 +0100
Message-ID: <44B5DECA.8040401@atoker.com>
References: <11527413212127-git-send-email-alp@atoker.com> <7vpsgaw16d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 07:49:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0u4T-0002ZX-8X
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 07:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWGMFtF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 01:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWGMFtF
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 01:49:05 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:780 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1751442AbWGMFtE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 01:49:04 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by ndesk.org (Postfix) with ESMTP id 87F33172B92;
	Thu, 13 Jul 2006 06:48:58 +0100 (BST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsgaw16d.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23818>

Junio C Hamano wrote:
> I wonder if this is with less formatting impact then.
> 
> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index 9abec80..93378d2 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -10,9 +10,9 @@ to name the remote repository:
>  - https://host.xz/path/to/repo.git/
>  - git://host.xz/path/to/repo.git/
>  - git://host.xz/~user/path/to/repo.git/
> -- ssh://[user@]host.xz/path/to/repo.git/
> -- ssh://[user@]host.xz/~user/path/to/repo.git/
> -- ssh://[user@]host.xz/~/path/to/repo.git
> +- ssh://+++[user@+++]host.xz/path/to/repo.git/
> +- ssh://+++[user@+++]host.xz/~user/path/to/repo.git/
> +- ssh://+++[user@+++]host.xz/~/path/to/repo.git
>  ===============================================================
>  
>  SSH Is the default transport protocol and also supports an

Your call. I almost went that way but decided the more invasive patch 
left the source a bit more readable as it didn't need escaping. As long 
as the output gets fixed, nobody will be losing sleep over this one.
