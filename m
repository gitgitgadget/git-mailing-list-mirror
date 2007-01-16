From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Tue, 16 Jan 2007 11:09:00 -0800
Message-ID: <20070116190900.GA1444@localdomain>
References: <200701150144.56793.jnareb@gmail.com> <200701151003.44498.jnareb@gmail.com> <20070115095613.GA4037@localdomain> <200701151132.00971.jnareb@gmail.com> <20070115112635.GA5134@localdomain> <Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de> <dbfc82860701150734j7322de15v30dc6822b456ea66@mail.gmail.com> <7vwt3nxnak.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701161206050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Nikolai Weibull <now@bitwi.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 20:09:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6tgP-0004F6-IN
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 20:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbXAPTJL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 14:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbXAPTJL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 14:09:11 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39610 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbXAPTJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 14:09:09 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 9A3817DC094;
	Tue, 16 Jan 2007 11:09:00 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 16 Jan 2007 11:09:00 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701161206050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36953>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Tue, 16 Jan 2007, Junio C Hamano wrote:
> 
> > "Nikolai Weibull" <now@bitwi.se> writes:
> > 
> > > If we're going down this slippery slope, why not just give up and add
> > > a --xml switch instead?  Readable by all...
> > 
> > Perhaps all except humans.
> > 
> > At least YAML, please...
> 
> I am _strongly_ opposed to all that rubbish. _If_ we want to use 
> repo-config to preformat the config variables, we should either
> 
> 1) just use "git repo-config -l" and STFU, or
> 2) introduce something like "--dump" which Eric implemented.
> 
> Everything else is just _complicating_ matters, and for _what_? _Nothing_ 
> at all. If we use repo-config for that task, it should cater for parsing 
> by _script languages_, not _users_.
> 
> I work with XML everyday. It has its uses. But this here problem is _not_ 
> one of them. How silly would that be: we parse an easy-to-read format, 
> munge the easy-to-handle internal data format into another "easy-to-read" 
> format which is then parsed by a script language into an easy-to-handle 
> internal data format? No. NO.

I agree with these statements.  I actually had YAML in my code
originally, but ripped it out because it would be another round of
parsing for any language using a YAML parser.

I like YAML, but no, this isn't the place for it IMHO.

-- 
Eric Wong
