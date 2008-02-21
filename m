From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] A test for commit --amend allowing changing of a very
 empty commit message
Date: Thu, 21 Feb 2008 20:57:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802212056320.17164@racer.site>
References: <20080221195438.GA6973@steel.home> <7vwsoyt5xt.fsf@gitster.siamese.dyndns.org> <20080221203506.GA20143@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:58:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSIUu-0000Jy-5d
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 21:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933688AbYBUU5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 15:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760867AbYBUU5h
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 15:57:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:49006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934326AbYBUU5f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 15:57:35 -0500
Received: (qmail invoked by alias); 21 Feb 2008 20:57:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 21 Feb 2008 21:57:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HNoJQgGJHggqsQzBJNhIVkesjiHORq5StXE+wuT
	TodqlTiMlccS8A
X-X-Sender: gene099@racer.site
In-Reply-To: <20080221203506.GA20143@steel.home>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74657>

Hi,

On Thu, 21 Feb 2008, Alex Riesen wrote:

> Junio C Hamano, Thu, Feb 21, 2008 21:23:10 +0100:
> > Alex Riesen <raa.lkml@gmail.com> writes:
> > >
> > > Well, it fails... In current master
> > 
> > Then please mark it with test_expect_failure.
> 
> That's because I expect it to be fixed (in the next mail)

AFAICT the preferred procedure is to add a patch demonstrating the 
failure, with test_expect_failure, and another patch fixing it, replacing 
the _failure with _success.

Ciao,
Dscho
