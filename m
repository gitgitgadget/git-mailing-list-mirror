From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Possible feature request for merge and pull
Date: Wed, 28 Jul 2010 20:27:23 -0500
Message-ID: <20100729012723.GH29156@dert.cs.uchicago.edu>
References: <AANLkTim6JAPrSVaSaGZ72xtfFnUUcYeWT8vpL3rYuwki@mail.gmail.com> <AANLkTinRvq71GS5WVdWs9zP5QSJ=TjCWBgTfRGn2Qub0@mail.gmail.com> <AANLkTikA2jWu76aPUNG+B7Nwc9eDzoU93VcGvUFWR0Ri@mail.gmail.com> <20100729010341.GA25732@coredump.intra.peff.net> <AANLkTikP+5GxyWbXNcKeOtQoOEGAT9v313jAum+q-1LV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 03:27:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeHuG-000197-IQ
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 03:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab0G2B10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 21:27:26 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:44836 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab0G2B10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 21:27:26 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 5C7CA9FF;
	Wed, 28 Jul 2010 20:27:24 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 263E2A6C2; Wed, 28 Jul 2010 20:27:24 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikP+5GxyWbXNcKeOtQoOEGAT9v313jAum+q-1LV@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152142>

Bradley Wagner wrote:
> On Wed, Jul 28, 2010 at 9:03 PM, Jeff King <peff@peff.net> wrote:

>> Really? I get:
[...]
> --log is supposed to include one-log summaries of each of the merged
> commits, right? It's not doing that for me

Just a wild guess, but are you using a version of git before
1.7.1.1?

If you upgrade, you'll be able to use -m with --log for
"git merge", at least (v1.7.1.1~23^2: merge: --log appends
shortlog to message if specified, 2010-05-11).

Thanks, Tay!
Jonathan
