From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Checking for "diff.color." should come before "diff.color"
Date: Mon, 23 Oct 2006 16:29:53 -0400
Message-ID: <20061023202952.GC31068@coredump.intra.peff.net>
References: <200610232051.17396.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 22:30:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc6RH-00070p-G5
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 22:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWJWUaA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 16:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWJWU37
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 16:29:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:11689 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751382AbWJWU3z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 16:29:55 -0400
Received: (qmail 9065 invoked from network); 23 Oct 2006 16:28:57 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 23 Oct 2006 16:28:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Oct 2006 16:29:53 -0400
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610232051.17396.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29876>

On Mon, Oct 23, 2006 at 08:51:17PM +0100, Andy Parkins wrote:

> In git_diff_ui_config() the strncmp() for "diff.color" would have
> matched for "diff.color.", so "diff.color." configs would never be
> processed.

No, it's a strcmp for "diff.color", so it must match exactly. The code
is fine.

Are you experiencing some bug, or was this just from poking through the
code?

-Peff
