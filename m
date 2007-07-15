From: Scott Lamb <slamb@slamb.org>
Subject: Re: [PATCH 0/4] Move git-p4import into contrib directory.
Date: Sun, 15 Jul 2007 14:53:53 -0700
Message-ID: <469A9771.1000805@slamb.org>
References: <20070715154804.2877361d.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jul 15 23:54:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAC2n-0007xe-N3
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 23:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbXGOVyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 17:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbXGOVyS
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 17:54:18 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:56651 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbXGOVyS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 17:54:18 -0400
Received: from spiff.local (ppp-71-139-183-188.dsl.snfc21.pacbell.net [71.139.183.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id D2A4998105;
	Sun, 15 Jul 2007 14:54:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <20070715154804.2877361d.seanlkml@sympatico.ca>
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52590>

Sean wrote:
> Hi Junio,
> 
> Having caught up on some list emails, it appears that Git now has a
> much better option for importing from Perforce in the git-p4 front
> end to fast-import.
> 
> Is there anyone out there actually even using git-p4import?  It was
> written for a very specific case, by a git wannabe hacker who had
> never used Perforce before, and not intended for inclusion in Git
> proper...
> 
> My guess is that it could be removed outright without pain to anyone,
> but as a first step, it could be moved into contrib for 1.5.3.

I vote for removing it immediately. It has serious bugs - e.g.,
incremental mode is totally broken. I sent in a patch a month ago to fix
this particular bug, which remains unapplied. Now that git-p4 has made
it into git.git, I don't think anyone - myself included - is interested
in creating or merging git-p4import.py fixes. Keeping git-p4import.py in
this broken state just wastes the time of anyone unlucky enough to see
it first.

Best regards,
Scott

-- 
Scott Lamb <http://www.slamb.org/>
