From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: add test case for using tag object as a final ref
Date: Wed, 18 Nov 2015 01:00:18 -0500
Message-ID: <20151118060018.GA22541@sigill.intra.peff.net>
References: <1447824992-28520-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 07:00:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zyvn8-0001Rx-MW
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 07:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbbKRGAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 01:00:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:59179 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750783AbbKRGAV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 01:00:21 -0500
Received: (qmail 21516 invoked by uid 102); 18 Nov 2015 06:00:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Nov 2015 00:00:21 -0600
Received: (qmail 2500 invoked by uid 107); 18 Nov 2015 06:00:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Nov 2015 01:00:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Nov 2015 01:00:18 -0500
Content-Disposition: inline
In-Reply-To: <1447824992-28520-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281441>

On Wed, Nov 18, 2015 at 07:36:32AM +0200, Max Kirillov wrote:

> It was discovered [1] that 1b0d40000a broke blaming starting from tag object.
> Add test which verifies such blaming works.
> 
> [1] http://mid.gmane.org/20151117224809.GE27862@sigill.intra.peff.net
> 
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> Thank you. Sorry, I should have noticed that obj ended up unused.

Thanks. Do you mind if I just squash this into the patch with the fix?

-Peff
