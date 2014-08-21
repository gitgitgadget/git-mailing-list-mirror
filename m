From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2014, #03; Wed, 20)
Date: Thu, 21 Aug 2014 04:19:17 -0400
Message-ID: <20140821081917.GA16137@peff.net>
References: <xmqqlhqisqcy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 10:19:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKNah-0002lF-6Q
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 10:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbaHUITV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 04:19:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:56076 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753614AbaHUITT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 04:19:19 -0400
Received: (qmail 5249 invoked by uid 102); 21 Aug 2014 08:19:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Aug 2014 03:19:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2014 04:19:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhqisqcy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255600>

On Wed, Aug 20, 2014 at 04:17:33PM -0700, Junio C Hamano wrote:

> * br/http-init-fix (2014-08-18) 2 commits
>  - http: style fixes for curl_multi_init error check
>  - http.c: die if curl_*_init fails
> 
>  Needs S-o-b from peff for the topmost one.

What you have queued looks good. Please add in:

  Signed-off-by: Jeff King <peff@peff.net>

> * jn/header-dependencies (2014-08-10) 1 commit
>  - Update hard-coded header dependencies
> 
>  Needs further discussions on the list.

We could take Jonathan's patch in the meantime, which is a strict
improvement. I'll try to push the other part of the discussion forward.
If that reaches agreement quickly, we can do it instead of Jonathan's
patch rather than on top.

-Peff
