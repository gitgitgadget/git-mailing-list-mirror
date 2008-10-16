From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Preserve file permissions on git-reflog expire
Date: Thu, 16 Oct 2008 14:34:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810161434220.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <48F629C2.70203@datacom.ind.br> <7v3aix4ud4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 14:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqRyv-0002ds-1c
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 14:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbYJPM2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 08:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbYJPM2O
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 08:28:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:59990 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753451AbYJPM2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 08:28:13 -0400
Received: (qmail invoked by alias); 16 Oct 2008 12:28:06 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 16 Oct 2008 14:28:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198NJpWrZt82DQdANk25gntSyFsE6/zRzpKYR1J10
	0/WmB+rPSlRsNG
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7v3aix4ud4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98375>

Hi,

On Wed, 15 Oct 2008, Junio C Hamano wrote:

> Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br> writes:
> 
> > samuel@erdinger:~/myrepo$ git push 
> > Counting objects: 5, done.
> > Compressing objects: 100% (3/3), done.
> > Unpacking objects: 100% (3/3), done.
> > Writing objects: 100% (3/3), 295 bytes, done.
> > Total 3 (delta 2), reused 0 (delta 0)
> > error: Unable to append to logs/refs/heads/master: Permission denied 
> > To /remote/myrepo/
> > ! [remote rejected] master -> master (failed to write)
> > error: failed to push some refs to '/remote/myrepo/' 
> 
> Thanks for a reproduction recipe.  I think an abbreviated version of this
> would deserve to be in the commit log message proper.

Or as a test script.

Ciao,
Dscho
