From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can I prevent someone clone my git repository?
Date: Thu, 8 Jan 2009 15:42:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901081541041.30769@pacific.mpi-cbg.de>
References: <856bfe0e0901072303i4fcd3bf6u99790ab9f4170937@mail.gmail.com> <7vr63e42ke.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901081227170.30769@pacific.mpi-cbg.de> <20090108143257.GX21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Emily Ren <lingyan.ren@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 15:42:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKw5r-0007Ma-BC
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 15:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760241AbZAHOlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 09:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760178AbZAHOlW
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 09:41:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:58857 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760290AbZAHOlV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 09:41:21 -0500
Received: (qmail invoked by alias); 08 Jan 2009 14:41:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 08 Jan 2009 15:41:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18psqRx+uApFl2N+02hb/14LtQmZAyUrFYhBbb0+9
	0Jvxz5YvUaj+rS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090108143257.GX21154@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104922>

Hi,

On Thu, 8 Jan 2009, Miklos Vajna wrote:

> On Thu, Jan 08, 2009 at 12:27:59PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > like git://your-host/repository.git
> > 
> > If the people are on different IPs, a hook can restrict who may clone, 
> > since commit v1.6.1-rc1~109.
> 
> Hmm, but I think there is no hook called "pre-send" or so that could 
> return status code 1 to prevent receiving, so that commit on its own 
> does not does what Emily needs here.

Oops.  I assumed there is a pre-upload hook, but apparently I was wrong.

Would be easy to introduce that hook, though...

Ciao,
Dscho
