From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Wed, 04 Feb 2009 15:40:39 +0100
Message-ID: <4989A8E7.6080109@drmicha.warpmail.net>
References: <1233432317.26364.5.camel@wren>	 <4989A63B.4030103@drmicha.warpmail.net> <1233758025.7594.23.camel@wren>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jesse van den Kieboom <jesse@icecrew.nl>
X-From: git-owner@vger.kernel.org Wed Feb 04 15:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUixA-0004on-7p
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 15:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbZBDOkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 09:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbZBDOkq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 09:40:46 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:39585 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752313AbZBDOkp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Feb 2009 09:40:45 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 605D527E7D3;
	Wed,  4 Feb 2009 09:40:44 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 04 Feb 2009 09:40:44 -0500
X-Sasl-enc: dkyY5KRcLrzrxnmsrOGklUxaPNP0NRTBZxm4iPDCOcKl 1233758443
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B06562E43F;
	Wed,  4 Feb 2009 09:40:43 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <1233758025.7594.23.camel@wren>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108369>

Jesse van den Kieboom venit, vidit, dixit 04.02.2009 15:33:
> Op woensdag 04-02-2009 om 15:29 uur [tijdzone +0100], schreef Michael J
> Gruber:
>> Jesse van den Kieboom venit, vidit, dixit 31.01.2009 21:05:
>>> Hi,
>>>
>>> I have been developing a gui application for git for gtk+/GNOME based on
>>> GitX (which in turn is based on gitk). I feel that it's reaching the
>>> point where it might potentially be useful for other people to use. It
>>> currently features:
>>>
>>> - Loading large repositories very fast
>>> - Show/browse repository history
>>> - Show highlighted revision diff
>>> - Browse file tree of a revision and export by drag and drop
>>> - Search in the revision history on subject, author or hash
>>> - Switch between history view of branches easily
>>> - Commit view providing per hunk stage/unstage and commit
>>>
>>> The project is currently hosted on github:
>>> http://github.com/jessevdk/gitg
>>>
>>> clone: git://github.com/jessevdk/gitg.git
>>>
>>> Please let me know what you think,
>> OK, played with it, looks nice. Some feedback:
>>
>> Bug:?
>> After unstaged a staged file it does not reappear under "unstaged". It
>> appears nowhere.
> 
> Hmm this _should_ happen, if it doesn't it's certainly a bug.

I just compared with staging/reverting the single hunk I had in there,
that works perfectly. The bug occurs only when unstaging from the list
of staged files.

>> Build:
>> gitg can't run from the build dir, it needs to be installed.
>> Reconfiguring with different --prefix does not rebuild (one needs to
>> make clean manually).
> 
> This is true, I got a patch to fix this, but I'm not sure it should go
> in (e.g. read data files from current working directory). It's not
> common to be able to run C/gtk+ apps from the build directory, you
> should install them in a local prefix.

Sure, but just to try it out? Imagine me poor soul, going through all
these GUIs and cloning, running
autogen.sh/qmake-qt4/configure/make/setup.py depending on the tk, and
finding I have to install in order to try it out (not to mention
dependencies)? ;)

>> Can one stage hunks somehow?
> 
> Yes, you can click on the hunk header @@...@@ when viewing the diff in
> the commit view. You can also rightclick on this header and revert a
> hunk (or stage/unstage it from the context menu).

Uh, thanks, works like a charm. I had tried selecting and right-clicking
the hunk itself...

Cheers,
Michael
