From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix install-doc-quick target
Date: Sun, 5 Aug 2007 19:10:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051909300.14781@racer.site>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site>
 <46B4A2B0.9080208@gmail.com> <Pine.LNX.4.64.0708041704040.14781@racer.site>
 <46B4A5FD.3070107@gmail.com> <Pine.LNX.4.64.0708041719490.14781@racer.site>
 <46B4BDCF.9060809@gmail.com> <Pine.LNX.4.64.0708042229130.14781@racer.site>
 <46B4F91D.1070907@lsrfire.ath.cx> <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0708051344430.14781@racer.site> <7vzm15eukf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 20:11:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHkZQ-0001jM-8I
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 20:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbXHESLA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 14:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755395AbXHESLA
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 14:11:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:32852 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755104AbXHESK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 14:10:59 -0400
Received: (qmail invoked by alias); 05 Aug 2007 18:10:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 05 Aug 2007 20:10:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mK+cxBFvm+9dED+r7OPunvBJRwNWwC2lQPtGlQ1
	X+zLuQYj6/dnuw
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzm15eukf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55050>

Hi,

On Sun, 5 Aug 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I do not like the behaviour "be stupid and assume cwd to be the working 
> > tree root, if GIT_DIR is set and GIT_WORK_TREE is not".
> >
> > It bears _all_ kind of stupid connotations.  Just imagine what would 
> > happen with "git --git-dir=. add .".
> >
> > IMHO the new behaviour is _better_, since you can not shoot yourself in 
> > the foot so easily.  Being able to safeguard against doing a work tree 
> > operation inside the git directory is a direct and elegant consequence of 
> > defaulting to $GIT_DIR/.. in case $GIT_DIR ends in "/.git", and no work 
> > tree if $GIT_DIR does _not_ end in "/.git".
> >
> > The semantics "if GIT_DIR is set, just assume the cwd to be the work tree 
> > root unilaterally" is _broken_ as far as I am concerned.
> 
> I am not disputing that.  I was just pointing out that this is a
> change in semantics and we need to advertise it as such, and
> more importantly, advise people how to adjust to the new (and
> improved) world order.

Thanks.  I will prepare a patch to ReleaseNotes, but that'll have to wait 
until tomorrow.  I'm pretty exhausted after the last night of msysGit 
hacking.

Ciao,
Dscho
