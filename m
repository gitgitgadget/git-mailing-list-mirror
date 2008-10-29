From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git bisect view's use of DISPLAY environment variable in
 Cygwin
Date: Wed, 29 Oct 2008 01:46:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810290144450.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <83wsfs1y6v.fsf@kalahari.s2.org> <c07716ae0810281015s47741fdqec4c3bed3313bb6a@mail.gmail.com> <83skqg1uc9.fsf@kalahari.s2.org> <c07716ae0810281213k432d82d8i468f54ae03146b88@mail.gmail.com> <83iqrccpmk.fsf@kalahari.s2.org>
 <83ej20cndw.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Wed Oct 29 01:40:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kuz6n-0000en-TD
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 01:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbYJ2AjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 20:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbYJ2AjJ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 20:39:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:35845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753339AbYJ2AjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 20:39:08 -0400
Received: (qmail invoked by alias); 29 Oct 2008 00:39:06 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 29 Oct 2008 01:39:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ydm9ZEegyMmn1O9VuoKvkPwobKSV6As02ISsAPP
	rlC2eoDYqU84ig
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <83ej20cndw.fsf@kalahari.s2.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99337>

Hi,

On Wed, 29 Oct 2008, Hannu Koivisto wrote:

> Hannu Koivisto <azure@iki.fi> writes:
> 
> > "Christian Couder" <christian.couder@gmail.com> writes:
> >
> >> On Tue, Oct 28, 2008 at 6:51 PM, Hannu Koivisto <azure@iki.fi> wrote:
> >>> "Christian Couder" <christian.couder@gmail.com> writes:
> >
> >> We need at least a way to detect we are under Cygwin, because we 
> >> won't change the current behavior for all platforms. Is checking for 
> >> the CYGWIN environment variable enough?
> >
> > No, because it may not be set.  I would probably do it at compile time 
> > using __CYGWIN__ definition.  I don't know what's the status
> 
> Argh, I didn't realize git-bisect is a shell script.  For detecting 
> Cygwin in shell scripts I have tested if `uname` matches CYGWIN*. For 
> detecting Windows I have tested if PROCESSOR_ARCHITECTURE is set.  
> There may well be better ways.

I submitted a patch a while ago, saying

	bisect view: call gitk if Cygwin's SESSIONNAME variable is set

See 
http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=a2637a3a003646c69ab5a6b85f0ee1bfac15e0b0

Ciao,
Dscho
