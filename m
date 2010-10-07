From: Jeff King <peff@peff.net>
Subject: Re: Differing results between gitk --follow and git log --follow
Date: Thu, 7 Oct 2010 14:18:54 -0400
Message-ID: <20101007181854.GF18518@sigill.intra.peff.net>
References: <4CAE0DB0.1090608@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 20:18:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3v3S-000051-KV
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 20:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433Ab0JGSSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 14:18:42 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47199 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354Ab0JGSSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 14:18:41 -0400
Received: (qmail 20006 invoked by uid 111); 7 Oct 2010 18:18:41 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.184)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 07 Oct 2010 18:18:41 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Oct 2010 14:18:54 -0400
Content-Disposition: inline
In-Reply-To: <4CAE0DB0.1090608@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158424>

On Thu, Oct 07, 2010 at 12:13:04PM -0600, Joshua Jensen wrote:

> Is there a way to convince gitk to show me the same bits as git log
> --follow?

Sadly, no, not without major surgery to the follow code. See:

  http://article.gmane.org/gmane.comp.version-control.git/147089

-Peff
