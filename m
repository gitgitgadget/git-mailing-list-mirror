From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 15:37:47 +0200
Message-ID: <20060608133747.GA15374@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de> <44880BE8.40804@etek.chalmers.se> <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 15:38:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoKi7-00069Z-8R
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 15:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWFHNiE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Jun 2006 09:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWFHNiE
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 09:38:04 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:33031 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S964830AbWFHNiC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 09:38:02 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FoKhn-00041G-00; Thu, 08 Jun 2006 14:37:47 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21489>

On 2006-06-08 13:41:04 +0200, Johannes Schindelin wrote:

> On Thu, 8 Jun 2006, Lukas Sandstr=F6m wrote:
>
> > Johannes Schindelin wrote:
> > > Since there is a global config now, we need a way to access it
> > > conveniently. Now you can say
> > >
> > >   git repo-config --no-local alias.l "log --stat -M ORIG_HEAD.."
> > >
> > > to set the alias globally (it will be stored in ~/.gitconfig).
> > >
> >
> > Wouldn't it make more sense to call the flag --global ?
>
> Sure, why not? Other opinions? (I will not add a test case until
> this is resolved! ;-)

My vote goes to --no-local, but only if we also get a --no-no-local
flag with the opposite meaning. Otherwise, I'd prefer --global. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
