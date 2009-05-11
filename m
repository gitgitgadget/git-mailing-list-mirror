From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] gitweb: Some code cleanups (up to perlcritic --stern)
Date: Sun, 10 May 2009 21:21:32 -0700
Message-ID: <7viqk8s20j.fsf@alter.siamese.dyndns.org>
References: <200905100203.51744.jnareb@gmail.com>
	<7vy6t4sbxj.fsf@alter.siamese.dyndns.org>
	<200905110333.52127.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 06:21:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3N1O-0005Km-Os
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 06:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbZEKEVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 00:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbZEKEVi
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 00:21:38 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:41282 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbZEKEVh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 00:21:37 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090511042138.MBIV25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Mon, 11 May 2009 00:21:38 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id q4Md1b00Q4aMwMQ044MdM5; Mon, 11 May 2009 00:21:38 -0400
X-Authority-Analysis: v=1.0 c=1 a=rB85IVHXe-MA:10 a=nkwkopmtsd0A:10
 a=pGLkceISAAAA:8 a=l6JXY_lD0NKEIulIZw8A:9 a=iujcYdf1nUoo7_pGCRa6rZlfSk0A:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <200905110333.52127.jnareb@gmail.com> (Jakub Narebski's message of "Mon\, 11 May 2009 03\:33\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118772>

Jakub Narebski <jnareb@gmail.com> writes:

> On Mon, 11 May 2009, Junio C Hamano wrote:
>
>> But this series, when queued to 'pu', seems to break t9500; I haven't
>> looked at the breakage myself yet.
>
> I'm sorry about that. My bad. The fix is in the email (unless you
> prefer for me to just resend the series)...

That's Ok.  I had them near the tip of 'pu', and I can just replace them.

But this episode does not give much confidence in Perl::Critic does it?
The runtime "use strict" diagnosed undeclared globals in the cleaned up
code, but presumably the Critic did not complain anything about it, right?
