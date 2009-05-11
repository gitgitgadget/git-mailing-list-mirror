From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] gitweb: Some code cleanups (up to perlcritic --stern)
Date: Sun, 10 May 2009 17:47:20 -0700
Message-ID: <7vy6t4sbxj.fsf@alter.siamese.dyndns.org>
References: <200905100203.51744.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bill Pemberton <wfp5p@virginia.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 02:47:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Jg8-0001vn-BJ
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 02:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbZEKArV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 20:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbZEKArU
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 20:47:20 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57663 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbZEKArU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 20:47:20 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090511004720.EMCH20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Sun, 10 May 2009 20:47:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id q0nL1b00E4aMwMQ040nL32; Sun, 10 May 2009 20:47:20 -0400
X-Authority-Analysis: v=1.0 c=1 a=rB85IVHXe-MA:10 a=nkwkopmtsd0A:10
 a=pGLkceISAAAA:8 a=Fkso9wCkuS-ZYaKzZWcA:9 a=mltInmLrVIMu4ZlUndzQT_OnrvYA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <200905100203.51744.jnareb@gmail.com> (Jakub Narebski's message of "Sun\, 10 May 2009 02\:03\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118764>

Jakub Narebski <jnareb@gmail.com> writes:

> The following series consist of some code cleanups for gitweb.perl.
> They're based on suggestions by perlcritic (Perl::Critic).

Nice.

But this series, when queued to 'pu', seems to break t9500; I haven't
looked at the breakage myself yet.

Jakub, did you run this through the testsuite already (the problem could
well be on my end and that is why I am asking)?
