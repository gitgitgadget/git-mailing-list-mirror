From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 5/7] Documentation: elaborate on pushing tags
Date: Wed, 29 Oct 2008 16:40:16 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810291638120.19665@iabervon.org>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk> <1225311945-17100-2-git-send-email-mail@cup.kalibalik.dk> <1225311945-17100-3-git-send-email-mail@cup.kalibalik.dk> <1225311945-17100-4-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-5-git-send-email-mail@cup.kalibalik.dk> <1225311945-17100-6-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Wed Oct 29 21:41:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHrD-0002lw-KV
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbYJ2UkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 16:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbYJ2UkT
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:40:19 -0400
Received: from iabervon.org ([66.92.72.58]:52069 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbYJ2UkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 16:40:17 -0400
Received: (qmail 22384 invoked by uid 1000); 29 Oct 2008 20:40:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Oct 2008 20:40:16 -0000
In-Reply-To: <1225311945-17100-6-git-send-email-mail@cup.kalibalik.dk>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99412>

On Wed, 29 Oct 2008, Anders Melchiorsen wrote:

> Make the description of pushing tags easier to read, but move the
> shorthand notation towards the end of the description. This gives
> a better flow.
> 
> Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
> ---
>  Documentation/git-push.txt |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 9788d49..52035db 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -38,7 +38,7 @@ OPTIONS
>  	by the source ref, followed by a colon `:`, followed by
>  	the destination ref.
>  +
> -The <src> side represents the source branch that you
> +The <src> side represents the source branch or tag that you
>  want to push.  The <dst> side represents the destination location.
>  +
>  The local ref that matches <src> is used
> @@ -46,8 +46,6 @@ to fast forward the remote ref that matches <dst>.  If
>  the optional leading plus `+` is used, the remote ref is updated
>  even if it does not result in a fast forward update.
>  +
> -`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
> -+
>  A parameter <ref> without a colon pushes the <ref> from the source
>  repository to the destination repository under the same name.
>  +
> @@ -64,6 +62,10 @@ nor in any Push line of the corresponding remotes file---see below).
>  The <src> can be an arbitrary "SHA1 expression", such as `HEAD`
>  or `master~4` (see linkgit:git-rev-parse[1]). In this case, a
>  <dst> location has to be named.
> ++
> +When pushing tags, `tag <tag>` can be used as a shorthand for
> +`refs/tags/<tag>:refs/tags/<tag>`. This should be specified as
> +two arguments (that is, without quotes in the shell).

I think this should be "When pushing a tag, ...", to avoid confusion with 
"--tags", which pushes (all) tags and doesn't need the "tag <tag>" 
arguments.

	-Daniel
*This .sig left intentionally blank*
