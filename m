From: Moritz Neeb <lists@moritzneeb.de>
Subject: Starting on a microproject for GSoC
Date: Thu, 28 Jan 2016 01:40:32 +0100
Message-ID: <56A96380.3020308@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 01:48:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOalH-0005KZ-5M
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 01:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967072AbcA1Asc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 19:48:32 -0500
Received: from moritzneeb.de ([78.47.1.106]:45246 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966408AbcA1Asa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 19:48:30 -0500
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2016 19:48:30 EST
Received: from [192.168.1.11] (x4db3be51.dyn.telefonica.de [77.179.190.81])
	by moritzneeb.de (Postfix) with ESMTPSA id A8C221C02C
	for <git@vger.kernel.org>; Thu, 28 Jan 2016 01:40:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1453941632;
	bh=X7p1rzwx3X5a9nr1CzEgJF/QoDeLTlB3CvyXQXM9uIE=;
	h=From:Subject:To:Date:From;
	b=UeSLstO+bfUJ+epZjvWj+eihZwlsnzP/ORsMj2cI7kI3bCLdipImGF2dPJsmJnvOb
	 f6+U9kU8xidNOI6zyNt6HtDzZn49ypnHhkfaj77PzdHl2/D6Z4Je8Itp+ExEelsSKR
	 DmwiQMvT5Sw2GfJLZHYXYlg0nVxo4vpomUho6RZ4=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284958>

Hi git developers,

the next Google Summer of Code is not too far away. I expect git to
apply for it and hopefully have some student spots which in turn I plan
to apply. It was recommended elsewhere and on this list as well, that it
is beneficial to engage with the community early, that's why I am
writing to you already now, before all this formal stuff has begun.

Before I may introduce myself: I'm a Computer Science student in
Germany, coming towards the end of my Masters. I am an enthusiastic git
user that's why I'd like to give something back. This would be my first
time to actually contribute to a FOSS project and I am quite excited
(also a bit frightened ;)).

As the list of available microprojects 2016 is still to be created, I
might need your help in finding a project to work on. I started to dig
through the archives along items of the list of 2015 [0] and so far
found out the following:

The first task, to make "git -C '' cmd" not to barf seems to be solved.
I tried it with "git -C '' status" at least. I could not find the
related patch, maybe it did use other keywords. I would be interested.

The second task, to allow "-" as a short-hand for "@{-1}" in more places
seems to be still open for reset, although someone almost finished it
(cf. $gmane/265417). I suppose just fixing/revising this would be kind
of a too low hanging fruit? More interesting (also because I am a bit
earlier) might be to unify everything, as suggested by Junio in
$gmane/265260. Or implementing it for another branch command, e.g. rebase.

The other tasks I did not yet dig into.

If all of that is considered as not relevant, I might just go for a
newer idea, like converting strbuf_getline_lf() callers to
strbuf_getline(), as suggested in $gmane/284104.

Any thoughts?

A question regarding the process of "taking a task (or bug)" in general:
Is it solely organized through the mailing list? Suppose I start to work
on something, should I announce it to not risk work duplication? Does it
happen often that more people accidentally work on the same task?

Best,
Moritz

[0] http://git.github.io/SoC-2015-Microprojects.html
