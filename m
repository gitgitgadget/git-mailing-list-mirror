From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Tue, 20 Jun 2006 23:53:31 +0200
Message-ID: <20060620215331.GB25183@cip.informatik.uni-erlangen.de>
References: <e79921$u0e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Michael Gernoth <simigern@stud.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Tue Jun 20 23:53:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsoAD-0000ho-2d
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 23:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWFTVxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 17:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWFTVxe
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 17:53:34 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:25230 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751122AbWFTVxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 17:53:33 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id C841B30618; Tue, 20 Jun 2006 23:53:31 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e79921$u0e$1@sea.gmane.org>
User-Agent: Mutt/1.5.11-2006-06-13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22232>

Hello,

> Any further ideas for other useful features?

a friend of mine was yesterday complained to me about not be able to see
which file was last touched in a given directory like it is possible
with viewcvs[1]. I told him that he should just call 'git whatchanged
-p'. And he answered back 'downloading 128Mbytes' for a few bytes
of history? I told him to address this list with his feature request, but
he didn't do so far. So I use this opportunity. Maybe something else
would be much more handier: Use gitweb to request the log and shortlog
of a directory tree, like git-whatchanged arch/i386 does for example.
Maybe it is already possible and I missed it?

        Thomas

[1] viewcvs prints the last touch of a a file in a directory and you can
tell it to sort after the date criteria:

http://faumachine.informatik.uni-erlangen.de/cgi-bin/viewcvs.cgi/mutt/?sortby=date#dirlist
