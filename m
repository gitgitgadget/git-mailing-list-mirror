From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge remote branch says "Merge commit ..."?
Date: Sat, 23 May 2009 02:26:58 -0700
Message-ID: <7vljoo2mql.fsf@alter.siamese.dyndns.org>
References: <2729632a0905211250v4e7537caybe9e703c14361b5f@mail.gmail.com>
	<loom.20090522T172429-73@post.gmane.org>
	<20090522175401.GB11640@coredump.intra.peff.net>
	<200905222030.34301.j6t@kdbg.org>
	<20090523091711.GB20416@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Eric Raible <raible@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 23 11:27:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7nVW-0000sa-El
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 11:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbZEWJ07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 05:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbZEWJ06
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 05:26:58 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57338 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbZEWJ05 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 05:26:57 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090523092659.FZYO18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Sat, 23 May 2009 05:26:59 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id uxSy1b0054aMwMQ04xSyUn; Sat, 23 May 2009 05:26:58 -0400
X-Authority-Analysis: v=1.0 c=1 a=GVQSc9Rt3x8A:10 a=zPODrnQKMugA:10
 a=PKzvZo6CAAAA:8 a=McPTmtnEmG2WzyicFzcA:9 a=kSEmaFRnx--HA5A_INMVQrIqSNsA:4
 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
In-Reply-To: <20090523091711.GB20416@coredump.intra.peff.net> (Jeff King's message of "Sat\, 23 May 2009 05\:17\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119770>

Jeff King <peff@peff.net> writes:

> Right. We could probably use similar logic in "git merge". I'm not sure
> if it is worth the trouble to end up with "Merge branch 'master' of
> origin" instead of "Merge remote branch 'origin/master'".

I do not think it is worth doing that to lose information, either.
