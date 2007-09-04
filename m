From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git clone over http
Date: Tue, 4 Sep 2007 20:19:54 +0200
Message-ID: <200709042019.56009.robin.rosenberg.lists@dewire.com>
References: <200709021123.04218.robin.rosenberg.lists@dewire.com> <1188924876.6192.21.camel@beauty> <7vir6qnxuh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Josh England" <jjengla@sandia.gov>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 20:18:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IScym-0004SF-IO
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 20:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008AbXIDSSU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 14:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754944AbXIDSST
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 14:18:19 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12597 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754796AbXIDSST (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 14:18:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B38028027E5;
	Tue,  4 Sep 2007 20:10:22 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25754-04; Tue,  4 Sep 2007 20:10:22 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 4AA52802664;
	Tue,  4 Sep 2007 20:10:22 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vir6qnxuh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57632>

tisdag 04 september 2007 skrev Junio C Hamano:
> "Josh England" <jjengla@sandia.gov> writes:
> 
> > On Sun, 2007-09-02 at 11:23 +0200, Robin Rosenberg wrote:
> >> git clone (1.5.3) with http is somewhat unreliable. I've noticed if
> >> can actually give
> >> me different versions of a branch each time I run it, eventually yielding
> >> the one I'm expecting.  And now this:
> >
> > I don't see this behavior, but I do see other wierdness cloning via
> > http.  Anytime I clone a repo (any repo) via http from behind the
> > firewall/proxy at work I never get any branches.  'git branch' only ever
> > shows 'master'.  I can't checkout and work on any other branch.  I can
> > work around the problem by cloning on a box that is more open, but was
> > wondering if anyone knows how to fix this.
> 
> Well, what does "git branch -r" say?
> 
> If you see the remote tracking branches out of your branch (aka
> "heads/") namespace, that has been the default for quite some
> time since 1.5.0 days.
> 
> Perhaps "more open" one has ancient git that dumped remote
> tracking branches in your branch namespace, while your "behind
> firewall" one has not so ancient git?

The version where I noticed that strange behaviour was 1.5.3-rc6 on the client
and 1.5.1.4 on the server. The local repo was originally cloned with 1.5.something.
The interesting branch was a non-fastword one (i.e. "pu") and on the server I
was running git-update-server-info every 30 minutes. The pu branch on the server
was stable during the strange period. I'm not sure whether I got the odd behaviour
within those 30 minutes or not.

The url to the repo is http: //rosenberg.homelinux.net/repos/EGIT.git

I cannot http clone myself anymore it seems, but someone else may succeed better.

My curl is 7.16.0. Haven't tried any other version yet.

-- robin
