From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What will happen to git.git in the near future
Date: Sun, 24 Sep 2006 20:33:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609242031410.25371@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net> <4516B8A7.6010007@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 20:33:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRYnJ-00017m-KL
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 20:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbWIXSdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 14:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbWIXSdf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 14:33:35 -0400
Received: from mail.gmx.de ([213.165.64.20]:7903 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752134AbWIXSde (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 14:33:34 -0400
Received: (qmail invoked by alias); 24 Sep 2006 18:33:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 24 Sep 2006 20:33:32 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <4516B8A7.6010007@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27687>

Hi,

On Sun, 24 Sep 2006, Rene Scharfe wrote:

> Junio C Hamano schrieb:
> >  - We should deprecate git-tar-tree.  However, it has been
> >    around and advertised for quite some time, so we need to make
> >    sure people would not get burned too badly.  It might be
> >    worthwhile to rewrite git-tar-tree as a thin wrapper to
> >    "git-archive --format=tar" and remove git-upload-tar now (in
> >    other words, "git-tar-tree --remote" will continue to work,
> >    but it will talk with "git-upload-archive", not with
> >    "git-upload-tar" on the other end), release 1.4.3 with it
> >    with a deprecation warning, and then remove it in 1.4.5.
> 
> Hmm.  The local case in git-tar-tree is already a thin wrapper.
> How about something like this shell script as a replacement for
> the entire command?

I think that this could be done very efficiently (both in terms of time 
and size) as a "pure" builtin, i.e. something with works as
"git tar-tree", but not as "git-tar-tree". Of course, this would break 
scripts using the latter instead of the former. Just my 2 yinyangs.

Ciao,
Dscho
