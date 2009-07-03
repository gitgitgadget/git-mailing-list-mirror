From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question about announcing it
Date: Thu, 02 Jul 2009 17:22:23 -0700
Message-ID: <7v1voyzkcg.fsf@alter.siamese.dyndns.org>
References: <200907030130.24417.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Peter Baumann <waste.manager@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Graham Perks <graham@kace.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 02:22:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMWYE-00086h-11
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 02:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbZGCAWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 20:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbZGCAWX
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 20:22:23 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58412 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214AbZGCAWU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 20:22:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090703002223.SYZD20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 2 Jul 2009 20:22:23 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id BCNP1c0064aMwMQ04CNPf7; Thu, 02 Jul 2009 20:22:23 -0400
X-VR-Score: -110.00
X-Authority-Analysis: v=1.0 c=1 a=xSnGGwmRascA:10 a=pGLkceISAAAA:8
 a=KrWt_d_5N1XpHNL9ahgA:9 a=g8p1FjySu8YjS2Q_VroA:7
 a=lcpd8c25ypoyUofNF3hpfVeAcnQA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <200907030130.24417.jnareb@gmail.com> (Jakub Narebski's message of "Fri\, 3 Jul 2009 01\:30\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122677>

Jakub Narebski <jnareb@gmail.com> writes:

> 8. How do/did you obtain Git (install and/or upgrade)?
>     * binary package (includes automatic updates in usual situation)
>     * source package or script
>     * source tarball
>     * pull from (main) repository
>
> Explanation: binary package covers pre-compiled binary (e.g. from rpm
> or deb binary packages); source package covers things like deb-src and
> SRPMS/src.rpm; source script is meant to cover installation in
> source-based distributions, like 'emerge' in Gentoo, and it includes
> automatic update in source-based Linux distributions.
>
> Note that this question is multiple choices question because one can
> install Git in different ways on different machines or on different
> operating systems.

Could we please have "None of the above" here ;-)?  Just kidding.

> 17. How often do you use the following forms of git commands
>     or extra git tools? (continued)
> ...
> Note: git-subtree is managed out of tree, as a separate project (not
> in git.git repository, not even in contrib/ area).

Is there a reason why this particular out-of-tree script was singled out,
and no other goodies are listed?

> 23. How do you compare current version with version from year ago?
>     * better
>     * no changes
>     * worse
>     * cannot say

Which version was that?  v1.5.6?  v1.6.0?  I think you would want to
explicitly say v1.6.0 (mid Aug 2008), and it might even make sense to link
to a list of changes since then (relnotes to 1.6.[123], at least, but
perhaps more condensed).

I see you dropped "How did you hear about git" from the questionaire.  It
was a good way to spot which response was from Linus who answered "I wrote
it" to the question ;-).
