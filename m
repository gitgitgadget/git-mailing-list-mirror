From: Jeff King <peff@peff.net>
Subject: Re: Certificate validation vulnerability in Git
Date: Sun, 24 Feb 2013 22:18:47 -0500
Message-ID: <20130225031847.GB31988@sigill.intra.peff.net>
References: <CAA5xPpmmZuMK7q3-pTOx4L6DxFtyw5HWYdH7kHEsK=96KM5kAQ@mail.gmail.com>
 <512A601B.80807@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zubin Mithra <zubin.mithra@gmail.com>, git@vger.kernel.org,
	"Dhanesh K." <dhanesh1428@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Feb 25 04:19:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9oav-0005qC-M7
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 04:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759579Ab3BYDSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 22:18:49 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59601 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759553Ab3BYDSt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 22:18:49 -0500
Received: (qmail 12292 invoked by uid 107); 25 Feb 2013 03:20:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Feb 2013 22:20:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2013 22:18:47 -0500
Content-Disposition: inline
In-Reply-To: <512A601B.80807@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217025>

On Sun, Feb 24, 2013 at 07:46:51PM +0100, Andreas Ericsson wrote:

> The lack of certificate authority verification presents no attack vector
> for git imap-send. As such, it doesn't warrant a CVE. I'm sure you'll
> be credited with a "reported-by" line in the commit message if someone
> decides to fix it though. Personally, I'm not fussed.

Sure it presents an attack vector. I can man-in-the-middle your
imap-send client and read your otherwise secret patches. Or your
otherwise secret imap password.

-Peff
