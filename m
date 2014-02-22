From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] rename STATUS_FORMAT_NONE to STATUS_FORMAT_DEFAULT
Date: Sat, 22 Feb 2014 03:24:19 -0500
Message-ID: <20140222082418.GD1576@sigill.intra.peff.net>
References: <1393009762-31133-1-git-send-email-rctay89@gmail.com>
 <1393009762-31133-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 22 09:24:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH7tB-0006RL-Rj
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 09:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbaBVIYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 03:24:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:54936 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750736AbaBVIYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 03:24:21 -0500
Received: (qmail 16150 invoked by uid 102); 22 Feb 2014 08:24:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Feb 2014 02:24:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Feb 2014 03:24:19 -0500
Content-Disposition: inline
In-Reply-To: <1393009762-31133-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242506>

On Sat, Feb 22, 2014 at 03:09:20AM +0800, Tay Ray Chuan wrote:

> In f3f47a1 (status: add --long output format option), STATUS_FORMAT_NONE
> was introduced, meaning "the user did not specify anything". Rename this
> to *_DEFAULT to better indicate its meaning.

Hmm. We later introduced STATUS_FORMAT_UNSPECIFIED in 84b4202d. It seems
like that is the same thing as the _DEFAULT you are proposing here. Can
we collapse them into a single value?

-Peff
