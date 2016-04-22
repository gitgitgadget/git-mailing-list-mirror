From: Jeff King <peff@peff.net>
Subject: Re: issue upgrading git from 1.8.2.1 to 2.8.0
Date: Fri, 22 Apr 2016 19:14:52 -0400
Message-ID: <20160422231452.GA10905@sigill.intra.peff.net>
References: <CA+UAp04e9-CcUJ+2fheHGw1q6MS6smyHhvyw34NeoT7HbKgnnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gennaro Torre <gtorre@tumblr.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 01:15:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atkHx-00083l-0h
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 01:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbcDVXO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 19:14:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:54616 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753823AbcDVXOz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 19:14:55 -0400
Received: (qmail 1288 invoked by uid 102); 22 Apr 2016 23:14:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 19:14:54 -0400
Received: (qmail 12863 invoked by uid 107); 22 Apr 2016 23:14:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 19:14:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Apr 2016 19:14:52 -0400
Content-Disposition: inline
In-Reply-To: <CA+UAp04e9-CcUJ+2fheHGw1q6MS6smyHhvyw34NeoT7HbKgnnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292289>

On Fri, Apr 22, 2016 at 06:44:02PM -0400, Gennaro Torre wrote:

> When we upgraded to 2.8.0, all nodes received the upgrade.
> 
> We observed that when we tried to deploy code to the nodes (they run
> `git fetch` to update the repository) this would fail.

Did `git fetch` say anything interesting on stderr?

-Peff
