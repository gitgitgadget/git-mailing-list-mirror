From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 2/3] travis-ci: disable verbose test output
Date: Thu, 26 May 2016 00:54:55 -0400
Message-ID: <20160526045455.GD6756@sigill.intra.peff.net>
References: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com>
 <1463914856-64745-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Thu May 26 06:55:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5nK4-0003wn-7q
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 06:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbcEZEy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 00:54:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:44455 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750714AbcEZEy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 00:54:58 -0400
Received: (qmail 6206 invoked by uid 102); 26 May 2016 04:54:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 00:54:58 -0400
Received: (qmail 16948 invoked by uid 107); 26 May 2016 04:55:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 00:55:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 00:54:55 -0400
Content-Disposition: inline
In-Reply-To: <1463914856-64745-3-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295631>

On Sun, May 22, 2016 at 01:00:55PM +0200, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> The verbose output clutters the Travis CI webview and is not really
> useful since test debugging usually happens on a local machine.

I have not really been using the Travis CI results, so perhaps my
opinion does not count. But in other systems, I have found that the more
verbose the CI output, the better, simply because you will inevitably be
faced with a test that breaks on CI and not your local machine, and you
will have no way to get more details.

I don't know if Travis provides a better way to hide the output in the
non-failing cases.

-Peff
