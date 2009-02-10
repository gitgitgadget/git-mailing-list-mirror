From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Tue, 10 Feb 2009 08:29:46 -0500
Message-ID: <4991814A.6050803@tedpavlic.com>
References: <20090205204436.GA6072@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Feb 10 14:31:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsht-0004o6-V3
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 14:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbZBJN3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 08:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbZBJN3z
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 08:29:55 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:54305 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751920AbZBJN3y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 08:29:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 0E1DE80D805A;
	Tue, 10 Feb 2009 08:23:25 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xMISb1s6gDPZ; Tue, 10 Feb 2009 08:23:24 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id EB61680D8059;
	Tue, 10 Feb 2009 08:23:24 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <20090205204436.GA6072@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109237>

> Release notes
> -------------
> Incompatibilities:

I notice that when I do the sequence...

*) open tig
*) hit <CR> to view first changeset
*) hit "j" to scroll one line

the green highlighting on the first line moves to the second, but the 
whitespace following the "commit 00000000000000" stays green. For 
example, if I do the sequence above in the tig repo, I'm left with

commit e278600f599f60a2b98aeae6bfbb6ba92cf92d6f---GREEN BG HERE---
---This line (Refs:) has GREEN BG---

The "commit" has a black background.

Is that a bug? Or do I need to upgrade my ncurses?

If I hit <CR> a few more times (to move the screen) and then hit "j" 
more (to move the highlighted line), I get this same bug randomly on 
different lines.

Thanks --
Ted

P.S.

Again, thanks for this app.


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
