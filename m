From: Petr Baudis <pasky@suse.cz>
Subject: Re: RFC: grafts generalised
Date: Thu, 3 Jul 2008 02:16:14 +0200
Message-ID: <20080703001614.GG12567@machine.or.cz>
References: <20080702143519.GA8391@cuci.nl> <20080703001331.GF12567@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Jul 03 02:17:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KECVc-0001PZ-LY
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 02:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbYGCAQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 20:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbYGCAQQ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 20:16:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59916 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbYGCAQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 20:16:15 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 9ED0E1E4C026; Thu,  3 Jul 2008 02:16:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080703001331.GF12567@machine.or.cz>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87209>

On Thu, Jul 03, 2008 at 02:13:31AM +0200, Petr Baudis wrote:
>   So, the real solution is to take the commit objects you want to
> modify, create new commit objects, then graft the new commit on all the
> old commit children. It fits neatly in the Git philosophy, there is no
> need at all to tweak the current infrastructure for this and it should
> be trivial to automate, too.

  Oops, sorry; I stopped reading the branch of the thread I thought was
going off on a different tangent one post too early. :-)

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
