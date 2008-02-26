From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] help: respect aliases
Date: Tue, 26 Feb 2008 15:15:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802261515210.22527@racer.site>
References: <cover.1203890846.git.peff@peff.net>  <20080224221737.GD31309@coredump.intra.peff.net>  <76718490802241810m5f473156nc350eea07016e8f9@mail.gmail.com>  <alpine.LSU.1.00.0802261222570.17164@racer.site>
 <76718490802260656s459e9241ie2a2d6b255c77fa4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 16:18:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU1YJ-00086D-BW
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 16:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110AbYBZPQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 10:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754982AbYBZPQF
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 10:16:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:41201 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753785AbYBZPQE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 10:16:04 -0500
Received: (qmail invoked by alias); 26 Feb 2008 15:16:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 26 Feb 2008 16:16:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VEiYThBfVBlLVceNEzomqJjmfaJXDnQbnPX1bpr
	9y6wfEpoyYNlIr
X-X-Sender: gene099@racer.site
In-Reply-To: <76718490802260656s459e9241ie2a2d6b255c77fa4@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75144>

Hi,

On Tue, 26 Feb 2008, Jay Soffian wrote:

> On Tue, Feb 26, 2008 at 7:43 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> >  On Sun, 24 Feb 2008, Jay Soffian wrote:
> >
> >  > This too would be less ugly as a built-in:
> >  >
> >  >  [elided so as not to burn anyone's eyes out again :-) -- jay]
> >
> >  Wow.  This would look less ugly as an alias like this, too:
> >
> >  alias = "!sh -c 'case $# in \
> >         0) git config --get-regexp \"^alias\\.\" | sed \"s/^alias\\.//\";; \
> >         *) git config \"alias.$0\" ;; \
> >         esac'"
> >
> >  which incidentally fixes a bug in your alias: you ignore $0 which is the
> >  first parameter when using the sh -c '' idiom.
> 
> Test mine. Test yours. See which works. :-)

I tested only mine.  It works.

Ciao,
Dscho
