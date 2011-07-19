From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Fix config_file file leak.
Date: Tue, 19 Jul 2011 18:28:59 +0100
Message-ID: <4E25BEDB.6040002@ramsay1.demon.co.uk>
References: <20110714181948.GA23288@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Wilson <cwilson@vigilantsw.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:30:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjE7p-0008PE-C0
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032Ab1GSRaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:30:19 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:57113 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750893Ab1GSRaT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2011 13:30:19 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1QjE7d-0006f7-Xq; Tue, 19 Jul 2011 17:30:17 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20110714181948.GA23288@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177485>

Chris Wilson wrote:
> Hi,
> 
> We are using Sentry (a C/C++ static analysis tool) to analyze
> git on a nightly basis. Sentry found that a file leak
> was recently introduced in the commit 924aaf3.

Hmmm ..., commit 924aaf3 did *not* introduce a file handle leak.
It would seem that the change in scope of the file handle made it
easier for Sentry to see the *existing* (potential) file handle leak.

no?

Other than that, ...

ATB,
Ramsay Jones
