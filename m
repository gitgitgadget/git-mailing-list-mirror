From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git gui and commit-msg hook
Date: Thu, 17 Jan 2008 23:12:30 -0500
Message-ID: <20080118041230.GA24004@spearce.org>
References: <054F21930D24A0428E5B4588462C7AEDC5F8DB@ednex512.dsto.defence.gov.au> <054F21930D24A0428E5B4588462C7AEDC5F8DC@ednex512.dsto.defence.gov.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Blucher, Guy" <Guy.Blucher@dsto.defence.gov.au>
X-From: git-owner@vger.kernel.org Fri Jan 18 05:13:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFibR-0005EN-R9
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 05:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbYAREMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 23:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbYAREMf
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 23:12:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43324 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbYAREMe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 23:12:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JFiaa-0000cN-3I; Thu, 17 Jan 2008 23:12:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6C1B020FBAE; Thu, 17 Jan 2008 23:12:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <054F21930D24A0428E5B4588462C7AEDC5F8DC@ednex512.dsto.defence.gov.au>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70962>

"Blucher, Guy" <Guy.Blucher@dsto.defence.gov.au> wrote:
> Is the commit-msg hook supposed to work when using git gui to do a
> commit?

Uhhh.  Whoops.  ;-)

git-gui doesn't implement the commit-msg hook.  Because I forgot
to implement it.  So yes, its supposed to work, but no, it doesn't,
because it was never coded.  :-)
 
> All I want to do is verify that the text of a commit message follows
> some "corporate standard", perhaps I can do this using the pre-commit
> hook instead, but commit-msg seems to be the best fit?  

Yes, commit-msg is the proper hook to use here.  But git-gui doesn't
honor it.  I'll try to work out a fix after dinner this evening.

Thanks for the bug report.  Definately appreciated.

-- 
Shawn.
