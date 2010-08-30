From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: git peer-to-peer project: info needed
Date: Mon, 30 Aug 2010 13:45:07 -0400
Message-ID: <20100830174506.GB9955@fearengine.rdu.redhat.com>
References: <AANLkTi=xLJ4w1D4=p40f8nUQfLu5hpEfNORnjroffM1v@mail.gmail.com>
 <20100830173905.GA9955@fearengine.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git@vger.kernel.org
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 19:45:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq8Q5-0001je-R8
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 19:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241Ab0H3RpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 13:45:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6155 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab0H3RpL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 13:45:11 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7UHj99J027557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 30 Aug 2010 13:45:10 -0400
Received: from fearengine.rdu.redhat.com (dhcp243-150.rdu.redhat.com [10.11.243.150])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o7UHj7bP009486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 30 Aug 2010 13:45:08 -0400
Content-Disposition: inline
In-Reply-To: <20100830173905.GA9955@fearengine.rdu.redhat.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154838>

On Mon, Aug 30, 2010 at 01:39:07PM -0400, Casey Dahlin wrote:
> On Sun, Aug 29, 2010 at 10:56:27PM +0100, Luke Kenneth Casson Leighton wrote:
> > hi folks,
> > 
> > [please could you kindly cc on responses because i am subscribed with
> > "no mail" set]
> > 
> > i need some guidance on what i should be doing, to add peer-to-peer
> > networking to "git fetch".  i can take care of the peer-to-peer
> > networking side: the bit i'm unsure about is what sequence of events
> > are required to happen.  i'm presently looking at the use of
> > walker_fetch in builtin-http-fetch.c which gives me some idea.
> > however as i aim to implement this first in python not c, i need to be
> > using git via command-line only.
> > 
> 
> I have a peer-to-peer git patchset that I'm already working on, which is
> nearly in a showable state. I've wanted to sand off a few more edges
> before a public review but I'll happily share it.
> 
> --CJD

On further review you seem to be talking more about making fetch itself
peer-to-peer, where my patchset is more of a peer-to-peer branch-sharing
mechanism. Complementary but not necessarily conflicting. Still I'll
hurry up and get it online :)

--CJD
