From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 3/4] t5520-pull: --rebase with rebased upstream and two branches
Date: Thu, 11 Jun 2009 19:57:19 -0700
Message-ID: <7vvdn2cg6o.fsf@alter.siamese.dyndns.org>
References: <1244759961-4750-1-git-send-email-santi@agolina.net>
	<1244759961-4750-4-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jun 12 04:57:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEwxV-0003ZM-Qu
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 04:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845AbZFLC5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 22:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756492AbZFLC5S
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 22:57:18 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61812 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbZFLC5R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 22:57:17 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090612025719.ETYY18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Thu, 11 Jun 2009 22:57:19 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 2qxK1c00B4aMwMQ04qxKGg; Thu, 11 Jun 2009 22:57:19 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=FZkQkW6ZZZMA:10 a=LDPNlgZvRcQA:10
 a=jfO3Z-wZOedT9-xOOB4A:9 a=6XTmeBsAJ8hKuh5UFcrj3WY6aikA:4
X-CM-Score: 0.00
In-Reply-To: <1244759961-4750-4-git-send-email-santi@agolina.net> ("Santi
 =?utf-8?Q?B=C3=A9jar=22's?= message of "Fri\, 12 Jun 2009 00\:39\:20
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121383>

I think marking breakages here is a good thing to do, but I do not think
this belongs to your rest of the series.  If a fix for this will upcoming
(I think I've outlined ideas in a separate message, IIRC), I think that
could go to 'maint', to which the remainder of your series will definitely
not belong to.

I'd queue this one separately from the other three patches (which will
fork from 'master'), which means this should not depend on [2/4], but
unfortunately it does.
