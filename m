From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: How to embed a hash, tag or branch name?
Date: Fri, 31 Jul 2009 12:52:38 +0300
Message-ID: <20090731095238.GG29909@nalle>
References: <20090731081723.GE29909@nalle> <m3ljm5ryar.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 11:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWorh-0006G1-Pe
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 11:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbZGaJ5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 05:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbZGaJ5W
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 05:57:22 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:48162 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbZGaJ5W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 05:57:22 -0400
Received: from nalle.dyndns.tv (84.251.89.185) by kirsi1.inet.fi (8.5.014)
        id 49F6055A033146A1; Fri, 31 Jul 2009 12:57:21 +0300
Received: from mcfrisk by nalle.dyndns.tv with local (Exim 4.63)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1MWon0-0007t3-VH; Fri, 31 Jul 2009 12:52:39 +0300
Content-Disposition: inline
In-Reply-To: <m3ljm5ryar.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124520>

On Fri, Jul 31, 2009 at 02:27:50AM -0700, Jakub Narebski wrote:
> You can embed SHA-1 of a _file contents_ (blob) using '$Id: $' keyword
> with `ident` attribute - see gitattributes manpage.

Great, thanks!

> The correct solution of embedding version number is to do it at 
> _build time_, using e.g. script similar to GIT-VERSION-GEN used by
> Git itself and by Linux kernel.  It helps if you tag your releases.

This would help, but I'm on cygwin/msysgit and compiling with a
microcontroller IDE MPLAB and PICC-18 compiler, so I really don't
want to dig deeper into build time integration at the moment.

Btw, I don't know how didn't notice that this is a FAQ:
http://git.or.cz/gitwiki/GitFaq#Doesgithavekeywordexpansion.3F

-Mikko
