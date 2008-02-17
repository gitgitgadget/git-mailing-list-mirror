From: Jeff King <peff@peff.net>
Subject: Re: cant figure out how to get git working over https with a self
	signed certificate
Date: Sun, 17 Feb 2008 12:51:33 -0500
Message-ID: <20080217175133.GA4655@coredump.intra.peff.net>
References: <e26d18e40802170948s4b769c5ej4d0fb01300fbad9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 18:52:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQngR-0000qY-HG
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 18:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbYBQRvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 12:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbYBQRvg
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 12:51:36 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2258 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbYBQRvf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 12:51:35 -0500
Received: (qmail 2929 invoked by uid 111); 17 Feb 2008 17:51:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 17 Feb 2008 12:51:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Feb 2008 12:51:33 -0500
Content-Disposition: inline
In-Reply-To: <e26d18e40802170948s4b769c5ej4d0fb01300fbad9a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74145>

On Sun, Feb 17, 2008 at 09:48:26AM -0800, Anatoly Yakovenko wrote:

> cant figure out how to get git working over https with a self signed
> certificate.  I keep getting the dreaded "Error: no DAV locking
> support on remote repo"

Have you tried setting GIT_SSL_NO_VERIFY=1 in the environment? I haven't
tried http push, but the error message passing in this case for fetching
is not very good.

-Peff
