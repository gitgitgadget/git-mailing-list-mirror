From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Thu, 25 Aug 2011 17:06:54 -0400
Message-ID: <20110825210654.GA11077@sigill.intra.peff.net>
References: <20110825200001.GA6165@sigill.intra.peff.net>
 <20110825204047.GA9948@sigill.intra.peff.net>
 <CAPig+cQ33PESWC5fzN8enLFRwNPx8o+PgRUTeCva4dSJ_EdwOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 23:07:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwh8j-0006T4-F2
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 23:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab1HYVG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 17:06:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36710
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755381Ab1HYVG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 17:06:57 -0400
Received: (qmail 19370 invoked by uid 107); 25 Aug 2011 21:07:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 17:07:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 17:06:54 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQ33PESWC5fzN8enLFRwNPx8o+PgRUTeCva4dSJ_EdwOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180117>

On Thu, Aug 25, 2011 at 05:00:51PM -0400, Eric Sunshine wrote:

> > Also, any other extensions that would go into such a list? I have no
> > idea what the common extension is for something like pascal or csharp.
> 
> C# uses extension ".cs".
> 
> ".cpp" is common, in fact often required, by Windows compilers.

Thanks, added both to my list.

> What about ".h" and ".hpp"?

How well do our cpp patterns do with header files? I imagine they're
better than the default, but I don't think I've ever really tried
anything tricky.

-Peff
