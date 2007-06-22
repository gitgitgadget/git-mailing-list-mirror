From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Fri, 22 Jun 2007 14:02:18 +0200
Message-ID: <20070622120217.GP19725@planck.djpig.de>
References: <f2t6na$5bi$1@sea.gmane.org> <11821227322913-git-send-email-frank@lichtenheld.de> <200706220156.01175.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 14:02:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1hqe-0003UA-KV
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 14:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbXFVMC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 08:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbXFVMC2
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 08:02:28 -0400
Received: from planck.djpig.de ([85.10.192.180]:2552 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754275AbXFVMC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 08:02:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id ED1F888102;
	Fri, 22 Jun 2007 14:02:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hCljiuEu7hQW; Fri, 22 Jun 2007 14:02:18 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 4485488105; Fri, 22 Jun 2007 14:02:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200706220156.01175.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50693>

On Fri, Jun 22, 2007 at 01:56:00AM +0200, Jakub Narebski wrote:
> On Mon, 18 Jun 2007, Frank Lichtenheld wrote:
> >  Note the FIXME. Does anyone remember the reason why --get-regexp
> >  and --list use different output format?
> 
> I don't know, but at least two scripts use --get-regexp, namely
> git-remote and git-submodule. So we would have to be careful about
> changing that.
>  
> 
> I would be enough to add the following to your patch:

Yeah, I found this a but ugly though so I left it out of the first
patch in case someone had a better idea. Will include that in the
second version (which will also include documentation).

> By the way, I have tried to use git-config --null to redo config
> file parsing in gitweb, so one git-config call would be needed for
> all the config. I have noticed that --bool option description does
> not describe the observed behavior fully. For example it returns
> 'true' not only for '1', but for any integer != 0, including 0xdeadbeef.

Yeah, the description of --bool is very incomplete. Note that empty
values are false, and keys without values are true. I think this all
are valid choices, but they are indeed not documented.

Gruesse.
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
