From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport move over to using git for each ref to read refs
Date: Wed, 20 Sep 2006 09:45:29 -0700
Message-ID: <7vwt7yij12.fsf@assigned-by-dhcp.cox.net>
References: <20060920085200.GA21865@shadowen.org> <eer19l$6hm$1@sea.gmane.org>
	<4511173D.7020702@shadowen.org>
	<7vodtak00n.fsf@assigned-by-dhcp.cox.net>
	<45116888.4050806@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:46:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ5D7-0002AD-0Y
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbWITQpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWITQpk
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:45:40 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14221 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751877AbWITQpa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:45:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920164530.XNE12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 12:45:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QglG1V00B1kojtg0000000
	Wed, 20 Sep 2006 12:45:16 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <45116888.4050806@shadowen.org> (Andy Whitcroft's message of
	"Wed, 20 Sep 2006 17:12:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27374>

Andy Whitcroft <apw@shadowen.org> writes:

>> About the quoting and parsing, language specific quoting mode is
>> meant for git-for-each-ref to produce a string that can be eval'ed
>> in the host language.  Think of the command as a tool to write a
>> short program for you.
>
> Thanks for the education.  Very simple, and very powerful.  I knew there
> was a reason for it out there.  Will respin a V3 patch in a bit.

This probably showed that my initial description and example for
the feature found in Documentation/git-for-each-ref was lacking.

I would appreciate a separate patch to enhance it if you are so
inclined.
