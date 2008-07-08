From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/6] revisions: refactor init_revisions and
 setup_revisions.
Date: Tue, 8 Jul 2008 12:59:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807081258010.4319@eeepc-johanness>
References: <1215510964-16664-1-git-send-email-madcoder@debian.org> <1215510964-16664-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, torvalds@linux-foundation.org,
	gitster@pobox.com, peff@peff.net
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 13:00:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGAvx-00010Q-5W
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 13:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbYGHK7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 06:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbYGHK7f
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 06:59:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:54783 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751656AbYGHK7f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 06:59:35 -0400
Received: (qmail invoked by alias); 08 Jul 2008 10:59:32 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp061) with SMTP; 08 Jul 2008 12:59:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18X1rl6gygX+rIqSLIckvlz2/hqY4kvWM6AqogRa4
	ftOKb4X8m7YcWa
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1215510964-16664-2-git-send-email-madcoder@debian.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87746>

Hi,

On Tue, 8 Jul 2008, Pierre Habouzit wrote:

> setup_revisions has been split in two: parse_revisions that does 
> (almost) only argument parsing, to be more like what parse-options can 
> do, and setup_revisions that does the rest.

I do not see the sense of this change, except

- blowing up your patch unnecessarily,
- making it more inconvenient for users, and
- adding an opportunity for bugs to creep in.

In other words, I would like to see the semantics of setup_revisions() 
untouched.

Ciao,
Dscho
