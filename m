From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] hard-code the empty tree object
Date: Fri, 15 Feb 2008 13:25:42 -0500
Message-ID: <20080215182542.GA25167@sigill.intra.peff.net>
References: <20080214103256.GA17951@coredump.intra.peff.net> <7vabm2i1pf.fsf@gitster.siamese.dyndns.org> <20080215172043.GA24221@sigill.intra.peff.net> <7vhcgaglq5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kate Rhodes <masukomi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 19:26:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ5GL-0003me-PA
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 19:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbYBOSZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 13:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755844AbYBOSZp
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 13:25:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3107 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755695AbYBOSZo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 13:25:44 -0500
Received: (qmail 24675 invoked by uid 111); 15 Feb 2008 18:25:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 15 Feb 2008 13:25:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Feb 2008 13:25:42 -0500
Content-Disposition: inline
In-Reply-To: <7vhcgaglq5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73971>

On Fri, Feb 15, 2008 at 09:42:26AM -0800, Junio C Hamano wrote:

> > Should I re-send, or do you want to just markup the existing patches?
> 
> Shouldn't the previous one that uses the hardcoded empty tree
> object name good enough that is already on 'pu'?

Yes, they are fine (I hadn't looked at them that carefully before, but
it looks like you cleaned up the ordering sensibly already).

The last paragraph in the commit message of the add--interactive patch
should be removed (the implementation is no longer "hack-ish").

-Peff
