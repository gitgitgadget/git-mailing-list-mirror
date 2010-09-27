From: Jeff King <peff@peff.net>
Subject: Re: A sudden lack of permission
Date: Mon, 27 Sep 2010 12:22:36 -0400
Message-ID: <20100927162235.GA10575@sigill.intra.peff.net>
References: <4CA0AFC4.1060001@llaisdy.com>
 <20100927160759.GB10256@sigill.intra.peff.net>
 <4CA0C36B.5000708@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 18:22:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0GTW-0003hT-4u
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 18:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933189Ab0I0QWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 12:22:40 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57856 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759161Ab0I0QWj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 12:22:39 -0400
Received: (qmail 17735 invoked by uid 111); 27 Sep 2010 16:22:39 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 27 Sep 2010 16:22:39 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Sep 2010 12:22:36 -0400
Content-Disposition: inline
In-Reply-To: <4CA0C36B.5000708@llaisdy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157349>

On Mon, Sep 27, 2010 at 05:16:43PM +0100, Ivan Uemlianin wrote:

> Thanks for your help.
> 
> Yes, I can ssh onto the server, cd to /var/www/git/my_repos.git and
> add, edit files, etc.

Did you check specifically the /var/www/git/my_repos.git/objects
directory?

> Is there any reason the repos could have just broken somehow?  A
> corrupt push?

I can't imagine a corrupt push would do it. Git shouldn't be changing
the permissions on the objects directory at all.

-Peff
