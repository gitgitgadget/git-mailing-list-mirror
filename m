From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 1/2] format-patch: demonstrate that color.ui=always
 produces colorized patches
Date: Mon, 12 Sep 2011 12:58:11 -0400
Message-ID: <20110912165811.GB8054@sigill.intra.peff.net>
References: <1315843016-10959-1-git-send-email-pangyanhan@gmail.com>
 <1315843016-10959-2-git-send-email-pangyanhan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	martin.von.zweigbergk@gmail.com, sdaoden@googlemail.com,
	ib@wupperonline.de
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 12 18:58:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R39ps-0004L8-Ch
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 18:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234Ab1ILQ6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 12:58:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42803
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755884Ab1ILQ6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 12:58:13 -0400
Received: (qmail 16193 invoked by uid 107); 12 Sep 2011 16:59:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Sep 2011 12:59:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2011 12:58:11 -0400
Content-Disposition: inline
In-Reply-To: <1315843016-10959-2-git-send-email-pangyanhan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181223>

On Mon, Sep 12, 2011 at 11:56:55PM +0800, Pang Yan Han wrote:

> Hi, I don't know if I actually understand the naming convention for tests
> correctly here, so I used the next available number for the last 2 digits.
> 
>  t/t4051-format-patch-color.sh |   23 +++++++++++++++++++++++

Usually we would try to keep format-patch tests clustered numerically,
but it seems the t40* space has gotten quite filled up and fragmented.
So I think where you added it is fine (and if somebody cares to
reorganize tests, they can do so later).

Often if there is only one or two tests to add, it is more logical to
add to an existing script. However, I think in this case, starting a new
script to check how format-patch handles various config features
(including color) makes sense. Maybe it makes sense to call it
"format-patch-config" instead, and set the description to something like
"check that format-patch does not respect porcelain config".

-Peff
