From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Kill bashizm in t/t3200-branch.sh and t/t7201-co.sh.
Date: Thu, 10 Apr 2008 04:11:09 -0400
Message-ID: <20080410081108.GA15858@sigill.intra.peff.net>
References: <20080410072500.GA10188@mysza.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Adam Golebiowski <adamg@pld-linux.org>
X-From: git-owner@vger.kernel.org Thu Apr 10 10:12:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjrsy-0004y0-Sk
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 10:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbYDJILN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 04:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbYDJILN
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 04:11:13 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2304 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbYDJILM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 04:11:12 -0400
Received: (qmail 23169 invoked by uid 111); 10 Apr 2008 08:11:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 10 Apr 2008 04:11:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Apr 2008 04:11:09 -0400
Content-Disposition: inline
In-Reply-To: <20080410072500.GA10188@mysza.eu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79193>

On Thu, Apr 10, 2008 at 09:25:00AM +0200, Adam Golebiowski wrote:

> -    '!(git branch --track my10 HEAD^)'
> +    '! git branch --track my10 HEAD^'

These should probably be using the new test_must_fail instead of '!'
anyway.

-Peff
