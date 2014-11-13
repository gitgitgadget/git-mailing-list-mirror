From: Jens Stimpfle <debian@jstimpfle.de>
Subject: Re: [PATCH] git-send-email.perl: Fix handling of suppresscc option.
Date: Thu, 13 Nov 2014 12:41:04 +0100
Message-ID: <20141113114104.GA27098@jstimpfle.de>
References: <1415801891-28471-1-git-send-email-debian@jstimpfle.de>
 <xmqqoasc46ph.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 12:42:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XosnB-0002kY-Ba
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 12:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbaKMLmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 06:42:19 -0500
Received: from jstimpfle.de ([85.214.245.181]:49273 "EHLO
	h1929017.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932730AbaKMLlI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 06:41:08 -0500
Received: from jfs by h1929017.stratoserver.net with local (Exim 4.80)
	(envelope-from <debian@jstimpfle.de>)
	id 1Xosls-00073j-UZ; Thu, 13 Nov 2014 12:41:04 +0100
Content-Disposition: inline
In-Reply-To: <xmqqoasc46ph.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, thanks for reviewing.

On Wed, Nov 12, 2014 at 10:25:14AM -0800, Junio C Hamano wrote:
> "When I say addresses on Cc: does not matter, it doesn't.  No matter
> what the address in question is" (likewise for S-o-b:) is what the
> updated logic says.  It is easier to explain than the traditional
> "The way to squelch my address is by 'suppress self'; for all other
> addresses on Cc:/S-o-b:, there are separate suppression methods".
> 
> But I have a slight suspicion that this special casing of 'self' was
> done on purpose, and people may be relying on it.

It seems the behaviour is exactly described in the manpage. Sorry for
having missed that.

The behaviour is super-complex and confusing, though. It's easy to
imagine much simpler, intuitive and "transparent" ones.

But I have no experience with distributed git workflows so I'm
absolutely not in the position to call it broken or provide a "fix".

Sorry for the noise.
