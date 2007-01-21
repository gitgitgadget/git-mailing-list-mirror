From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 02:52:00 -0800
Message-ID: <7vwt3g3b5b.fsf@assigned-by-dhcp.cox.net>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<eovccc$usc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 11:52:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8aIy-0000sj-AZ
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 11:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXAUKwD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 05:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXAUKwD
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 05:52:03 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:39584 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbXAUKwB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 05:52:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070121105200.YZOE3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sun, 21 Jan 2007 05:52:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Dmr51W0031kojtg0000000; Sun, 21 Jan 2007 05:51:05 -0500
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eovccc$usc$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	21 Jan 2007 10:40:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37315>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, was the pager configured to saner values, so "git diff"
> on a repository with no changes does not output empty page?

That's been set to the right way since commit 0abc0260 (October
22, 2006, v1.4.3.2~6) as far as I know.

> What about my Documentation/config.txt changes?

I was not sure about that one, given a lot of commentary in your
message, suggesting more research and revision is needed, like
these...

>>> +All the other lines are recognized as setting variables, in the form
>>> +'name = value'. If there is no equal sign on the line, the entire line
>>> +is taken as 'name' and the variable is recognized as boolean "true".
>>> +Variable names are case insensitive.
>> 
>> They cannot contain anything else than alphanumeric characters, in 
>> particular no whitespace.
>
> It is mentioned above "Syntax" section, but perhaps it should be repeated.
> I haven't took a look at code to check what values for section names and
> for key/variable names are allowed.
> ...
>> One thing that left me puzzled after reading the description was
>> what a user can do with "subsection".  It is unclear from the
>> description if [section "sub.section"], [section "sub.sec=ti.on"]
>> or worse yet, [section "sub\nsection with an embbedded LF"] are
>> allowed.  The rest seemed sane.
>
> I'm not sure what is allowed in section name, and in subsection name,
> so for now I have left it as is. I can amend this commit, or add new
> commit explaining this.
