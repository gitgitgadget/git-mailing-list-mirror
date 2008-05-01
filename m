From: Jeff King <peff@peff.net>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 11:28:59 -0400
Message-ID: <20080501152859.GA11469@sigill.intra.peff.net>
References: <4819CF50.2020509@tikalk.com> <20080501144524.GA10876@sigill.intra.peff.net> <4819DCF1.7090504@tikalk.com> <4819E0AE.40602@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ittay Dror <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Thu May 01 17:29:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrajE-0004KW-30
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 17:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760592AbYEAP3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 11:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760511AbYEAP3A
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 11:29:00 -0400
Received: from peff.net ([208.65.91.99]:3197 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760434AbYEAP27 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 11:28:59 -0400
Received: (qmail 14122 invoked by uid 111); 1 May 2008 15:28:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 11:28:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 11:28:59 -0400
Content-Disposition: inline
In-Reply-To: <4819E0AE.40602@tikalk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80921>

On Thu, May 01, 2008 at 06:24:30PM +0300, Ittay Dror wrote:

> Btw, this happened to me in a real use case. I wanted to restructure a  
> source tree. So I put it under git and started to happily move things  
> around, always committing after a move. I thought that git will correctly 
> identify these moves and show me the differences I made after (in a 
> separate commit). But it doesn't, and now that I want to prepare a  
> summary of the changes I've made, I'm stuck with a huge diff that is hard 
> to make sense of.

If you have a specific case where you think renames should have been
detected but they weren't, by all means, please share it. It's possible
that there is a bug in the rename detection, or that the limits are not
set correctly, and we could improve it.

-Peff
