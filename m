From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Teach git status to do "git diff --name-status HEAD"
Date: Wed, 17 Sep 2008 13:26:24 +0200
Message-ID: <48D0E960.1060402@drmicha.warpmail.net>
References: <aba84270809162340n4ea3f5feqc71d01fa6e035b79@mail.gmail.com>	<48D0C2DF.7010308@drmicha.warpmail.net> <m3ej3jm3ux.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 13:27:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfvC6-0000R2-Km
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 13:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbYIQL03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 07:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYIQL03
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 07:26:29 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44751 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752362AbYIQL02 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2008 07:26:28 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D124516398D;
	Wed, 17 Sep 2008 07:26:27 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 17 Sep 2008 07:26:27 -0400
X-Sasl-enc: 5OHsy9soBpRLWeNH6izVbWKULX9Gm7b+ED3JPc3V9dof 1221650787
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 18811B044;
	Wed, 17 Sep 2008 07:26:26 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <m3ej3jm3ux.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96094>

Jakub Narebski venit, vidit, dixit 17.09.2008 13:04:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Martin Langhoff venit, vidit, dixit 17.09.2008 08:40:
>>> I just did
>>>
>>> $ git checkout -b mdl19-offlinetony
>>> A       README.offline
>>> M       lib/javascript.php
>>>     (...)
>>> A       lib/offline/offlinemoodle.user.js
>>>
>>> I *like* this "brief status" style - takes me back to my cvs days :-).
>>> Perusing the source I found show_local_changes() which in turn led me
>>> to trying `git diff --name-status HEAD`. Now, including 'HEAD' in an
>>> alias defined in git config is going to lead to trouble... :-/
> [...]
>>> I might still make an alias to `git diff --name-status`. This would be
>>> a great thing to have as git status "--brief" IMHO... :-)
>> git status also shows untracked files. I don't know how to tell diff to
>> show untracked files as well. --diff-filter=X doesn't do it.
> 
> git-ls-files?

Yes, "git ls-files -t -d -m -o --directory" does something like
"otherscmyouknowwho status". But it's plumbing, and the most obvious
porcelain place for such functionality is "git status", followed by "git
diff".
I do understand that "git status" is mostly "git commit --dry-run". But
shouldn't we have something like Martin suggested readily available
(including, optionally, untracked or ignored files).

Michael
