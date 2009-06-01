From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (May 2009, #04; Sun, 31)
Date: Mon, 01 Jun 2009 11:05:16 -0500
Message-ID: <iHgBjpVVWguPJEPP4Ongi5IDGr3NDPAyUgAg5Ticr0KHPFiQTrqgpg@cipher.nrlssc.navy.mil>
References: <7v63fgpwyd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 18:05:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBA1D-0002Ws-Of
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 18:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbZFAQFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 12:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbZFAQFh
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 12:05:37 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56746 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbZFAQFh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 12:05:37 -0400
Received: by mail.nrlssc.navy.mil id n51G5HlE006151; Mon, 1 Jun 2009 11:05:17 -0500
In-Reply-To: <7v63fgpwyd.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 01 Jun 2009 16:05:17.0715 (UTC) FILETIME=[C1AD7630:01C9E2D2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120474>

Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
> marked with '.' do not appear in any of the branches, but I am still
> holding onto them.
> 
> The topics list the commits in reverse chronological order.  The topics
> meant to be merged to the maintenance series have "maint-" in their names.
> 
> ----------------------------------------------------------------
> [New Topics]
> 
> All of these are soon to be in 'next'.
> 
> * bc/solaris (Wed May 27 21:17:08 2009 -0500) 4 commits
>  - Makefile: introduce SANE_TOOL_PATH for prepending required
>    elements to PATH
>  - Makefile: add section for SunOS 5.7
>  - Makefile: add NEEDS_RESOLV to optionally add -lresolv to compile
>    arguments
>  - Makefile: use /usr/ucb/install on SunOS platforms rather than
>    ginstall

If you haven't already merged this to 'next', then give me some time
and I'll resubmit a new series based on the feedback from you and
Jeff.

Jeff pointed out that HSTRERROR only has any effect when NO_IPV6 is
set.  So, NEEDS_RESOLV is really only necessary on Solaris versions
which must set NO_IPV6.

You suggested changes to git-compat-util.h for handling compiling on
Solaris with/without c99 compiler.

The bottom patch that switches to /usr/ucb/install is fine as-is.

If the series is already applied, no big deal, I'll just work on top of that.

-brandon
