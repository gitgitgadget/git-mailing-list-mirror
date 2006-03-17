From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-cvsimport "you may need to merge manually"
Date: 16 Mar 2006 19:41:09 -0800
Message-ID: <86fylh20x6.fsf@blue.stonehenge.com>
References: <86veud23v0.fsf@blue.stonehenge.com>
	<7vu09x7puo.fsf@assigned-by-dhcp.cox.net>
	<86r75122yj.fsf@blue.stonehenge.com>
	<7vk6at7o06.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Fri Mar 17 04:41:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK5q6-0004ai-Fc
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 04:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWCQDlP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 22:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbWCQDlP
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 22:41:15 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:39528 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751284AbWCQDlP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 22:41:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 73EE58F551;
	Thu, 16 Mar 2006 19:41:10 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 05420-01-13; Thu, 16 Mar 2006 19:41:09 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id DADBD8F6B6; Thu, 16 Mar 2006 19:41:09 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.2.8; tzolkin = 2 Lamat; haab = 6 Cumku
In-Reply-To: <7vk6at7o06.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17656>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> Since I know I was just trying things out, I do not care what is
Junio> in my index nor in the working tree files, so I could at this
Junio> point say:

Junio> 	$ git reset --hard

Junio> to sync the master tree, but in general you may be running
Junio> cvsimport into a dirty tree, in which case you are screwed.

Yeah, this doesn't make sense.  It used to "Just Work".  I can
certainly add "git reset --hard" to my workflow, if that's the real
work around.  And if so, the manpage should document that.

Junio> ... Ugh, and after I wrote all of the above, the version of git
Junio> I have at work predates that commit X-<.  So maybe this was
Junio> fixed with that commit, and you are expected to say:

Junio> 	$ git pull . origin

Junio> assuming that you are on "master" branch and cvsimoprt tracks
Junio> CVS head with "origin" branch, that is.

Again, if that's the case, the manpage should say what's really
happening, so as not to confuse dumb people like me. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
