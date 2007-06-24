From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add git-save script
Date: Sun, 24 Jun 2007 12:45:01 -0700
Message-ID: <7vbqf5t9vm.fsf@assigned-by-dhcp.cox.net>
References: <7vmyyq2zrz.fsf@assigned-by-dhcp.pobox.com>
	<200706241044.l5OAiMCB012492@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 21:45:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Y1G-0005Rs-Ld
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 21:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXFXTpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 15:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbXFXTpE
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 15:45:04 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62076 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbXFXTpD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 15:45:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624194501.FQIV3993.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Jun 2007 15:45:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FXl11X0041kojtg0000000; Sun, 24 Jun 2007 15:45:01 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50815>

Nanako Shiraishi <nanako3@bluebottle.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> When you say "#!/bin/sh", you are writing for the family of
>> generic Bourne shells, not specifically for korn nor bash.  For
>> example, dash is a fine POSIX shell, but does not grok function
>> noiseword.  When in doubt, please stay away from things not in
>> POSIX (e.g. function, [[, ]], ${parameter//pattern/string/}).
>
> Is there a good reference you can point me?

I usually look at this:

    http://www.opengroup.org/onlinepubs/000095399/

and click on "Shell and Utilities volume (XCU)", and compare it
with "man bash".

> At first I wanted to do git-add . instead of git-add -u, but then I
> became worried that will add files that are not interesting such as
> temporary files.

As long as .gitignore is set up properly to ignore such
generated files, that shouldn't be a problem.
