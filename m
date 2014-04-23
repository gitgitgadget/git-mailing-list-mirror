From: Jeff King <peff@peff.net>
Subject: Re: Pack bitmaps on Git for Windows
Date: Wed, 23 Apr 2014 02:32:51 -0400
Message-ID: <20140423063251.GA20675@sigill.intra.peff.net>
References: <CAGyf7-Go55mJashAi7v5zAdyeUJp2fziwjVHyPxRONZhqr18wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 08:32:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcqjq-00067x-J3
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 08:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbaDWGcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 02:32:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:36612 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753363AbaDWGcx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 02:32:53 -0400
Received: (qmail 18508 invoked by uid 102); 23 Apr 2014 06:32:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Apr 2014 01:32:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2014 02:32:51 -0400
Content-Disposition: inline
In-Reply-To: <CAGyf7-Go55mJashAi7v5zAdyeUJp2fziwjVHyPxRONZhqr18wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246810>

On Tue, Apr 22, 2014 at 05:58:10PM +1000, Bryan Turner wrote:

> It looks like the documentation for bitmaps is being included in the
> 1.9.2 release of Git for Windows but the functionality itself is not
> present. For example, doc\git\html\git-config.html includes settings
> like these:
> 
> pack.useBitmaps

I think this is a documentation problem with Git for Windows. The bitmap
code is going into v2.0, but there should be nothing (not even
documentation) in v1.9.2. I don't know how the msysgit folks build their
documentation, but I wonder if it accidentally built from current
'master' rather than v1.9.2.

You might get more information at the msysgit mailing list:

  https://groups.google.com/forum/#!forum/msysgit

-Peff
