From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] mergetool: clarify local/remote terminology
Date: Mon, 25 Feb 2008 14:21:06 -0500
Message-ID: <20080225192106.GB19666@sigill.intra.peff.net>
References: <1203570776-62019-1-git-send-email-jaysoffian@gmail.com> <76718490802250631p262baf1bw23873e5fdbbb7180@mail.gmail.com> <20080225184648.GC15131@sigill.intra.peff.net> <76718490802251107y44ff2d6ahf5446ae0408c67b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:22:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTitn-0002p4-9L
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 20:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729AbYBYTVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 14:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbYBYTVK
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 14:21:10 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4370 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755190AbYBYTVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 14:21:09 -0500
Received: (qmail 12183 invoked by uid 111); 25 Feb 2008 19:21:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 25 Feb 2008 14:21:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2008 14:21:06 -0500
Content-Disposition: inline
In-Reply-To: <76718490802251107y44ff2d6ahf5446ae0408c67b0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75051>

On Mon, Feb 25, 2008 at 02:07:11PM -0500, Jay Soffian wrote:

> I was playing with that, figuring out branch names in the same way that the
> code in bashcompletions computes ps1. However, what would you want to see if
> you're doing an interactive rebase of say HEAD vs HEAD~5. They are both the
> same branch, so what would you want to see?

Probably HEAD and HEAD~5 (perhaps along with their oneline logs). I
think the best we can do is "whatever the user said to get us here"
which is not something you can calculate after the fact; you have to
remember what the user said.

-Peff
