From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix to push --progress. The --progress flag was not
 being passed into tranport.c from send-pack.h, making the --progress flag
 unusable
Date: Wed, 13 Oct 2010 13:55:08 -0400
Message-ID: <20101013175508.GA14035@sigill.intra.peff.net>
References: <AANLkTin9_kofdy49WF4V_JoovVR+G8DN7vn-cz3p84fz@mail.gmail.com>
 <7vr5fum19m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chase Brammer <cbrammer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 19:55:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P65Xg-00035v-36
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab0JMRyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 13:54:47 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:42493 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab0JMRyq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 13:54:46 -0400
Received: (qmail 725 invoked by uid 111); 13 Oct 2010 17:54:46 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.167)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 13 Oct 2010 17:54:46 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Oct 2010 13:55:08 -0400
Content-Disposition: inline
In-Reply-To: <7vr5fum19m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158954>

On Wed, Oct 13, 2010 at 10:49:09AM -0700, Junio C Hamano wrote:

> Chase Brammer <cbrammer@gmail.com> writes:
> 
> > The result of this is external tools and tools writing standard error
> 
> Thanks for leaving a record in the list archive, but (1) what Jonathan
> said, plus (2) Please do something about that overlong Subject: line.

Actually, I was initially trying to foist testing and patch submission
off on somebody else because I didn't want to spend more time on it. But
I ended up doing it anyway, and I think I will have a two-patch series.
This one (with tests), and one to make --no-progress. I'll try to work
it up this afternoon.

-Peff
