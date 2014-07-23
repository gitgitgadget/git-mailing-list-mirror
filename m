From: Ross Boylan <ross@biostat.ucsf.edu>
Subject: Re: confused about remote branch management
Date: Wed, 23 Jul 2014 11:54:01 -0700
Message-ID: <1406141641.29001.170.camel@localhost>
References: <1406083743.29001.139.camel@localhost>
	 <CAO54GHBEexASvZcdJqDtgYkfecGbuZFLneC6Nr8u6CYfXuUPog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Kevin <ikke@ikke.info>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:54:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA1g4-0007lc-FK
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 20:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933042AbaGWSyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 14:54:06 -0400
Received: from upstrm185.psg-ucsf.org ([38.99.193.74]:56372 "EHLO
	biostat.ucsf.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932735AbaGWSyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 14:54:05 -0400
Received: from ns204-a-650ts.psg.net ([10.0.2.3]:32609 helo=[192.168.40.102])
	by biostat.ucsf.edu with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <ross@biostat.ucsf.edu>)
	id 1XA1fr-0007yX-0U; Wed, 23 Jul 2014 11:53:59 -0700
In-Reply-To: <CAO54GHBEexASvZcdJqDtgYkfecGbuZFLneC6Nr8u6CYfXuUPog@mail.gmail.com>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254109>

On Wed, 2014-07-23 at 15:09 +0200, Kevin wrote:
> 
> On Jul 23, 2014 5:11 AM, "Ross Boylan" <ross@biostat.ucsf.edu> wrote:
> >
> > My local master branch is the result of a merge of upstream master
> and
> > some local changes.  I want to merge in more recent upstream work.
> > git pull doesn't seem to have updated origin/master, and git
> checkout
> > origin/master also doesn't seem to work.
> >
> 
> git pull with two parameters in older versions will not update remote
> tracking branches. That's because the last parameter expects a refspec
> with a source and destination and you only specify a source. 
My command was "git pull origin master" so I  think it has a source as
well.
> 
> Doing a git fetch will update them. 
I thought git pull = get fetch + git merge.  Are you saying that if I
issued those 2 commands separately the result would have been different?
Ross
> 
> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git --version
> > git version 1.7.10.4
> 
> Version 1.8.4 changes this behavior and will update the remote
> tracking branches. 
> 
> 
