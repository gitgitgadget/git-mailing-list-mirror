From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use UTF-8 instead of utf8 for backward compatibility
Date: Sat, 16 May 2009 00:15:19 -0700
Message-ID: <7vbpptplh4.fsf@alter.siamese.dyndns.org>
References: <81b0412b0905140605o21143369ibc3147c6619c7845@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 16 09:15:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5E7F-0001aP-B0
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 09:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715AbZEPHPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 03:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755418AbZEPHPU
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 03:15:20 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39136 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbZEPHPT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 03:15:19 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516071520.UJWV25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Sat, 16 May 2009 03:15:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id s7FK1b00G4aMwMQ047FL8j; Sat, 16 May 2009 03:15:20 -0400
X-Authority-Analysis: v=1.0 c=1 a=jrs-ST2ZzPkA:10 a=I_zxLlamrkMA:10
 a=pGLkceISAAAA:8 a=CbllShcvUnB-yhuO3lkA:9 a=i7eHeS20Z4in0WJkLTAX0H6w5HMA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <81b0412b0905140605o21143369ibc3147c6619c7845@mail.gmail.com> (Alex Riesen's message of "Thu\, 14 May 2009 15\:05\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119340>

Alex Riesen <raa.lkml@gmail.com> writes:

> An old iconv (GNU libiconv 1.11) does not know about utf8, it does know
> UTF-8 though, which is also understood by all newer iconv implementations.

Thanks.  Very much appreciated.
