From: Jeff King <peff@peff.net>
Subject: Re: Why does gpg.program work for commit but not log?
Date: Wed, 18 Jun 2014 03:36:45 -0400
Message-ID: <20140618073645.GA24769@sigill.intra.peff.net>
References: <ABACA8639E2A49BA8A1E602DBE815867@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Wed Jun 18 09:36:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxAQN-0004bP-Pp
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 09:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933747AbaFRHgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 03:36:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:46590 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754208AbaFRHgr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 03:36:47 -0400
Received: (qmail 25196 invoked by uid 102); 18 Jun 2014 07:36:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 02:36:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 03:36:45 -0400
Content-Disposition: inline
In-Reply-To: <ABACA8639E2A49BA8A1E602DBE815867@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251971>

On Wed, Jun 18, 2014 at 12:18:35AM -0400, Jason Pyeron wrote:

> jpyeron@black /projects/microsoft-smartcard-sign/tmp
> $ git --version
> git version 1.7.9

That's rather old. In the meantime we have:

	commit 6005dbb9bf21d10b209f7924e305bd04b9ab56d2
	Author: Jacob Sarvis <jsarvis@openspan.com>
	Date:   Wed Mar 27 10:13:39 2013 -0500
	
	    log: read gpg settings for signed commit verification
	    
	    "show --show-signature" and "log --show-signature" do not read the
	    gpg.program setting from git config, even though, commit signing,
	    tag signing, and tag verification honor it.

which is in v1.8.3.  In general, please double-check your problem
against a recent version of "master" when making a bug report.

-Peff
