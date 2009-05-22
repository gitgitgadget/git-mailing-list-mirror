From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t8005: use more portable character encoding names
Date: Fri, 22 May 2009 09:22:46 -0700
Message-ID: <7vhbzd85ux.fsf@alter.siamese.dyndns.org>
References: <WnZxv4G_GKTN4oHhxHO_HuQt0cTqurrqXf2HHDiHLAzdp7wC70aKuqDot7xQ1nG9C8_NASCL1_Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri May 22 18:23:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7XWe-00043U-JS
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 18:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbZEVQWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 12:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbZEVQWr
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 12:22:47 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46371 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbZEVQWq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 12:22:46 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090522162247.DTRE25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Fri, 22 May 2009 12:22:47 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id ugNm1b00m4aMwMQ04gNnL2; Fri, 22 May 2009 12:22:47 -0400
X-Authority-Analysis: v=1.0 c=1 a=A45FNvI-izYA:10 a=Tuf-O-QHtNkA:10
 a=yVAoY06rBgFK-_Q3j44A:9 a=p0DPRM_GKTx1FK6mSMwyC1xSUGEA:4
X-CM-Score: 0.00
In-Reply-To: <WnZxv4G_GKTN4oHhxHO_HuQt0cTqurrqXf2HHDiHLAzdp7wC70aKuqDot7xQ1nG9C8_NASCL1_Q@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\, 22 May 2009 10\:25\:04 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119740>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> ...  I hesitate to send it since it does not actually allow any
> tests to pass which were previously failing for me.  At least the utf-8 to
> UTF-8 shouldn't cause any harm.  The shift-jis to SJIS seems to be commonly
> supported?  at least IRIX 6.5 and Solaris as old as 7 recognize it, but the
> evidence is only empirical.  Modern Solaris, and of course Linux recognize
> either.

Perhaps the test can be changed from using cp1251 (whatever that is) to
something more common (e.g. 8859-1)?

There was another more large-ish patch to the tests around this area
recently from you.  I liked them but somehow failed to queue any of them
yet, sorry.
