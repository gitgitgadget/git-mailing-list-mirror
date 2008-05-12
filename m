From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] Make mktag a builtin.
Date: Mon, 12 May 2008 18:04:42 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805121803320.30431@racer>
References: <1210299589-10448-1-git-send-email-drafnel@example.com> <1210299589-10448-2-git-send-email-drafnel@example.com> <7689656.1210299528037.JavaMail.teamon@b301.teamon.com> <7v63tk6992.fsf@gitster.siamese.dyndns.org>
 <48285DAB.2040707@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon May 12 19:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvbT1-0003NQ-L5
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 19:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbYELREr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 13:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753986AbYELREr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 13:04:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:51023 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753960AbYELREq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 13:04:46 -0400
Received: (qmail invoked by alias); 12 May 2008 17:04:44 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp053) with SMTP; 12 May 2008 19:04:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187lHdwe8k7ULwhMnKa7+7jrqWrzvVYFAPhtPUHLY
	ZTaSxP52KfvAl2
X-X-Sender: gene099@racer
In-Reply-To: <48285DAB.2040707@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81880>

Hi,

On Mon, 12 May 2008, Brandon Casey wrote:

> Junio C Hamano wrote:
> > drafnel@gmail.com writes:
> > 
> >> From: Brandon Casey <drafnel@gmail.com>
> >>
> >> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> > 
> >> @@ -306,6 +305,7 @@ BUILT_INS += git-fsck-objects$X
> >>  BUILT_INS += git-get-tar-commit-id$X
> >>  BUILT_INS += git-init$X
> >>  BUILT_INS += git-merge-subtree$X
> >> +BUILT_INS += git-mktag$X
> >>  BUILT_INS += git-peek-remote$X
> >>  BUILT_INS += git-repo-config$X
> >>  BUILT_INS += git-show$X
> >> @@ -423,6 +423,7 @@ LIB_OBJS += log-tree.o
> >>  LIB_OBJS += mailmap.o
> >>  LIB_OBJS += match-trees.o
> >>  LIB_OBJS += merge-file.o
> >> +LIB_OBJS += mktag.o
> > 
> > This is unusual for a builtin.  Why didn't it migrate to builtin-mktag?
> 
> I didn't know how to do it.
> 
> I was trying not to do a code move and a code change at the same time.

Why did you not consult Git's own history for guidance?  See e.g.

	$ git log next --diff-filter=A builtin-*.c

Ciao,
Dscho
