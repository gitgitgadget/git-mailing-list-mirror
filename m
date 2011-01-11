From: "Philipp Marek" <philipp@marek.priv.at>
Subject: Re: [RFC] Support for arbitrary tags in commits
Date: Tue, 11 Jan 2011 14:48:59 +0100 (CET)
Message-ID: <edec2e42a531b00ffd6a2689095460d5.squirrel@webmail.hitco.org>
References: <74b0628dffbd2bc0adabe5e8b0a10960.squirrel@webmail.hitco.org>
    <201101111340.50508.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 11 14:49:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pceb4-0004Bf-2t
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 14:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020Ab1AKNtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 08:49:08 -0500
Received: from vps.hitco.at ([84.200.20.238]:46966 "EHLO vps.hitco.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754144Ab1AKNtH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 08:49:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by vps.hitco.at (Postfix) with ESMTP id 0AC439C68001;
	Tue, 11 Jan 2011 14:49:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at vps.hitco.at
X-Spam-Flag: NO
X-Spam-Score: -4.282
X-Spam-Level: 
X-Spam-Status: No, score=-4.282 tagged_above=-999 required=6.31
	tests=[ALL_TRUSTED=-1.8, AWL=0.117, BAYES_00=-2.599]
Received: from vps.hitco.at ([127.0.0.1])
	by localhost (vps.hitco.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 36Vo5gU78ZoV; Tue, 11 Jan 2011 14:48:59 +0100 (CET)
Received: from webmail.hitco.org (localhost.localdomain [127.0.0.1])
	by vps.hitco.at (Postfix) with ESMTP id 0AB7D8F40002;
	Tue, 11 Jan 2011 14:48:59 +0100 (CET)
Received: from 86.59.100.100
        (SquirrelMail authenticated user flip)
        by webmail.hitco.org with HTTP;
        Tue, 11 Jan 2011 14:48:59 +0100 (CET)
In-Reply-To: <201101111340.50508.trast@student.ethz.ch>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164944>

Hello Thomas,

thank you very much for the quick answer.

>> The best way I've found (so far) is to put an additional header line in the
>> commit header that references an additional blob.
>
> This comes up every few months.  The last large discussion about this
> that we had IIRC was
>
>   http://thread.gmane.org/gmane.comp.version-control.git/138848
>
> Can you please look through that thread and state in what way your
> use-case invalidates the previous reasoning?
Thank you, just reading it.

> In particular, in what way do notes (as in git-notes(1)) fail to solve
> your problem?
Well, my biggest concerns are that users might trash them, and that they are
voided by amend, rebase etc. (which I tried to address by collecting header
lines).


Well, from this thread I suppose the "best" (or at least easiest) way forward
is to use notes, if necessary.


Thank you!


Regards,

Phil


-- 
Versioning your /etc, /home or even your whole installation?
             Try fsvs (fsvs.tigris.org)!
