From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and
 --prune-empty.
Date: Sun, 11 Jan 2009 14:35:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901111433580.3586@pacific.mpi-cbg.de>
References: <20081030132623.GC24098@artemis.corp> <1225445204-28000-1-git-send-email-madcoder@debian.org> <7viqr5wgl7.fsf@gitster.siamese.dyndns.org> <20081103092729.GE13930@artemis.corp> <20081103151826.GJ13930@artemis.corp> <76718490901091129q534ca981iac54e0653d76170d@mail.gmail.com>
 <20090111111800.GA8032@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pasky@suse.cz, srabbelier@gmail.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Jan 11 14:36:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM0UJ-0006YM-1R
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 14:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313AbZAKNee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 08:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754290AbZAKNed
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 08:34:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:43353 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753976AbZAKNec (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 08:34:32 -0500
Received: (qmail invoked by alias); 11 Jan 2009 13:34:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 11 Jan 2009 14:34:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191aQdASNR1sc36peuw339ku5OqQsTwwppIApxnPU
	tNIGRqUQxoGuYc
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090111111800.GA8032@artemis.corp>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105180>

Hi,

On Sun, 11 Jan 2009, Pierre Habouzit wrote:

> On Fri, Jan 09, 2009 at 07:29:15PM +0000, Jay Soffian wrote:
> > On Mon, Nov 3, 2008 at 10:18 AM, Pierre Habouzit <madcoder@debian.org> wrote:
> > > On Mon, Nov 03, 2008 at 09:27:29AM +0000, Pierre Habouzit wrote:
> > >> On Mon, Nov 03, 2008 at 04:58:44AM +0000, Junio C Hamano wrote:
> > 
> > Bump, http://thread.gmane.org/gmane.comp.version-control.git/99440/
> > 
> > (I'd like to see this included. Having a bunch of empty commits after
> > using filter-branch to remove unwanted files from history is, er,
> > sub-optimal, so seems like it might even be default behavior?)
> 
> Yeah I have that in my own git tree, and I meant to ask if something had 
> to be fixed for it to be accepted for some time, but always forget about 
> it.
> 
> Junio, do you think this could be accepted, or does it need some work ?

AFAICT Junio had some style issues which were not addressed.

And I suggested to merge the tests with Sverre's patch.  That suggestion 
also went unaddressed.

Ciao,
Dscho
