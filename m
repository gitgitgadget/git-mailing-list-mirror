From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase: don't invoke the pager for each commit summary
Date: Sat, 30 Jan 2010 17:47:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001301746200.4985@pacific.mpi-cbg.de>
References: <1264868617-18547-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephen Boyd <bebarino@gmail.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 30 17:41:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbGNo-0002zG-FK
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 17:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab0A3QlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 11:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754201Ab0A3QlK
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 11:41:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:59980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751592Ab0A3QlI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 11:41:08 -0500
Received: (qmail invoked by alias); 30 Jan 2010 16:41:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 30 Jan 2010 17:41:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/w1FJhf1PwGEnn1GmJZ052kt54Fm+4Tu+Q2SpSOk
	VjJLK9hrnlCxOJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1264868617-18547-1-git-send-email-markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138481>

Hi,

On Sat, 30 Jan 2010, Markus Heidelberg wrote:

> diff --git a/git-rebase.sh b/git-rebase.sh
> index b5d9178..fb4fef7 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -86,7 +86,7 @@ continue_merge () {
>  		fi
>  	fi
>  	test -z "$GIT_QUIET" &&
> -	git log --format=%s -1 "$cmt"
> +	GIT_PAGER='' git log --format=%s -1 "$cmt"

Would it not be better 'git --no-pager log [...]'?

Ciao,
Dscho
