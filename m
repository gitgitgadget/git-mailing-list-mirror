From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Oct 2009, #01; Wed, 07)
Date: Thu, 29 Oct 2009 11:54:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910291151330.3687@felix-maschine>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910080848380.4985@pacific.mpi-cbg.de>  <fabb9a1e0910072349q68d6756cgebb041a0bbe2ba65@mail.gmail.com>  <20091008173900.GI9261@spearce.org> <fabb9a1e0910081058m59527600o392a6b438b18512e@mail.gmail.com>
 <fabb9a1e0910281508m3e9bb8a6g7b39abc29fceae78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	vcs-fast-import-devs@lists.launchpad.net
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 11:54:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3SeS-0001UV-Rd
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 11:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977AbZJ2Kye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 06:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753955AbZJ2Kye
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 06:54:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:40941 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753635AbZJ2Kyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 06:54:33 -0400
Received: (qmail invoked by alias); 29 Oct 2009 10:54:36 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO felix-maschine.local) [141.5.11.5]
  by mail.gmx.net (mp047) with SMTP; 29 Oct 2009 11:54:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19O9HdmO8hO6JVd0rvUvV81q1W0JLW6hZd1eFJ+BN
	L+R1Zaj4HJkPEe
X-X-Sender: johannes@felix-maschine
In-Reply-To: <fabb9a1e0910281508m3e9bb8a6g7b39abc29fceae78@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131581>

Hi,

On Wed, 28 Oct 2009, Sverre Rabbelier wrote:

> On Thu, Oct 8, 2009 at 10:58, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> > I think it makes to ignore options that are not for our vcs, as long 
> > as options that change import behavior (such as marks, date-format) 
> > are combined with, say, 'feature tool=git'. This way we can be sure 
> > that when outputting out a vcs specific stream, it is only parsed by 
> > that vcs.
> >
> > Note: yes, I know that marks and date-format are features now, but
> > there's really no other suitable example that I could think of).
> >
> > vcs fast import devs please ack this idea (and perhaps suggest
> > something other than "feature tool=git" if preferable) so that I can
> > reroll my gfi-options series :).
> 
> Shawn, what do you want to do with this, it seems the vcs devs are not
> very interested in this feature, should I implement it as described
> above? That is:
>   * If you use any option that is stream-changing you should include
>     "feature tool=git" in your stream
>   * import-marks and export-marks are made into features
>   * "option vcs" is ignored if vcs is a different vcs
>   * "option vcs" must be recognised if vcs is this vcs

It would be quite nice if this issue moved forward for a change.

As a consequence of it moving forward, I could nudge Sverre into 
continuing with his git-remote-hg work that will allow me to work 
transparently on a Mercurial repository using Git.

Transparent as in "no hassles".

It also will serve nicely as a perfect excuse to fix some design mistakes 
in the foreign vcs stuff.

Ciao,
Dscho
