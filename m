From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Funny error with git gc...
Date: Fri, 15 May 2009 11:10:23 -0700
Message-ID: <7vmy9etey8.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 15 20:10:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M51re-0003u3-Pp
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 20:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbZEOSKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 14:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbZEOSKX
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 14:10:23 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41324 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbZEOSKX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 14:10:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090515181023.DIFJ17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 May 2009 14:10:23 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id ruAP1b00J4aMwMQ04uAPfW; Fri, 15 May 2009 14:10:23 -0400
X-Authority-Analysis: v=1.0 c=1 a=zrFp-jdIYlQ5ABsTu2AA:9
 a=RXgHhMI4pbYW0-TOAbYA:7 a=NxQ7ok8ll2tbTHXAJE29FE9OA9oA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302> (Johannes Schindelin's message of "Fri\, 15 May 2009 20\:02\:26 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119269>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> if you need a chuckle, like me, you might appreciate this story: in one of 
> my repositories, "git gc" dies with
>
> 	unable to open object pack directory: ...: Too many open files
>
> turns out that there are a whopping 1088 packs in that repository...

Isn't it a more serious problem than a mere chuckle?  How would one
recover from such a situation (other than "mv .git/objects/pack-*;
for p in pack-*.pack; do git unpack-objects <$p; done")?
