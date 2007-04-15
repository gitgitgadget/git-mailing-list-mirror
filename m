From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Document -g (--walk-reflogs) option of git-log
Date: Sun, 15 Apr 2007 16:04:39 -0700
Message-ID: <7v3b312q9k.fsf@assigned-by-dhcp.cox.net>
References: <20070415223606.GB4417@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:04:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdDm0-0002yO-Fw
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbXDOXEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbXDOXEl
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:04:41 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59483 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbXDOXEl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:04:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415230441.LIGX1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 19:04:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id nb4f1W00p1kojtg0000000; Sun, 15 Apr 2007 19:04:40 -0400
In-Reply-To: <20070415223606.GB4417@steel.home> (Alex Riesen's message of
	"Mon, 16 Apr 2007 00:36:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44539>

Alex Riesen <raa.lkml@gmail.com> writes:

> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> Complained about on IRC. Thanks DrNick for proofreading and Gitster
> for patience.
>
>  Documentation/git-log.txt |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 030edaf..96e8a3f 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -46,6 +46,11 @@ include::pretty-formats.txt[]
>  -p::
>  	Show the change the commit introduces in a patch form.
>  
> +-g, \--walk-reflogs::
> +	Show commits as they were recorded in the reflog. The log contains
> +	a record about how the tip of a reference was changed.
> +	See also gitlink:git-ref-log[1].
> +
>
>  <paths>...::
>  	Show only commits that affect the specified paths.
>  
> -- 
> 1.5.1.1.819.gcfdd2

Thanks.  I'll fix this up with s/ref-log/reflog/.
