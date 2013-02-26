From: Jeff King <peff@peff.net>
Subject: Re: two-way merge corner case bug
Date: Tue, 26 Feb 2013 15:18:20 -0500
Message-ID: <20130226201820.GD13830@sigill.intra.peff.net>
References: <7v7glun8kt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:18:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAQzE-0003mw-FJ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 21:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757797Ab3BZUS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 15:18:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33234 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757589Ab3BZUSY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 15:18:24 -0500
Received: (qmail 10239 invoked by uid 107); 26 Feb 2013 20:19:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Feb 2013 15:19:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2013 15:18:20 -0500
Content-Disposition: inline
In-Reply-To: <7v7glun8kt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217176>

On Tue, Feb 26, 2013 at 12:06:42PM -0800, Junio C Hamano wrote:

> It seems that we have a corner case bug in two-way merge to reset
> away the conflicts with "read-tree -u --reset HEAD ORIG_HEAD".

Isn't this a repeat of:

  http://thread.gmane.org/gmane.comp.version-control.git/202440/focus=212316

whose fix never got finalized? It's on my todo list, but it seems that
items keep sinking further down on that list, rather than getting
completed. :-/

-Peff
