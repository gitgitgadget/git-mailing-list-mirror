From: Bart Trojanowski <bart@jukie.net>
Subject: Re: [PATCH] prevent checkout from creating branches that start
	with a   dash
Date: Wed, 2 Jul 2008 12:34:31 -0400
Message-ID: <20080702163431.GI26300@jukie.net>
References: <20080702150128.GH26300@jukie.net> <486BA0DD.5030608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 18:35:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE5In-0001rj-Hb
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 18:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbYGBQec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 12:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbYGBQec
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 12:34:32 -0400
Received: from tau.jukie.net ([216.239.93.128]:35842 "EHLO tau.jukie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbYGBQec (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 12:34:32 -0400
Received: by tau.jukie.net (Postfix, from userid 1000)
	id 652C0C019F0; Wed,  2 Jul 2008 12:34:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <486BA0DD.5030608@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87157>

* Johannes Sixt <j.sixt@viscovery.net> [080702 12:00]:
> Bart Trojanowski schrieb:
> > It was previously possible to create a -f branch with git-checkout, which
> > could not be used or deleted.
> > 
> >         $ git checkout -b -f master
> >         Switched to a new branch "-f"
> 
> "-f" *is* a valid branch name and can be used and deleted:

Thanks, that I didn't know.

-Bart

-- 
				WebSig: http://www.jukie.net/~bart/sig/
