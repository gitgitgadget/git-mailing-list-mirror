From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 18:44:30 -0700 (PDT)
Message-ID: <20060929014430.44203.qmail@web51006.mail.yahoo.com>
References: <20060929002748.GA11055@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 03:46:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT7Qf-0003Ms-Cz
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 03:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWI2Boi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 21:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWI2Boi
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 21:44:38 -0400
Received: from web51006.mail.yahoo.com ([206.190.38.137]:55155 "HELO
	web51006.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751247AbWI2Boh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 21:44:37 -0400
Received: (qmail 44205 invoked by uid 60001); 29 Sep 2006 01:44:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Kt506ckGcnok+xoOzDulEobwoC79o5ZYSj1XGDoKXZG4jZJrGRsTXKs2QjMTNgkHHE41gYgUroMhZ4sCGiXxPM1VbD/vjTzfmWbXFxy2T80k8PJFv+LgJCscHg6fwK6aoYF0iu9xlX0Cyp5xITHCjr9MYw8gmCszFriJ3K3Q/3c=  ;
Received: from [207.172.80.85] by web51006.mail.yahoo.com via HTTP; Thu, 28 Sep 2006 18:44:30 PDT
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20060929002748.GA11055@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28081>

--- Theodore Tso <tytso@mit.edu> wrote:

> Git mirroring takes place using the same pushing and pulling that are
> used with multiple repositories.  That's why if Linus does a huge
> amount of work over the period of a day or two in his private
> repository, and then publishes it master.kernel.org, the "local" time
> on master.kernel.org will be the time when they are pushed to
> master.kernel.org, because it's done via the same operation as any
> other repository push or pull.
> 
> That's what everyone has been trying to tell you for this entire
> thread....

Ok, I was wondering about that. In your example above the internally unnecessary timestamp will be
from Linus' private repo, not master.kernel.org's? Even now knowing replication = merge/push/pull
I still think it worthwile for local commit time to be effiently tracked locally and/or if already
available in the local ref-log used by things like gitweb.cgi if feasible but I might be the only
one that cares this much about time. Gitweb.cgi currently relies at least display/visually on
those internally unnecessary and potentially misleading timestamps...

-Matt


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
