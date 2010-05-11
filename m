From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [msysGit] [PATCH/RFC] autocrlf: Make it work also for
	un-normalized repositories
Date: Wed, 12 May 2010 00:28:02 +0200
Message-ID: <20100511222802.GA16974@pvv.org>
References: <20100510171119.GA17875@pvv.org> <alpine.DEB.1.00.1005101921460.7651@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 12 00:28:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBxw1-0005nZ-W0
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 00:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab0EKW2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 18:28:12 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:40155 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab0EKW2K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 18:28:10 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OBxvm-0001LU-Q1; Wed, 12 May 2010 00:28:06 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1005101921460.7651@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146907>

On Mon, May 10, 2010 at 07:29:34PM +0200, Johannes Schindelin wrote:

> > +			if (ce_stage(istate->cache[i]) == 2)
> > +				pos = i;
> > +	}
> 
> I think it makes sense to assume that "ours" determines whether we should 
> assume that the index has a wrong format. But if there is also a "base" 
> that disagrees on CR-ness with "ours", should we not try to pick "ours"?

Did you make a typo there, or did I misunderstand something? As far as
I can tell we do pick "ours" in this case, and I think that may be the
best choice overall (it is easiest for you to fix "ours" if the
result is wrong).

- Finn Arne
