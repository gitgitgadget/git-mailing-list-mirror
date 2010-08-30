From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: git peer-to-peer project: info needed
Date: Mon, 30 Aug 2010 13:39:07 -0400
Message-ID: <20100830173905.GA9955@fearengine.rdu.redhat.com>
References: <AANLkTi=xLJ4w1D4=p40f8nUQfLu5hpEfNORnjroffM1v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 19:39:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq8KD-0005jO-SL
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 19:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215Ab0H3RjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 13:39:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756093Ab0H3RjL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 13:39:11 -0400
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7UHd93e023210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 30 Aug 2010 13:39:09 -0400
Received: from fearengine.rdu.redhat.com (dhcp243-150.rdu.redhat.com [10.11.243.150])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o7UHd7bF018329
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 30 Aug 2010 13:39:09 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=xLJ4w1D4=p40f8nUQfLu5hpEfNORnjroffM1v@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154836>

On Sun, Aug 29, 2010 at 10:56:27PM +0100, Luke Kenneth Casson Leighton wrote:
> hi folks,
> 
> [please could you kindly cc on responses because i am subscribed with
> "no mail" set]
> 
> i need some guidance on what i should be doing, to add peer-to-peer
> networking to "git fetch".  i can take care of the peer-to-peer
> networking side: the bit i'm unsure about is what sequence of events
> are required to happen.  i'm presently looking at the use of
> walker_fetch in builtin-http-fetch.c which gives me some idea.
> however as i aim to implement this first in python not c, i need to be
> using git via command-line only.
> 

I have a peer-to-peer git patchset that I'm already working on, which is
nearly in a showable state. I've wanted to sand off a few more edges
before a public review but I'll happily share it.

--CJD
