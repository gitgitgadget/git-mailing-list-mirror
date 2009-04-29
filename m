From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Cross-Platform Version Control (was: Eric Sink's blog - notes on git, dscms and a "whole product" approach)
Date: Wed, 29 Apr 2009 22:05:37 +0200
Message-ID: <200904292205.38530.markus.heidelberg@web.de>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <46a038f90904282355g43bf0cv909905f6028f054f@mail.gmail.com> <20090429072105.GD22593@coredump.intra.peff.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:05:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzG2N-0008HC-1a
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 22:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbZD2UFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 16:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbZD2UFk
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 16:05:40 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:46970 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbZD2UFk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 16:05:40 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id C8034FDE2F11;
	Wed, 29 Apr 2009 22:05:39 +0200 (CEST)
Received: from [89.59.108.55] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LzG2F-0008IW-00; Wed, 29 Apr 2009 22:05:39 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090429072105.GD22593@coredump.intra.peff.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19jhXrGvdlrl2reZ3YkUMQohGMlsjEjXM1i2XVd
	QaY0fFeew5cS/mAXH2WHkCOqzf95DAni2ApHB+BI+Y3qi4gimD
	HxhedyESbUUh50aWSr9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117934>

Jeff King, 29.04.2009:
> On Wed, Apr 29, 2009 at 08:55:29AM +0200, Martin Langhoff wrote:
> 
> > So from Eric's perspective, it is worthwhile to work on all those
> > issues, and get the right for the end user -- support things we don't
> > like, offer foolproof catches and warnings that prevent the user from
> > shooting their lovely toes off to mars, etc.
> 
> I read a few of his blog postings. He kept complaining about the
> features of git that I like the most. :)
> 
> I can see his arguments about how
> "add -p" can be dangerous

Actually, I don't see a very special case here with committing a never
compiled/tested worktree state. You can do this with every VCS (without
an index like git) with just selectively committing files instead of the
whole current worktree.

Markus
