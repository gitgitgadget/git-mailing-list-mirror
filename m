From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase vs rebase -i
Date: Thu, 4 Feb 2010 14:27:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002041414530.4505@intel-tinevez-2-302>
References: <76718491002032019i5f8ea947paa527988ddb7a378@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 14:28:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd1k8-0008M4-HZ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 14:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757663Ab0BDN13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 08:27:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:56573 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755933Ab0BDN12 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 08:27:28 -0500
Received: (qmail invoked by alias); 04 Feb 2010 13:27:26 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp051) with SMTP; 04 Feb 2010 14:27:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NoJhltWINpHh0mybxbumKb3n8vU0pua0SQ8s271
	GiT9jteaYOt5zD
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76718491002032019i5f8ea947paa527988ddb7a378@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138964>

Hi,

On Wed, 3 Feb 2010, Jay Soffian wrote:

> Why does git rebase use format-patch + am, while rebase -i uses 
> cherry-pick?

Hysterical raisins. 'rebase -i' started out as 'edit-patch-series.sh', 
hacked together in 4 hours on a lazy Saturday afternoon:
http://colabti.org/irclogger/irclogger_log/git?date=2007-02-27#l97

Ah, the old days. Back when I had enough time to read through Peff's 
mails. And back when I had enough time to cobble together fun Git scripts.

> Just curious. In particular though, it seems especially odd in this 
> case:
> 
> $ git rebase --onto <newbase> <upstream>
> 
> vs
> 
> $ env GIT_EDITOR=true git rebase -i --onto <newbase> <upstream>
> 
> Both in theory produce an identical end-result, while using two
> different implementations.
> 
> (Here I'm setting GIT_EDITOR=true just to demonstrate that I didn't
> change the list of commits in the latter case.)

You can get _exactly_ the same behavior if you use -m.

Ciao,
Dscho
