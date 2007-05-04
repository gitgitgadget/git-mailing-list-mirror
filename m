From: Andrew Ruder <andy@aeruder.net>
Subject: Re: [RFC?] Telling git about more complex relationships between commits (Was: Re: FFmpeg considering GIT)
Date: Fri, 4 May 2007 07:06:51 -0500
Message-ID: <20070504120651.GA6053@bowser.ruder>
References: <loom.20070502T111026-882@post.gmane.org> <200705040921.33443.johan@herland.net> <81b0412b0705040236w1d5f26bx8ac351ade2f4ea6a@mail.gmail.com> <200705041239.22300.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 14:09:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjwbL-0003cp-Eo
	for gcvg-git@gmane.org; Fri, 04 May 2007 14:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbXEDMJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 08:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbXEDMJ2
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 08:09:28 -0400
Received: from www.aeruder.net ([65.254.53.245]:1179 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbXEDMJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 08:09:27 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id A614840192
	for <git@vger.kernel.org>; Fri,  4 May 2007 07:09:26 -0500 (CDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200705041239.22300.andyparkins@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46175>

On Fri, May 04, 2007 at 12:39:18PM +0100, Andy Parkins wrote:
> That way git-svn wouldn't (necessarily) need to keep its .rev_db file, and it 
> wouldn't need any special handling to allow the repository to be cloned.

Which, BTW, would be a great thing as on subversion repositories with
lots of revisions and lots of branches/tags, the disk space for all those
.rev_db files gets pretty bad.  i.e. du -sh .git/objects == 14M, du -sh
.git == 120M.

- Andy

-- 
Andrew Ruder <andy@aeruder.net>
http://www.aeruder.net
