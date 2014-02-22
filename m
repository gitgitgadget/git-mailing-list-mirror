From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] config: teach "git config --file -" to read from the
 standard input
Date: Sat, 22 Feb 2014 03:37:44 -0500
Message-ID: <20140222083744.GG1576@sigill.intra.peff.net>
References: <1392764335-13274-1-git-send-email-kirill@shutemov.name>
 <1392764335-13274-4-git-send-email-kirill@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Sat Feb 22 09:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH85m-0001kT-Dr
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 09:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbaBVIhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 03:37:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:54950 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751484AbaBVIhq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 03:37:46 -0500
Received: (qmail 16819 invoked by uid 102); 22 Feb 2014 08:37:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Feb 2014 02:37:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Feb 2014 03:37:44 -0500
Content-Disposition: inline
In-Reply-To: <1392764335-13274-4-git-send-email-kirill@shutemov.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242509>

On Wed, Feb 19, 2014 at 12:58:55AM +0200, Kirill A. Shutemov wrote:

> The patch extends git config --file interface to allow read config from
> stdin.
> 
> Editing stdin or setting value in stdin is an error.
> 
> Include by absolute path is allowed in stdin config, but not by relative
> path.
> 
> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
> ---

This version of the series looks good to me.

-Peff
