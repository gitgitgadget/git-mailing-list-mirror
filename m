From: Sam Vilain <sam@vilain.net>
Subject: Re: Merging in Subversion 1.5 (was: Re: Using git to track my PhD
 thesis, couple of questions)
Date: Mon, 31 Aug 2009 07:41:56 +1200
Message-ID: <1251661316.25764.4.camel@maia.lan>
References: <4A979690.1050601@gnu.org> <20090827203402.GC7168@kisimul>
	 <vpqk50pasek.fsf@bauges.imag.fr> <20090827203402.GC7168@kisimul>
	 <9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com>
	 <20090827203402.GC7168@kisimul> <7v1vmxq6nw.fsf@alter.siamese.dyndns.org>
	 <20090827203402.GC7168@kisimul>
	 <fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com>
	 <20090827203402.GC7168@kisimul> <20090828133708.GA11146@kisimul>
	 <vpqpragt5bo.fsf@bauges.imag.fr> <4A97E1B1.7090107@gmx.de>
	 <m3ocq0km5m.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 21:42:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhqIT-0006JK-I7
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 21:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbZH3TmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 15:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbZH3TmF
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 15:42:05 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:49768 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbZH3TmE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 15:42:04 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 0B31021C3DF; Mon, 31 Aug 2009 07:42:04 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id D216B21C3AC;
	Mon, 31 Aug 2009 07:41:59 +1200 (NZST)
In-Reply-To: <m3ocq0km5m.fsf_-_@localhost.localdomain>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127423>

On Fri, 2009-08-28 at 08:12 -0700, Jakub Narebski wrote:
>  * svn:mergeinfo contains _per-file_ merge info, so it is much, much
>    more "chatty" than Git multiple parents.

It can.  But more often, if you're merging complete paths, you will get
complete revision ranges.

See eg
https://trac.parrot.org/parrot/browser/trunk

Note how trac is also hiding the branches that were subsequently deleted
from the mergeinfo ticket.

>  * The command to merge trunk into branch is different from command to
>    merge branch into trunk.

This is a caveat of url-based branches.

> Also IIRC there is warning (well, at least there was in Subversion 1.5
> release notes) that merge tracking doesn't work entirely correctly in
> the face of criss-cross merges (multiple merge bases) and renaming
> (although I do hope that they fixed problem with silent corruption if
> there is rename during merge).

Not sure about that one.  I also heard - unconfirmed - that things start
to go awry if you start branching off branches and merging around the
place.  But if that happens it's likely a bug rather than a design flaw
(I think).

Sam
