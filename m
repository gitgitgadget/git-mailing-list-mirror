From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: What's cooking in git.git (Oct 2011, #03; Fri, 7)
Date: Mon, 10 Oct 2011 22:16:29 +0200
Message-ID: <20111010201629.GB5981@sandbox-rc>
References: <7vsjn4tukt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Brad King <brad.king@kitware.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 22:16:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDMH7-000320-Ea
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 22:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490Ab1JJUQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 16:16:32 -0400
Received: from darksea.de ([83.133.111.250]:42765 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751776Ab1JJUQb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 16:16:31 -0400
Received: (qmail 29326 invoked from network); 10 Oct 2011 22:16:29 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 10 Oct 2011 22:16:29 +0200
Content-Disposition: inline
In-Reply-To: <7vsjn4tukt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183253>

Hi Junio,

sorry for the late reply I was taking some time off from email. Here now
some information on the two topics I am involved with that got stalled:

On Fri, Oct 07, 2011 at 01:28:34PM -0700, Junio C Hamano wrote:
> --------------------------------------------------
> [Stalled]
> 
> * hv/submodule-merge-search (2011-08-26) 5 commits
>  - submodule: Search for merges only at end of recursive merge
>  - allow multiple calls to submodule merge search for the same path
>  - submodule: Demonstrate known breakage during recursive merge

The three patches above belong to the merge-search fix topic. I think
they should be good to go.

>  - push: Don't push a repository with unpushed submodules
>  - push: teach --recurse-submodules the on-demand option
>  (this branch is tangled with fg/submodule-auto-push.)

These two belong into the fg/submodule-auto-push topic. It seems they
got mixed into this while dicussing the two topics.

> The second from the bottom one needs to be replaced with a properly
> written commit log message.

I will look into that.

> * fg/submodule-auto-push (2011-09-11) 2 commits
>  - submodule.c: make two functions static
>  - push: teach --recurse-submodules the on-demand option
>  (this branch is tangled with hv/submodule-merge-search.)
> 
> What the topic aims to achieve may make sense, but the implementation
> looked somewhat suboptimal.

We will also have a look at the final cleanups we need here. (Fredrik?)

Cheers Heiko
