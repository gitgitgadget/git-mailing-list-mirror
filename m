From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Re: [ANNOUNCE] Public Gitweb Hosting Service
Date: Thu, 21 Sep 2006 22:42:48 +0000 (UTC)
Message-ID: <eev4h8$cvu$1@sea.gmane.org>
References: <20060920004828.GI8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-From: git-owner@vger.kernel.org Fri Sep 22 00:44:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQXHa-0005gG-Jt
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 00:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWIUWnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 18:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWIUWnZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 18:43:25 -0400
Received: from main.gmane.org ([80.91.229.2]:48030 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932092AbWIUWnY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 18:43:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GQXGE-0005Nx-Uf
	for git@vger.kernel.org; Fri, 22 Sep 2006 00:43:14 +0200
Received: from 88-110-169-193.dynamic.dsl.as9105.com ([88.110.169.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Sep 2006 00:43:14 +0200
Received: from wildfire by 88-110-169-193.dynamic.dsl.as9105.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Sep 2006 00:43:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 88-110-169-193.dynamic.dsl.as9105.com
User-Agent: pan 0.106 (Dum Maro Dum)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27508>

On Wed, 20 Sep 2006 02:48:28 +0200, Petr Baudis wrote:

> Hi,
> 
>   there are various tiny repositories scatterred over the web that are
> on crappy broken webhostings, don't have lifetime long enough and most
> importantly have no gitweb interface for peeking inside - even e.g. the
> StGIT repository suffers from that.
>

[snip]
 
>   Note that there is also a glibc CVS import available at that address,
> entirely coincidentally. That one is an exception and is not synced from
> any other Git repository. It took git-cvsimport two days to chew through
> on a decent machine (but over the network), the resulting size of 107M is
> pretty nice. I hope to set it up to automatically track glibc CVS further
> (and possibly other popular non-Git projects later).  There's insane
> amount of tags which means the gitweb summary page takes "a bit" long to
> load, I wonder if using packed refs would improve that.

I've got some imports of some projects that I am tracking as well.

http://www.progsoc.org/~wildfire/git/

I have not (yet) enabled git-daemon support for them, so anyone cloning
them might find it takes a long amount of time. I haven't updated to the
most recent gitweb/git lately so it might be a bit slow.

I'll get around to making both git-daemon support available and updating
to a newer version of gitweb shortly.

If anyone wants me to track other projects, let me know.

Cheers,
Anand
