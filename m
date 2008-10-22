From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase-i-p: delay saving current-commit to REWRITTEN
	if squashing
Date: Wed, 22 Oct 2008 08:51:49 -0400
Message-ID: <20081022125149.GA17092@coredump.intra.peff.net>
References: <cover.1224055978.git.stephen@exigencecorp.com> <759654ef1f1781cd2b102e21c6f972b065560398.1224055978.git.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 14:53:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsdD1-0004xi-O5
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 14:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbYJVMvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 08:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbYJVMvx
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 08:51:53 -0400
Received: from peff.net ([208.65.91.99]:4718 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbYJVMvw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 08:51:52 -0400
Received: (qmail 595 invoked by uid 111); 22 Oct 2008 12:51:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 08:51:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 08:51:49 -0400
Content-Disposition: inline
In-Reply-To: <759654ef1f1781cd2b102e21c6f972b065560398.1224055978.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98862>

On Wed, Oct 15, 2008 at 02:44:36AM -0500, Stephen Haberman wrote:

> +		if [ "$fast_forward" == "t" ]

This one even fails on my Linux box. :) "==" is a bash-ism.

-Peff
