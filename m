From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 15:16:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001141509230.3029@intel-tinevez-2-302>
References: <op.u6g8jnixg402ra@nb-04> <871vht7cs2.fsf@catnip.gol.com> <46a038f91001140544u64dd7eefn94625cdc40881cd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miles Bader <miles@gnu.org>,
	Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 15:17:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVQVS-0003fp-Vv
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 15:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab0ANOQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 09:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756787Ab0ANOQ6
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 09:16:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:60534 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756779Ab0ANOQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 09:16:57 -0500
Received: (qmail invoked by alias); 14 Jan 2010 14:16:56 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp072) with SMTP; 14 Jan 2010 15:16:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XuApMF5nXPN26mmdrYB5cejQqguKkdGAMRhgo4s
	OebVOqPlgpcgcn
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <46a038f91001140544u64dd7eefn94625cdc40881cd6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.70999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136993>

Hi,

On Thu, 14 Jan 2010, Martin Langhoff wrote:

> <wishlist>Can we take this further and say
> 
>  git push --make-a-new-repo-and-track-it --shared
> git+ssh://foo.bar/var/git/mynewthing.git master:master
> 
> ...?
> 
> </wishlist>

You mean just like http pushing?

> Of course it'd only work if you have full ssh access, unless the git 
> server learns a new command to mkdir (in sane and approved locations).

You mean a new "init" command a la "git --git-dir=bla.git init", which 
_does_ mkdir the directory.

Ciao,
Dscho
