From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: read-only mode
Date: Thu, 04 Dec 2008 10:47:13 +0100
Message-ID: <4937A721.6000606@drmicha.warpmail.net>
References: <8763m0swtz.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Thu Dec 04 10:48:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Ap0-0000GS-Rv
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 10:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbYLDJrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 04:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbYLDJrR
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 04:47:17 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49406 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176AbYLDJrQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2008 04:47:16 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id D53F31CCEB1;
	Thu,  4 Dec 2008 04:47:15 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 04 Dec 2008 04:47:15 -0500
X-Sasl-enc: kK1gmR4aGT5F45LpFWhmGkftQqxzoHhnb60s2o1hyOzz 1228384035
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3F6EB1A4C3;
	Thu,  4 Dec 2008 04:47:15 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <8763m0swtz.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102332>

jidanni@jidanni.org venit, vidit, dixit 03.12.2008 23:44:
> Here's a documentation stub. Please fix and finish it and place in some manual.

[Warning: irony ahead] Yes master, at your service!
[I'm aware he tone in the quote above may be due to translation issues.]

> ==Using git in read-only mode==
> Let's say you just want to examine things. There is a fine line
> between commands and options that just examine things vs. those that
> change things. One might worry that they can't remember that fine line.
> 
> Therefore the safest way to ensure you are using git in 'read-only mode' is to
> * su nobody, or
> * chmod -R u-w . (and remember to chmod -R u+w when you are finished), or

This does change things (time stamps).

I'd say the two above are no git-specific suggestions at all, and "cp -a
.git .git-orig" is the best safety-net for the cautious (assuming a
clean working tree) when doing heavy work but overkill for inspection.

> * ???

* clone and inspect the clone instead
* use obvious read-only commands (status, log, diff, show, ls-files,
tag&branch without argument) and avoid obvious write commands (commit,
checkout, apply, ...)

Without specifying "things" any further (repo, objects, index, working
tree) I don't really understand what the problem is.

Michael
