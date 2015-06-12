From: Philippe De Muyter <phdm@macq.eu>
Subject: Re: strange result of `git describe` while bisecting
Date: Fri, 12 Jun 2015 15:21:59 +0200
Message-ID: <20150612132159.GA23768@frolo.macqel>
References: <20150612130027.GA19711@frolo.macqel> <87ioatvzez.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 15:22:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3OuQ-0008Ga-Mr
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 15:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbbFLNWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 09:22:05 -0400
Received: from smtp2.macqel.be ([109.135.2.61]:55220 "EHLO smtp2.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbbFLNWE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 09:22:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id EBD89130DBB;
	Fri, 12 Jun 2015 15:22:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xeI5Fyy+RSdE; Fri, 12 Jun 2015 15:21:59 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id 4C4AE130BDE;
	Fri, 12 Jun 2015 15:21:59 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 344CBDF0729; Fri, 12 Jun 2015 15:21:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87ioatvzez.fsf@igel.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271487>

On Fri, Jun 12, 2015 at 03:17:40PM +0200, Andreas Schwab wrote:
> Philippe De Muyter <phdm@macq.eu> writes:
> 
> > I am bisecting the kernel tree between v3.17 and v3.18, and 'git describe'
> > is used by the kernel compilation process.  Why do I get a version
> > v3.17-rc7-1626-ga4b4a2b, that seems outside of [v3.17..v3.18] ?
> 
> Because your are testing a side branch that is based on v3.17-rc7.
> 
> 3.17-rc7 --- 3.17 ------- 3.18
>            \           /
>             \----- * -/
>                    ^
> You are here ------^

Thank you Andreas

Philippe
