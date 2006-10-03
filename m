From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs
Date: Tue, 03 Oct 2006 10:36:22 -0700
Message-ID: <7vfye5pai1.fsf@assigned-by-dhcp.cox.net>
References: <20060929221641.GC2871@admingilde.org>
	<eftk98$2ii$2@sea.gmane.org> <20061003171229.GN2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 03 19:38:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUoCM-0002WZ-6X
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 19:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWJCRgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 13:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWJCRgZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 13:36:25 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:49874 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030341AbWJCRgX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 13:36:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003173623.KXNO22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Oct 2006 13:36:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VtcG1V00G1kojtg0000000
	Tue, 03 Oct 2006 13:36:16 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20061003171229.GN2871@admingilde.org> (Martin Waitz's message of
	"Tue, 3 Oct 2006 19:12:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28281>

Martin Waitz <tali@admingilde.org> writes:

> On Tue, Oct 03, 2006 at 02:16:05PM +0200, Jakub Narebski wrote:
>> 
>> I have just modified href() to be able to use it for actions which don't
>> need the ?p= parameter... and you didn't take into consideration the case
>> when $params{'project'} is set, but undefined.
>
> is this handled correctly in the second patch which got committed to
> next?

I did only a light testing last night and I do not remember
testing this particular issue I did not see an obvious
breakage.  Could you two please verify and send in fixes if you
find any more issues around this area?

I think Jakub's suggestion to respond in PATH_INFO to requests
that does use PATH_INFO is a good one.
