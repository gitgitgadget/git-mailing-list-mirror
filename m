From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] git cannot find "git pull"?
Date: Thu, 11 Jun 2009 22:15:51 -0700
Message-ID: <7viqj2c9rs.fsf@alter.siamese.dyndns.org>
References: <4A319CE1.6040201@garzik.org>
	<20090612011737.GB5076@inocybe.localdomain>
	<7v7hzidvcj.fsf@alter.siamese.dyndns.org>
	<20090612031853.GC5076@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 07:16:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEz7S-0001A7-Mv
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 07:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbZFLFPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 01:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbZFLFPu
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 01:15:50 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51830 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZFLFPu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 01:15:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090612051553.FCO20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jun 2009 01:15:53 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2tFr1c0094aMwMQ03tFrF2; Fri, 12 Jun 2009 01:15:52 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=0MMDW3Mb48cA:10 a=F1brEb3fTY8A:10
 a=ybZZDoGAAAAA:8 a=zBK5yZjOAAAA:8 a=zYEX-GARuVi0x6tjkqQA:9
 a=IOTkMqF22Y44voRaw_YW8NTt-6kA:4 a=jCX6CI3P4pcA:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <20090612031853.GC5076@inocybe.localdomain> (Todd Zullinger's message of "Thu\, 11 Jun 2009 23\:18\:53 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121389>

Todd Zullinger <tmz@pobox.com> writes:

> Chris has been busy with other things for a while.  I started helping
> with git package maintenance only in the last 6 months or so.  Over
> time, the spec file we have has drifted a bit from what is in git.git,
> though not terribly so.  I need to spend some time and look at what,
> if any, changes in the Fedora spec file would be good candidates for
> submitting to git.git.  I have been primarily concerned with making
> things work cleanly on Fedora and RHEL/CentOS though, so some of the
> changes may not be as generic as they ought to be if they are to be
> included in git.git.

I use the one in git.git only to cut the Fedora 9 packages for consumption
by k.org people.  I do not know what their upgrade plans are, but last
time they upgraded from FC 5 to Fedora 9 I had to scramble around and find
an i386 box to produce binaries (the machine available to me at k.org is
amd64).  Perhaps I should start preparing Fedora 11 environment now it is
finally released, but before that I need to procure a new development box
to host it in a vm, as the current box that is the primary integration
machine for git and that hosts the Fedora 9 i386 vm has got too tight and
I've been limping along; it does not have enough room to host another vm
(and it is not even hardware vm capable)...
