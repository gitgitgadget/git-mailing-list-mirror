From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/14] resumable network bundles
Date: Thu, 10 Nov 2011 02:45:27 -0500
Message-ID: <20111110074527.GA27938@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:45:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPKJ-0001IT-LD
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757432Ab1KJHpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:45:31 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38905
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757403Ab1KJHpa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:45:30 -0500
Received: (qmail 22098 invoked by uid 107); 10 Nov 2011 07:45:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:45:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:45:28 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185197>

On Thu, Nov 10, 2011 at 02:43:30AM -0500, Jeff King wrote:

>   [01/14]: t/lib-httpd: check for NO_CURL
>   [02/14]: http: turn off curl signals
>   [03/14]: http: refactor http_request function
>   [04/14]: http: add a public function for arbitrary-callback request
>   [05/14]: remote-curl: use http callback for requesting refs
>   [06/14]: transport: factor out bundle to ref list conversion
>   [07/14]: bundle: add is_bundle_buf helper
>   [08/14]: remote-curl: free "discovery" object
>   [09/14]: remote-curl: auto-detect bundles when fetching refs
>   [10/14]: remote-curl: try base $URL after $URL/info/refs
>   [11/14]: progress: allow pure-throughput progress meters
>   [12/14]: remote-curl: show progress for bundle downloads
>   [13/14]: remote-curl: resume interrupted bundle transfers
>   [14/14]: clone: give advice on how to resume a failed clone

I forgot to mention: this goes on top of mf/curl-select-fdset. It's only
in next now, but some of my http cleanups build semantically on the
cleanups in that topic.

-Peff
