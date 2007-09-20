From: Bart Trojanowski <bart@jukie.net>
Subject: Re: [PATCH] Add git-rev-list --invert-match
Date: Thu, 20 Sep 2007 08:18:06 -0400
Message-ID: <20070920121806.GC12076@jukie.net>
References: <20070919202615.GK3076@jukie.net> <20070920025225.GA12076@jukie.net> <7vbqbym15x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 14:18:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYKzG-0004Co-3j
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 14:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbXITMSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 08:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753311AbXITMSO
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 08:18:14 -0400
Received: from tachyon.jukie.net ([205.150.199.214]:46800 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752892AbXITMSK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 08:18:10 -0400
Received: from tau.jukie.net ([10.10.10.211]:40581)
	by jukie.net with esmtp (Exim 4.50)
	id 1IYKyt-0001rA-Hj; Thu, 20 Sep 2007 08:18:07 -0400
Received: by tau.jukie.net (Postfix, from userid 1000)
	id 274A4A75A10; Thu, 20 Sep 2007 08:18:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vbqbym15x.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58770>

* Junio C Hamano <gitster@pobox.com> [070920 00:05]:
> > +--invert-match::
> > +
> > +	Show those parts of history that do not match any of the regular
> > +        expression patterns.
> > +
> 
> Tabs and spaces?

Noted.  Will fix after I address Johannes' request.

> I am afraid people may not understand what "any of the regular
> expression patterns" means.  How about being a bit more
> explicit, like this?
> 
> 	When filtering the commits based on log message (`--grep`)
> 	or people (`--author` and `--committer`), show commits
> 	that do not match the criteria.

Yes, that sounds better.

Thanks,

-Bart

-- 
				WebSig: http://www.jukie.net/~bart/sig/
