From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Integrating gitweb and git-browser (was: Re: VCS comparison table)
Date: Wed, 18 Oct 2006 03:36:36 +0200
Organization: At home
Message-ID: <eh40e1$9g1$1@sea.gmane.org>
References: <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> <vpqbqob5euu.fsf@ecrins.imag.fr> <BAYC1-PASMTP10E107E5EB0F7E69167F41AE0E0@CEZ.ICE> <vpqejt73vln.fsf@ecrins.imag.fr> <BAYC1-PASMTP10F617306F1477E66FA441AE0E0@CEZ.ICE> <vpqlknf10u5.fsf@ecrins.imag.fr> <20061017110655.f7bcf3f1.seanlkml@sympatico.ca> <20061018001455.GI20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Oct 18 03:36:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga0Lv-0001xL-W6
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 03:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWJRBgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 21:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWJRBgJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 21:36:09 -0400
Received: from main.gmane.org ([80.91.229.2]:24997 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751100AbWJRBgI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 21:36:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ga0Ln-0001w4-85
	for git@vger.kernel.org; Wed, 18 Oct 2006 03:36:07 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 03:36:07 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 03:36:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29171>

Petr Baudis wrote:

> BTW, I'm thinking about implementing some plugin functionality for
> gitweb 

Features support is kind of plugin system for gitweb. But certainly we could
split gitweb into modules.

> so that you can add your own views, so that git-browser can 
> integrate to it more reasonably. (Currently it has completely different
> UI and you have to patch gitweb in order to get the proper links at
> proper places.) Sure, git-browser might get fully integrated to gitweb
> later but that needs to be done sensitively so that people are not
> scared by the horrible javascript blobs, etc.; currently git-browser is
> very experimental, and adding it would be quite intrusive.

I was thinking about adding using JavaScript, in shortlog (and perhaps
shortlog-extended, i.e. with date and author) views one extra "diagram"
column, with width set using JavaScript generated embedded style, and use
only part of git-browser that generates diagram to draw it there.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
