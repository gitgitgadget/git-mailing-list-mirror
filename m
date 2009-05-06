From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote: make remote name optional for prune operation
Date: Wed, 06 May 2009 10:54:04 -0700
Message-ID: <7vr5z2ungj.fsf@alter.siamese.dyndns.org>
References: <1241620621-12188-1-git-send-email-julien@danjou.info>
	<7vab5qw3nr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julien Danjou <julien@danjou.info>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 19:54:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1lJy-0003KH-5L
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 19:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbZEFRyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 13:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbZEFRyH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 13:54:07 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43402 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390AbZEFRyG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 13:54:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090506175404.ELMJ20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 May 2009 13:54:04 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id oHu41b00E4aMwMQ04Hu4Ks; Wed, 06 May 2009 13:54:04 -0400
X-Authority-Analysis: v=1.0 c=1 a=VMD5vf70d0kA:10 a=94lC-IFnZjQA:10
 a=ybZZDoGAAAAA:8 a=WNahTRQW-TSSp6ZTe7sA:9 a=Bp9xsdSL1GyZ7tJuL75X_MlD4vAA:4
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <7vab5qw3nr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 06 May 2009 10\:18\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118359>

Junio C Hamano <gitster@pobox.com> writes:

> I think we try to make an opearation that discards information from many
> things at once by mistake, and it feels that this patch goes against it.

Sorry, "by mistake" should have read "harder to trigger by mistake".
