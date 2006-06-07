From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Document git aliases support
Date: Wed, 07 Jun 2006 11:58:57 -0700
Message-ID: <7vzmgog5ce.fsf@assigned-by-dhcp.cox.net>
References: <20060607184350.31338.46653.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 07 20:59:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo3F9-0001I2-RK
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 20:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWFGS67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 14:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWFGS67
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 14:58:59 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:17808 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932355AbWFGS67 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 14:58:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060607185858.EGEG19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Jun 2006 14:58:58 -0400
To: git@vger.kernel.org
In-Reply-To: <20060607184350.31338.46653.stgit@machine.or.cz> (Petr Baudis's
	message of "Wed, 07 Jun 2006 20:43:50 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21454>

Petr Baudis <pasky@suse.cz> writes:

>  Documentation/config.txt |    7 +++++++
>  Documentation/git.txt    |    3 +++
>  2 files changed, 10 insertions(+), 0 deletions(-)

Thanks.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c861c6c..ad9ec3e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -91,6 +91,13 @@ core.warnAmbiguousRefs::
>  	If true, git will warn you if the ref name you passed it is ambiguous
>  	and might match multiple refs in the .git/refs/ tree. True by default.
>  
> +alias.*::
> +	Command aliases for the gitlink:git[1] command wrapper - e.g.
> +	after defining "alias.last = cat-file commit HEAD", the invocation
> +	"git last" is equivalent to "git cat-file commit HEAD". You cannot
> +	override even existing command names with aliases. Arguments are
> +	split by spaces, the usual shell quoting and escaping is supported.
> +

"even"?  How about: "alias that hides existing command names are
not used to avoid confusion"?
