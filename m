From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of
 a config value
Date: Mon, 8 Feb 2016 07:12:49 -0500
Message-ID: <20160208121249.GC24217@sigill.intra.peff.net>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
 <20160205112001.GA13397@sigill.intra.peff.net>
 <56B48803.9080909@gmail.com>
 <20160205135855.GA19154@sigill.intra.peff.net>
 <278405D6-873C-4E73-965B-543D66A893D7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 13:13:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSkgc-0001Gn-QV
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 13:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbcBHMMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 07:12:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:39143 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751881AbcBHMMv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 07:12:51 -0500
Received: (qmail 24156 invoked by uid 102); 8 Feb 2016 12:12:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 07:12:52 -0500
Received: (qmail 4426 invoked by uid 107); 8 Feb 2016 12:12:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 07:12:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 07:12:49 -0500
Content-Disposition: inline
In-Reply-To: <278405D6-873C-4E73-965B-543D66A893D7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285759>

On Sun, Feb 07, 2016 at 08:44:50PM +0100, Lars Schneider wrote:

> > Are there any other reasons why current_config_filename() would return
> > NULL, besides command-line config? I don't think so. It looks like we
> > can read config from stdin, but we use the token "<stdin>" there for the
> > name field (another ambiguity!).
> During my testing I haven't found any other case either. To be honest
> I didn't know the "stdin" way to set the config! I added a test case for 
> that, too!

I didn't remember it either, until I peeked at the code trying to answer my
own question. Ironically, I appear to have been involved in reviewing
the patches that added it. :-/

-Peff
