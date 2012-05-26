From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
	~/.gitconfig
Date: Sat, 26 May 2012 12:59:37 +0200
Message-ID: <20120526105936.GA37540@book.hvoigt.net>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr> <CAMP44s32GKrmXDND3_iO6CTOgHTfeuBeXYEOjcET5bBZ067pFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 13:06:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYEoo-0004xL-Cz
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 13:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615Ab2EZLFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 07:05:53 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:54720 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab2EZLFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 07:05:52 -0400
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 May 2012 07:05:52 EDT
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1SYEie-0002x4-Q1; Sat, 26 May 2012 12:59:36 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s32GKrmXDND3_iO6CTOgHTfeuBeXYEOjcET5bBZ067pFQ@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198552>

Hi,

On Sat, May 26, 2012 at 12:45:52PM +0200, Felipe Contreras wrote:
> On Fri, May 25, 2012 at 6:15 PM,  <nguyenhu@minatec.inpg.fr> wrote:
> 
> > As you know, git stores its configuration in ~/.gitconfig file and in other
> > hidden files at the root of the user's directory.
> >
> > We would like to have a configuration directory instead of all these
> > configuration files by following the XDG specification because:
> > - not a lot of hidden files at the root, so better view
> > - one directory per software in ~/.config
> >
> > We would like to give to users the possibility to store configuration in
> > ~/.config/git/config file.
> 
> I like this, but it shouldn't be "~/.config", it should be $XDG_CONFIG_HOME.

If we do that what about a fallback to .config for operating systems
that do not have XDG? E.g. Git for Windows would then also be able to
benefit from that.

Cheers Heiko
