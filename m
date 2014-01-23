From: Jeff King <peff@peff.net>
Subject: Re: libz and RHEL 5.9 compile of Git
Date: Wed, 22 Jan 2014 20:45:04 -0500
Message-ID: <20140123014504.GE17254@sigill.intra.peff.net>
References: <1390406392415-7602374.post@n2.nabble.com>
 <52E02310.9090609@web.de>
 <1390426029203-7602400.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: salmansheikh <salmanisheikh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 02:45:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W69M2-0005la-2i
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 02:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbaAWBpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 20:45:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:37257 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752898AbaAWBpG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 20:45:06 -0500
Received: (qmail 6722 invoked by uid 102); 23 Jan 2014 01:45:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Jan 2014 19:45:06 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jan 2014 20:45:04 -0500
Content-Disposition: inline
In-Reply-To: <1390426029203-7602400.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240893>

On Wed, Jan 22, 2014 at 01:27:09PM -0800, salmansheikh wrote:

> Got it working but then I had some issues with the perl portions of the
> install and I subsequently thought I could eliminate those portions and
> tried setting export NO_PERL=1 and that installed everything else...and got
> pass this error but when I tried to checkout a git repository as follows, I
> get some remote helper error. Is that related to the perl parts of the git? 
> 
> git clone https://github.com/m-labs/migen.git
> Cloning into 'migen'...
> fatal: Unable to find remote helper for 'https'

Did you build with libcurl support? That's what all of the https code is
built on.

-Peff
