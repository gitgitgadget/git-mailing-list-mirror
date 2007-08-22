From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: empty directories
Date: Thu, 23 Aug 2007 01:40:30 +0200
Organization: At home
Message-ID: <faihgf$hg6$1@sea.gmane.org>
References: <1187716461.5986.71.camel@beauty> <20070821134030.b763e9d3.seanlkml@sympatico.ca> <1187817948.5986.159.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 01:40:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INzoQ-0004Vg-4s
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 01:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764248AbXHVXkb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 19:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764192AbXHVXka
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 19:40:30 -0400
Received: from main.gmane.org ([80.91.229.2]:48118 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764181AbXHVXka (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 19:40:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INzo6-0006z7-HH
	for git@vger.kernel.org; Thu, 23 Aug 2007 01:40:14 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 01:40:14 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 01:40:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56437>

[Cc: Josh England <jjengla@sandia.gov>, git@vger.kernel.org]

Josh England wrote:

> [...]  The main need is for file
> ownership/permission, which has been touched on before.  When I clone
> an image, I really want an *identical* clone, in every way.  It seems
> as though git had this functionality but scrapped it due to issues with
> umask and merge type problems?  So the question is:  would there be any
> way to bring this functionality back as a non-default configurable
> option?  For those of us who need the functionality, we'd be more than
> willing to live with some of the side-effects.
> 
> The alternatives (involving wrappers and strict policy) just haven't
> been idiot-proof enough to be truly viable.  It almost has to be a
> built-in capability.  It looks like Nax is doing something close to
> this.  Is there anyone else using trying to use git in a similar way?

Check out (via e.g. http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
wiki page) IsiSetup which is tool to manage configuration files (including
permissions) which uses git as engine, and metastore which is meant as
tool to use in appropriate hook for storing/restoring permissions etc.

And as Linus told you, if you have time to work on it, you can try to
make .gitattributes work for this...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
