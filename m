From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] peel_onion(): add support for <rev>^{tag}
Date: Tue, 3 Sep 2013 13:46:04 -0400
Message-ID: <20130903174604.GD1050@sigill.intra.peff.net>
References: <1378229853-21236-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:46:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGug9-0004EL-OI
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757833Ab3ICRqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:46:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:57046 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694Ab3ICRqH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:46:07 -0400
Received: (qmail 18115 invoked by uid 102); 3 Sep 2013 17:46:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 12:46:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 13:46:04 -0400
Content-Disposition: inline
In-Reply-To: <1378229853-21236-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233753>

On Tue, Sep 03, 2013 at 01:37:33PM -0400, Richard Hansen wrote:

> ---
> Changes since v2 (2013-09-02, see
> <http://thread.gmane.org/gmane.comp.version-control.git/233598>):
>   * add a test case (hopefully I didn't go overboard)

Personally I was thinking just

  test_must_fail git rev-parse HEAD^{tag} &&
  git rev-parse commit-tag >expect &&
  git rev-parse commit-tag^{tag} >actual &&
  test_cmp expect actual

but I do not think it hurts to be more thorough.

Thanks, this version of the patch looks ready to me.

-Peff
