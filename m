From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: git2rss --- publish changes from git-log via RSS
Date: Fri, 7 Jul 2006 21:23:13 +0200
Message-ID: <E1Fyvuz-0007rM-BD@moooo.ath.cx>
References: <20060704191135.GB10534@rahul.net> <e8elej$4sa$1@sea.gmane.org> <20060706125328.GA19414@rahul.net> <e8m9m2$m37$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 21:24:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyvvA-0000OR-1V
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 21:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWGGTXV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 15:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWGGTXV
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 15:23:21 -0400
Received: from moooo.ath.cx ([85.116.203.178]:62086 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932277AbWGGTXU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 15:23:20 -0400
To: Bennett Todd <bet@rahul.net>, Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: Bennett Todd <bet@rahul.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e8m9m2$m37$1@sea.gmane.org>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23460>

Jakub Narebski wrote:
> Bennett Todd wrote:
> 
> > 2006-07-04T21:09:32 Jakub Narebski:
> 
> >> BTW. gitweb includes RSS feed, see e.g.:
> >>   http://www.kernel.org/git/?p=git/git.git;a=rss
> >>   http://www.kernel.org/git/?p=git/git.git;a=opml
> > 
> > Can it be used for offline generation? I don't run any CGIs on my
> > webserver, I re-generate bent.xml whenever I push any updates.
> 
> Just run it as a script. IIRC there is a way to pass CGI params
> to a script...

env REQUEST_METHOD=GET QUERY_STRING='p=git/git.git;a=rss' \
./gitweb.cgi | (read; read; cat)

works fine if gitweb.cgi is setup correctly.
