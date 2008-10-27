From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Terminology question: "tracking" branches
Date: Mon, 27 Oct 2008 19:44:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810271654530.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com>
 <48FDA5A0.8030506@drmicha.warpmail.net> <48FDF28A.9060606@xiplink.com> <48FF3FEE.8020209@drmicha.warpmail.net> <20081022161302.GC16946@atjola.homenet> <490030AB.8090207@drmicha.warpmail.net> <4905E1B0.8040601@xiplink.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 19:39:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuWzG-0006Qx-V6
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 19:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbYJ0Shd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 14:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbYJ0Shc
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 14:37:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:56119 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751449AbYJ0Shc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 14:37:32 -0400
Received: (qmail invoked by alias); 27 Oct 2008 18:37:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 27 Oct 2008 19:37:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1oO0yZ+O1zAa1jb81mTVbgUZANN0AFCFdLCLc7+
	SHGzB5dxEQpXnM
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <4905E1B0.8040601@xiplink.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99248>

Hi,

On Mon, 27 Oct 2008, Marc Branchaud wrote:

> Michael J Gruber wrote:
> > 
> > [adjective to be found] branch: A local branch which is set up to pull 
> > or rebase automatically from a tracking branch. Used for local 
> > modifications to remote branches. [I'm tempted to use local tracking 
> > branch here, but that would just add to the confusion.]
> 
> I say there's no need for an adjective here, as this is just a plain old
> branch that git-branch creates by default (right?).

I agree; I do not think that you need an adjective here.

I'd also recommend thinking about the branches as "local" and "remote".  
Not anything with "tracking" or "trailing" or somesuch.  When you really 
look at it from the non-technical view point, even the branches you have 
in refs/remotes/*/ are the remote branches; the fact that you have a local 
cached version of them is just a minor implementation detail.

And as to the "--track" thing?  I'd not make that big a deal out of it.  
At most, I'd say that a certain local branch happens to follow a certain 
remote branch, but that can change over time, right?  (Just change 
branch.<name>.merge...)

Ciao,
Dscho
