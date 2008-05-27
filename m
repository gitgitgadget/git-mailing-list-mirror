From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Reverting to old commit
Date: Tue, 27 May 2008 22:41:04 +0200
Message-ID: <200805272241.04884.robin.rosenberg.lists@dewire.com>
References: <8345bd80805271050q7412917bt292a276fbbe6aed3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marcus <prima@wordit.com>
X-From: git-owner@vger.kernel.org Tue May 27 23:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K16Sl-0002ut-N7
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 23:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758838AbYE0VLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 17:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758788AbYE0VLP
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 17:11:15 -0400
Received: from av10-1-sn2.hy.skanova.net ([81.228.8.181]:36398 "EHLO
	av10-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758757AbYE0VLN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 17:11:13 -0400
X-Greylist: delayed 1680 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 May 2008 17:11:13 EDT
Received: by av10-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id E9734385B1; Tue, 27 May 2008 22:43:11 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av10-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id C6373386F7; Tue, 27 May 2008 22:43:11 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 8674437E4C;
	Tue, 27 May 2008 22:43:11 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <8345bd80805271050q7412917bt292a276fbbe6aed3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83052>

tisdagen den 27 maj 2008 19.50.31 skrev Marcus:
> Newbie question: What's the simplest way to find an old commit and revert?
> 
> Say you have a version from yesterday which worked and today's
> experiments failed, so you want to go back to that working version.
> Unfortunately, it's not tagged. Instead you need to actually view the
> code to identify the version you want. I thought maybe gitk might
> help, but I can't find my way with gitk. I hoped you could browse
> revisions easier in a GUI and tell gitk or git-gui to revert?

If you know a line of code that you know or suspect is wrong, you
can find the commit that introduced the version using git blame. 

-- robin
