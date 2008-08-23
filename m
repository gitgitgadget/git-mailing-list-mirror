From: Andi Kleen <andi@firstfloor.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 09:15:52 +0200
Message-ID: <20080823071552.GU23334@one.firstfloor.org>
References: <20080822174655.GP23334@one.firstfloor.org> <32541b130808221056l75a3fd6bsa6c7933a1c3da60f@mail.gmail.com> <20080822183129.GR23334@one.firstfloor.org> <m37ia8sv49.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 09:14:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWnKj-0001Q6-Ct
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 09:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbYHWHNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 03:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbYHWHNo
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 03:13:44 -0400
Received: from one.firstfloor.org ([213.235.205.2]:46933 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbYHWHNo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 03:13:44 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id BF8871AD0020; Sat, 23 Aug 2008 09:15:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m37ia8sv49.fsf@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93429>

>   $ git remote update
>   $ git reset --hard origin/master  # when on master
> 
> BTW. it is stated countless time in documentation that published
> history should be not rebased, barring some extenuating circumstances

Yes and people countless times ignore that recommendation and do 
it anyways (for good reasons).  And then other users 
have to deal with these rebased trees somehow.

Anyways it is all solvable but right now ill supported
in standard commands and the documentation does not really
cover it. I was just asking (mostly for others to avoid
going through the same pain as me) for that to be improved
so that git becomes easier to use.

Sadly you guys don't even seem to want to recognize there
is a problem :-( 

-Andi
