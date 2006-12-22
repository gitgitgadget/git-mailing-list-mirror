From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-commit-tree: if i18n.commitencoding is utf-8
 (default), check it
Date: Fri, 22 Dec 2006 23:21:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612222320580.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
 <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612221030440.18171@xanadu.home> <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612222204010.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7ozwqf5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 23:21:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxsm3-0000YQ-Hl
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 23:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbWLVWVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 17:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbWLVWVx
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 17:21:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:49033 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753102AbWLVWVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 17:21:52 -0500
Received: (qmail invoked by alias); 22 Dec 2006 22:21:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 22 Dec 2006 23:21:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7ozwqf5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35235>

Hi,

On Fri, 22 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Now, git-commit-tree refuses to commit when i18n.commitencoding is
> > either unset, or set to "utf-8", and the commit message does not
> > minimally conform to the UTF-8 encoding.
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> >
> > 	Unfortunately, I could not think of a shorter oneline description. 
> > 	But my next patch fixes at least the output in shortlog.
> 
> I think the rule that you described on the one-line description
> makes more sense than "either unset of set to utf-8".  In other
> words, I'd prefer doing this in a repository that explicitly
> asks for it.

Well, the problem is this line:

environment.c:21:char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";

> I do not want to get burned by too many incompatible changes X-<.

Understandable.

Ciao,
Dscho
