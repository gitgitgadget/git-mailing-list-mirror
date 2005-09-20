From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's wrong with cogito repository today?
Date: Tue, 20 Sep 2005 21:05:16 +0200
Message-ID: <20050920190516.GB28621@pasky.or.cz>
References: <863bnzd2eu.fsf@blue.stonehenge.com> <1127233633.8374.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 21:07:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHnQg-0007JR-Jl
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 21:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbVITTFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 15:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVITTFT
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 15:05:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63443 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965083AbVITTFS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 15:05:18 -0400
Received: (qmail 1074 invoked by uid 2001); 20 Sep 2005 21:05:16 +0200
To: root@master.kernel.org, Pavel Roskin <proski@gnu.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <863bnzd2eu.fsf@blue.stonehenge.com> <1127233633.8374.26.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9016>

Dear diary, on Tue, Sep 20, 2005 at 06:27:13PM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hello!

Hello,

> cogito repository is broken today:
> 
> $ git-fetch
> Fetching refs/heads/master from http://www.kernel.org/pub/scm/cogito/cogito.git/ using http
> Getting pack list
> Getting alternates list
> error: Unable to find 69ba00668be16e44cae699098694286f703ec61d under http://www.kernel.org/pub/scm/cogito/cogito.git//
> 
> Cannot obtain needed object 69ba00668be16e44cae699098694286f703ec61d
> while processing commit 0000000000000000000000000000000000000000.

this seems to be an issue with kernel.org mirroring, unfortunately
apparently stuck up in the middle of mirroring Cogito. It is on
master.kernel.org:

-r--r--r--  2 pasky pasky 207 Sep 19 18:38 /pub/scm/cogito/cogito.git/objects/69/ba00668be16e44cae699098694286f703ec61d

Kernel.org people, could you please have a look at the stalled rsync
process? Thanks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
