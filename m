From: Jeff King <peff@peff.net>
Subject: Re: git stash list with more than 10 items?
Date: Mon, 12 Oct 2009 13:52:01 -0400
Message-ID: <20091012175201.GA10263@coredump.intra.peff.net>
References: <havj2n$d85$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jef Driesen <jefdriesen@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 19:53:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxP55-0004b4-0X
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 19:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbZJLRwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 13:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbZJLRwi
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 13:52:38 -0400
Received: from peff.net ([208.65.91.99]:53960 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932469AbZJLRwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 13:52:37 -0400
Received: (qmail 5695 invoked by uid 107); 12 Oct 2009 17:55:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 12 Oct 2009 13:55:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Oct 2009 13:52:01 -0400
Content-Disposition: inline
In-Reply-To: <havj2n$d85$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130038>

On Mon, Oct 12, 2009 at 05:47:34PM +0200, Jef Driesen wrote:

> Is it possible to make "git stash list" show more than 10 items?

Try "git stash list -30".

Stash listing is internally just "git log -g refs/stash", so you can
pass any formatting or limiting arguments you want there (see the git
log documentation for ideas). If no arguments are given, we pass "-10".

-Peff
