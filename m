From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn branch
Date: Thu, 13 Nov 2008 09:34:09 +0100
Message-ID: <491BE681.3050700@drmicha.warpmail.net>
References: <ac92b632-f300-4cbd-8450-6a908fc2c762@t39g2000prh.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: yb_Art <kineticac@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 09:35:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Xfo-0002el-Gq
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 09:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbYKMIeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 03:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbYKMIeN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 03:34:13 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50397 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750824AbYKMIeM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 03:34:12 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 39EEB1AE28B;
	Thu, 13 Nov 2008 03:34:11 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 13 Nov 2008 03:34:11 -0500
X-Sasl-enc: Q2BrE0eNLGSZaRoKKDRHqVo8mEjGDLwyaBYjyBtx+945 1226565250
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 90011D904;
	Thu, 13 Nov 2008 03:34:10 -0500 (EST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <ac92b632-f300-4cbd-8450-6a908fc2c762@t39g2000prh.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100858>

yb_Art venit, vidit, dixit 13.11.2008 00:47:
> I'm using the binary from google code on my mac os-x leopard machine,
> and it doesn't have git svn branch.  How can I work around this
> issue?  Is there anyway to create a branch on the svn repository using
> git?

I don't know which version google code has, but git-svn is a perl script
which you can download directly from

http://repo.or.cz/w/git.git?a=blob_plain;f=git-svn.perl;hb=HEAD

Note that in git-svn.perl as downloaded you will have to adjust the
first few lines (maybe a uselib in the second line; @@GIT_VERSION@@) to
match what you have in your current git-svn. If your git is not too
ancient then current git-svn should work with it.

Actually, I think compiling yourself is easier...

Michael
