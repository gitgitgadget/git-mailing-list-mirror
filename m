From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-commit: Reformat log messages provided on commandline
Date: Sat, 12 May 2007 02:25:02 +0200
Organization: At home
Message-ID: <f23187$5p7$1@sea.gmane.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705061851411.4015@racer.site> <vpqk5vlamav.fsf@bauges.imag.fr> <7vvef5c0fw.fsf@assigned-by-dhcp.cox.net> <20070509125225.GP4489@pasky.or.cz> <Pine.LNX.4.64.0705091513360.4167@racer.site> <20070509142426.GV4489@pasky.or.cz> <7vsla5pkug.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 02:20:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmfLo-0001FP-6l
	for gcvg-git@gmane.org; Sat, 12 May 2007 02:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309AbXELAUk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 20:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759027AbXELAUk
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 20:20:40 -0400
Received: from main.gmane.org ([80.91.229.2]:48988 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756309AbXELAUj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 20:20:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HmfLh-00078m-NJ
	for git@vger.kernel.org; Sat, 12 May 2007 02:20:37 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 May 2007 02:20:37 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 May 2007 02:20:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46999>

Junio C Hamano wrote:

> This is slightly related, but I have been wondering about the
> interaction with "single-liner summary, empty line and then the
> rest" convention and various commands in the log family.
> 
> Currently, --pretty=oneline and --pretty=email (hence format-patch)
> take and use only the first line.  I think we could change it to:
> 
>  - take the first paragraph, where the definition of the first
>    paragraph is "skip all blank lines from the beginning, and
>    then grab everything up to the next empty line".
> 
>  - replace all line breaks with a whitespace.
[...]
> If we were to do this, Subject: line would most likely use
> RFC2822 line folding at the places where line breaks were in the
> original, but that goes without saying.
> 
> What do people think?

I agree that it is a good idea. This would e.g. help projects which are
imported from other SCM, which does not have "single-liner summary, empty
line and then the rest" convention of formatting commit messages.

BTW. does rebase work correctly for commits which do not use above
convention?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
