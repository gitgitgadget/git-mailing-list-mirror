From: Jeff King <peff@peff.net>
Subject: Re: It seems there is a very tight character count limit in
 .gitconfig
Date: Wed, 8 Jan 2014 02:16:06 -0500
Message-ID: <20140108071606.GA2859@sigill.intra.peff.net>
References: <CAFc+-Siu1nyBMWvUG52SXdoMPWE-NZ7GAjWe9C-W=z-MWnn5zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Li Zhang <zhanglii2011@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 08:16:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0nN7-0004yx-HI
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 08:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133AbaAHHQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 02:16:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:57024 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750790AbaAHHQI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 02:16:08 -0500
Received: (qmail 22427 invoked by uid 102); 8 Jan 2014 07:16:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jan 2014 01:16:08 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jan 2014 02:16:06 -0500
Content-Disposition: inline
In-Reply-To: <CAFc+-Siu1nyBMWvUG52SXdoMPWE-NZ7GAjWe9C-W=z-MWnn5zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240196>

On Wed, Jan 08, 2014 at 02:59:37PM +0800, Li Zhang wrote:

> I tried to add url xxx insteadof xxx in .gitconfig. If the length of
> url exceed 125, git will not work.
> I am using Ubuntu. The default version is 1.7.9.5. Maybe the latest
> version solve this already.

Yes, this was fixed in 0971e99 (Remove the hard coded length limit on
variable names in config files, 2012-09-30). Git v1.8.0.1 and higher
contain that commit.

-Peff
