From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Add platform-independent .git "symlink"
Date: Mon, 18 Feb 2008 11:45:58 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181144270.30505@racer.site>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com>  <1203286456-26033-2-git-send-email-hjemli@gmail.com>  <7v7ih2u8e1.fsf@gitster.siamese.dyndns.org> <8c5c35580802180035q3d914720x54aa7e32d6e82108@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 12:46:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR4SN-0005Qf-EB
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 12:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252AbYBRLqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 06:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756747AbYBRLqM
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 06:46:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:60416 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753189AbYBRLqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 06:46:11 -0500
Received: (qmail invoked by alias); 18 Feb 2008 11:46:09 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp042) with SMTP; 18 Feb 2008 12:46:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/et7s9lBTeuwajVItD4V36Q7acK3GNx3jsZHbMrd
	L6lK7U7ot0dQPp
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580802180035q3d914720x54aa7e32d6e82108@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74267>

Hi,

On Mon, 18 Feb 2008, Lars Hjemli wrote:

> On Feb 18, 2008 6:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Lars Hjemli <hjemli@gmail.com> writes:
> >
> > > +/*
> > > +     if (!is_git_directory(buf + 8))
> > > +             return NULL;
> > > +*/
> >
> > Likewise.
> 
> True, I'll uncomment and die().

Hmm.  From check_repository_format_gently():

		if (!nongit_ok)
                        die ("...")
		warning("Expected git repo version <= %d...");

I think we want that, too.  (die() when !nongit_ok, but warn otherwise)

Ciao,
Dscho
