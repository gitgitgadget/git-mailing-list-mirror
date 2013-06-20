From: Jeff King <peff@peff.net>
Subject: [PATCHv3 0/2] pull into unborn branch safety tree
Date: Thu, 20 Jun 2013 18:35:50 -0400
Message-ID: <20130620223550.GA21667@sigill.intra.peff.net>
References: <20130620124758.GA2376@sigill.intra.peff.net>
 <aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
 <7v8v24vd0m.fsf@alter.siamese.dyndns.org>
 <20130620201957.GC31364@sigill.intra.peff.net>
 <7vmwqkqzhy.fsf@alter.siamese.dyndns.org>
 <20130620205533.GA8074@sigill.intra.peff.net>
 <7v7ghoqwwv.fsf@alter.siamese.dyndns.org>
 <20130620220328.GA3992@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 00:36:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpnSR-0005mn-9m
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 00:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103Ab3FTWfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 18:35:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:60514 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161077Ab3FTWfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 18:35:54 -0400
Received: (qmail 17813 invoked by uid 102); 20 Jun 2013 22:36:54 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 17:36:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 18:35:50 -0400
Content-Disposition: inline
In-Reply-To: <20130620220328.GA3992@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228550>

On Thu, Jun 20, 2013 at 06:03:28PM -0400, Jeff King wrote:

> OK. I'll prepare a series with both patches. Stand by...

Here it is:

  [1/2]: pull: update unborn branch tip after index
  [2/2]: pull: merge into unborn by fast-forwarding from empty tree

The first one is mine. The second is Thomas's v2, rebased on top of
mine. I also added a note to the commit message explaining the resulting
index state and lack of conflicts.

-Peff
