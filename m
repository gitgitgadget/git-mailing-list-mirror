From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problems with branches
Date: Sat, 27 Jan 2007 14:00:54 -0800
Message-ID: <7vtzycgmeh.fsf@assigned-by-dhcp.cox.net>
References: <4b73d43f0701261551oef411f7tfd5cdbfdce7f6abc@mail.gmail.com>
	<7vfy9xtjxs.fsf@assigned-by-dhcp.cox.net>
	<20070127131355.GA2417@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Rigby <jcrigby@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 23:01:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAvbh-0006io-Oo
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 23:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbXA0WBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 17:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbXA0WBA
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 17:01:00 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58310 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbXA0WA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 17:00:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127220055.NCCB29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sat, 27 Jan 2007 17:00:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GMzx1W00H1kojtg0000000; Sat, 27 Jan 2007 16:59:57 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38000>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 26, 2007 at 04:03:27PM -0800, Junio C Hamano wrote:
>
>> Probably you are using v1.4.4.X.
>> 
>> The change to make git-merge accessible as the first level UI
>> happened during the preparation for the upcoming v1.5.0, and is
>> available only in v1.5.0-rc0 and newer versions (the latest is
>> at v1.5.0-rc2).

You are right -- as you and other people noticed, this is
primarily my fault.

> This highlights a problem with the current web pages. The documentation
> at http://www.kernel.org/pub/software/scm/git/docs/ is for the current
> master (which is presumably where this user got the tutorial mentioning
> 'git merge' as porcelain). But I suspect a lot of people will be using
> the latest released version (either from the tarball, or a binary
> package). We could:
>   1. Only re-publish the web doc at time of release
>   2. Build the published web doc from 'maint' instead of master
>   3. Publish (and clearly mark) both last-released and master doc
>   4. Disregard it; this particular release made a lot of UI changes, but
>      we're not likely run into this for most releases.

The ideal solution would be 3 but it would require some juggling
to arrange git.txt -> index.html generation that happens every
time I push to kernel.org machine, so give me a bit of time and
I'll come up with something.
