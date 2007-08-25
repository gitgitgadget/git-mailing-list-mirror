From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: how do you "force a pull"?
Date: Sat, 25 Aug 2007 06:19:15 -0700
Message-ID: <86odgveoq4.fsf@blue.stonehenge.com>
References: <20070825111946.GA7122@falcon.digizenstudio.com>
	<20070825113747.GA21030@mimvista.com>
	<20070825115326.GB7122@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>, Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 15:19:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOvYK-00017R-Mr
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 15:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbXHYNTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 09:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754587AbXHYNTR
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 09:19:17 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:44431 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbXHYNTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 09:19:16 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 0CF6F1DF010; Sat, 25 Aug 2007 06:19:16 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.10.15; tzolkin = 9 Men; haab = 3 Mol
In-Reply-To: <20070825115326.GB7122@falcon.digizenstudio.com> (Jing Xue's message of "Sat, 25 Aug 2007 07:53:26 -0400")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56634>

>>>>> "Jing" == Jing Xue <jingxue@digizenstudio.com> writes:

Jing> Ah, this is what I was looking for. Not very intuitive, but works like a
Jing> charm!

I find the word "intuitive" is like "common sense", which apparently isn't
very common. :)

"Not very intuitive" can be translated as "I don't yet share the mental model
from which this observation would be obvious".

I would suggest that to make such observations more intuitive, you stop
thinking of git as you would SVN or (gasp!) CVS, and start paying attention to
what git-fetch is really doing to the local object tree, and git-merge on top
of that, collectively known as git-pull.

The concept of keeping track of a directed graph of commits is not present in
"classic" source code managers... and once you make the mental leap, you'll
wonder why it was ever done differently.  It's revolutionary, not just
evolutionary.

(And if this sounds meta, it's because I'm rewriting my "intro to git" slides
because I just confirmed where my next presentation will be, and want them to
be even better.)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
