From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Wed, 10 Apr 2013 00:18:52 -0400
Message-ID: <20130410041852.GC795@sigill.intra.peff.net>
References: <CAAvHm8NV4OD+QqVp-7oOzsSdAwten6gTpfUFfi85jv_VQ3soFA@mail.gmail.com>
 <1365555308-611-1-git-send-email-jkoleszar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: John Koleszar <jkoleszar@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 06:19:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPmUx-0001JY-6t
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 06:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab3DJES7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 00:18:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37084 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707Ab3DJES6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 00:18:58 -0400
Received: (qmail 31986 invoked by uid 107); 10 Apr 2013 04:20:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 00:20:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 00:18:52 -0400
Content-Disposition: inline
In-Reply-To: <1365555308-611-1-git-send-email-jkoleszar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220659>

On Tue, Apr 09, 2013 at 05:55:08PM -0700, John Koleszar wrote:

> Filter the list of refs returned via the dumb HTTP protocol according
> to the active namespace, consistent with other clients of the
> upload-pack service.

Thanks, this version looks good to me.

> Updates to generate HEAD. Drops my original tests, since they were under the
> flawed assumption that both the dumb and smart protocols produced the same
> ref advertisement at /info/refs.

Yeah, your new tests look good, and I think exercise the feature well.

-Peff
