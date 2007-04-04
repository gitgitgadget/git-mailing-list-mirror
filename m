From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: git-cvsimport: all my files are marked deleted ?
Date: Wed, 4 Apr 2007 22:22:52 +0200
Message-ID: <20070404202251.GA21616@planck.djpig.de>
References: <200703101809.l2AI9lin005409@localhost.localdomain> <1173552693.5975.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Xavier Maillard <zedek@gnu.org>, git@vger.kernel.org
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 22:23:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZC0S-0003Vr-2B
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 22:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbXDDUW4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 16:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbXDDUW4
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 16:22:56 -0400
Received: from planck.djpig.de ([85.10.192.180]:34900 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547AbXDDUWz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 16:22:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 1C80F88136;
	Wed,  4 Apr 2007 22:22:53 +0200 (CEST)
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (smtp.lichtenheld.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09576-02; Wed, 4 Apr 2007 22:22:52 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 2080388137; Wed,  4 Apr 2007 22:22:52 +0200 (CEST)
Mail-Followup-To: Raimund Bauer <ray007@gmx.net>,
	Xavier Maillard <zedek@gnu.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1173552693.5975.13.camel@localhost>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lichtenheld.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43773>

On Sat, Mar 10, 2007 at 07:51:33PM +0100, Raimund Bauer wrote:
> On Sat, 2007-03-10 at 19:09 +0100, Xavier Maillard wrote:
> > Then I went back to <directory> and I just did 'ls'. Directory is
> > empty (except the .git directory).
> 
> 'git checkout -f' is your friend here.
> 
> Not long ago I was wondering about the same thing ...

I was hit by this today, too. Luckily I remembered vaguely that
it came up on the list not long ago :)

But it leaves me with the question (to the list): Why doesn't do
git-cvsimport a checkout -f? It seems like the right thing to
do (at the very least for initial imports that create a new repository).

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
