From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodule update --merge
Date: Mon, 25 May 2009 11:33:31 -0700
Message-ID: <7vmy91vxqc.fsf@alter.siamese.dyndns.org>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0905191348460.4266@intel-tinevez-2-302>
	<200905191526.40471.johan@herland.net>
	<200905251359.37619.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	markus.heidelberg@web.de, Peter Hutterer <peter.hutterer@who-t.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 25 20:33:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8ezT-0003lA-2i
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 20:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbZEYSdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 14:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbZEYSdb
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 14:33:31 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53337 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbZEYSda (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 14:33:30 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090525183331.MJNU20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Mon, 25 May 2009 14:33:31 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id vuZX1b00M4aMwMQ04uZXeY; Mon, 25 May 2009 14:33:31 -0400
X-Authority-Analysis: v=1.0 c=1 a=CeZos8cfAAAA:8 a=ReBJqpTY1bjq0GCCw7gA:9
 a=2FDTgvvF2hulF8fkRGhkcyeHdc4A:4 a=8lZzlOcxvREA:10
X-CM-Score: 0.00
In-Reply-To: <200905251359.37619.johan@herland.net> (Johan Herland's message of "Mon\, 25 May 2009 13\:59\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119947>

Johan Herland <johan@herland.net> writes:

> I haven't received any replies to my attempt to describe the context in 
> which "git submodule update --merge" is useful. A hint as to whether my 
> argument is valid, or just crap, would be nice.

FWIW, I didn't find "rebase makes sense but merge doesn't" argument very
convincing to begin with.  Because the configuration variable is about
"update" action, I agree it makes sense to do

>   submodule.<name>.update = checkout/rebase (checkout if unset)

from the UI standpoint.

I do not know what the sensible repertoire of options nor what the default
should be, though.  That's up to the submodule using people to sort out.
