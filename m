From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] git-send-email.perl: Deduplicate "to:" and "cc:"
 entries with names
Date: Sat, 20 Nov 2010 15:00:12 -0800
Message-ID: <1290294012.31117.34.camel@Joe-Laptop>
References: <1290272809.27951.30.camel@Joe-Laptop>
	 <m2mxp3zr88.fsf@igel.home> <1290286877.31117.15.camel@Joe-Laptop>
	 <m2eiafzjqg.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Nov 21 00:00:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJwPu-0004UL-QO
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 00:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395Ab0KTXAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 18:00:14 -0500
Received: from mail.perches.com ([173.55.12.10]:1611 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755142Ab0KTXAN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 18:00:13 -0500
Received: from [192.168.1.156] (unknown [192.168.1.156])
	by mail.perches.com (Postfix) with ESMTP id 680B624368;
	Sat, 20 Nov 2010 15:00:10 -0800 (PST)
In-Reply-To: <m2eiafzjqg.fsf@igel.home>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161847>

On Sat, 2010-11-20 at 23:57 +0100, Andreas Schwab wrote:
> Joe Perches <joe@perches.com> writes:
> > extract_valid_address provides an unadorned email address.
> An email address is not a regexp.  Thus it may not match itself.
> > I've now tested with and without, both seem to work properly.
> Did you test with all possible email addresses?

:)  That'd take forever...
