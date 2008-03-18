From: Jeff King <peff@peff.net>
Subject: Re: Unresolved issues
Date: Mon, 17 Mar 2008 21:26:24 -0400
Message-ID: <20080318012624.GA5307@coredump.intra.peff.net>
References: <7v7ig096ot.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 02:27:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbQbd-0002Uc-Br
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 02:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbYCRB03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 21:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbYCRB03
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 21:26:29 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4593 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331AbYCRB02 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 21:26:28 -0400
Received: (qmail 17151 invoked by uid 111); 18 Mar 2008 01:26:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Mar 2008 21:26:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Mar 2008 21:26:24 -0400
Content-Disposition: inline
In-Reply-To: <7v7ig096ot.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77477>

On Mon, Mar 17, 2008 at 06:12:02PM -0700, Junio C Hamano wrote:

> * "[alias] st = status" and "cd .git && git st" (Jeff King)
>   $gmane/72327
> 
>   This shows everything as deleted, I believe it hasn't resolved.  I am
>   not sure if this is worth resolving, though.

I started on a patch for this, but got mired in trying to clean up the
worktree handling in this area, which is quite confusing and fragile. I
have a suspicion that Duy's recent patch series will impact this, but I
haven't had time yet to review that carefully.

-Peff
