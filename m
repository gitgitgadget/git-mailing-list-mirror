From: Jeff King <peff@peff.net>
Subject: Re: git cloning fails
Date: Tue, 8 Apr 2008 09:13:48 -0400
Message-ID: <20080408131347.GB22623@sigill.intra.peff.net>
References: <cb8016980804080600se489c8bv5b79186be284163f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Abraham Arce <abraham.arce.moreno@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 15:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjDel-0007mK-3j
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 15:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbYDHNNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 09:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbYDHNNv
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 09:13:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1825 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbYDHNNu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 09:13:50 -0400
Received: (qmail 15624 invoked by uid 111); 8 Apr 2008 13:13:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 08 Apr 2008 09:13:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Apr 2008 09:13:48 -0400
Content-Disposition: inline
In-Reply-To: <cb8016980804080600se489c8bv5b79186be284163f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78998>

On Tue, Apr 08, 2008 at 08:00:20AM -0500, Abraham Arce wrote:

> While cloning git repository
> 
> git clone http://www.kernel.org/pub/scm/git/git.git
> 
> I've received the following message:
> 
> got 33682a5e98adfd8ba4ce0e21363c443bd273eb77
> error: Couldn't get
> http://www.kernel.org/pub/scm/git/git.git/refs/tags/gitgui-0.6.0 for
> tags/gitgui-0.6.0
> The requested URL returned error: 404
> error: Could not interpret tags/gitgui-0.6.0 as something to pull

This works just fine for me. Which git version are you using? Does the
problem still exist if you try again? If that URL did in fact return a
404, it sounds more like a kernel.org problem.

-Peff
