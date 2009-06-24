From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 0/2] gitweb: gravatar support
Date: Wed, 24 Jun 2009 00:20:53 -0700
Message-ID: <7vy6riyu5m.fsf@alter.siamese.dyndns.org>
References: <1245710999-17763-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 09:21:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJMn1-0007re-PE
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 09:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbZFXHUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 03:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbZFXHUx
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 03:20:53 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61598 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbZFXHUw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 03:20:52 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090624072055.YBTR18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Wed, 24 Jun 2009 03:20:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 7jLu1c0064aMwMQ04jLuvJ; Wed, 24 Jun 2009 03:20:55 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=cR6RGXxyg7UA:10 a=pGLkceISAAAA:8
 a=DyFOyQ9J7HLWb2LepWQA:9 a=RbrPDuhWgyQ4i2Ee-gKYBKFQu4QA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1245710999-17763-1-git-send-email-giuseppe.bilotta@gmail.com> (Giuseppe Bilotta's message of "Tue\, 23 Jun 2009 00\:49\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122127>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> As suggested by Junio, the author display refactoring now comes before
> the actual gravatar feature implementation. The refactoring also goes a
> little bit deeper, changing the 'commitdiff' view to match 'commit' for
> the author and committer layout.
>
> Giuseppe Bilotta (2):
>   gitweb: refactor author name insertion
>   gitweb: gravatar support
>
>  gitweb/gitweb.css  |    9 +++-
>  gitweb/gitweb.perl |  123 ++++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 99 insertions(+), 33 deletions(-)

Thanks.  It looks much better for reviewing, now the order of the patches
are sane.

Does anybody have comments on the patches?
