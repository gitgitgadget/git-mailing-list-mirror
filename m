From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn fails to fetch repository
Date: Tue, 13 Jan 2009 18:51:25 +0100
Message-ID: <496CD49D.1070201@drmicha.warpmail.net>
References: <loom.20090113T145019-951@post.gmane.org> <loom.20090113T150220-345@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vladimir Pouzanov <farcaller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 18:52:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMnRY-0005rn-9E
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 18:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbZAMRv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 12:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbZAMRv0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 12:51:26 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38950 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751185AbZAMRv0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2009 12:51:26 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4873C210F4F;
	Tue, 13 Jan 2009 12:51:25 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 13 Jan 2009 12:51:25 -0500
X-Sasl-enc: EBEL6DB9nfvjAUjPeDH30hUAuU6kVAqJ+x/oiZnUQG72 1231869085
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ABE25A7E1;
	Tue, 13 Jan 2009 12:51:24 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <loom.20090113T150220-345@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105515>

Vladimir Pouzanov venit, vidit, dixit 01/13/09 16:03:
> Also just tried on linux box (git 1.6.0.4, perl 5.8.8). Got all the revisions
> but git segfaulted at the end:
> ...
> r21 = e839272549fd746cf45542a7aa6cb151ae3813da (trunk)
> Checked out HEAD:
>   http://qsb-mac.googlecode.com/svn/trunk r21
> Segmentation fault

I'm getting
...
r21 = e839272549fd746cf45542a7aa6cb151ae3813da (git-svn)
Checked out HEAD:
  http://qsb-mac.googlecode.com/svn/trunk r21

This is with git 1.6.1rc4 (yeah I should have updated), perl 5.8.8 and
svn 1.4.6 on Linux. Same with git 1.6.0.6, perl 5.10.0 and svn 1.5.4 on
another box. The one git-svn change between 1.6.0.4 and 1.6.0.6 should
not matter because you don't have branches. What's your svn version?

Michael
