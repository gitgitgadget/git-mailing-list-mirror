From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Thu, 22 Jan 2009 01:13:32 +0100
Message-ID: <200901220113.32711.markus.heidelberg@web.de>
References: <20090117153846.GB27071@coredump.intra.peff.net> <200901212335.24727.markus.heidelberg@web.de> <20090122000026.GB9668@sigill.intra.peff.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 01:15:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPnDt-0000Wg-JW
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 01:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbZAVANY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 19:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753913AbZAVANY
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 19:13:24 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:60627 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbZAVANX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 19:13:23 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 39D6FFC1191A;
	Thu, 22 Jan 2009 01:13:22 +0100 (CET)
Received: from [89.59.73.85] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LPnCE-0000N5-00; Thu, 22 Jan 2009 01:13:22 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20090122000026.GB9668@sigill.intra.peff.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/3zG+jfIwnu0QjgZ1qOlAij+3HzhOQKpEJ1wdH
	kVUNy1WB3fY8G8n7+jPQP9REdjglWfdk28QU6P+cToznVcd7RG
	+prEFEIB021GKgVr3N5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106707>

Jeff King, 22.01.2009:
> On Wed, Jan 21, 2009 at 11:35:24PM +0100, Markus Heidelberg wrote:
> 
> > > properly initialized (or finalized).
> > > 
> > > So I think it makes more sense to record each config value, and then
> > > check a _function_ that does the right thing. I.e., you end up with
> > > something like:
> > >
> > > [example code snipped]
> > 
> > That would probably be better.
> 
> Do you want to work on it, or should it go into the "yeah, right, one
> day" section of my todo list?

Yes, feel free to enlarge your todo list :)
There are some other things that I want to work on before, so better
don't count on me for this. But maybe I'll come up to it, before your
todo list pointer reaches this item, who knows.

Markus
