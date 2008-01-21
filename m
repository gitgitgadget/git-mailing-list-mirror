From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: gitk layout bug
Date: Mon, 21 Jan 2008 11:13:33 +0100
Message-ID: <4794704D.2060607@viscovery.net>
References: <alpine.LFD.1.00.0801191740020.2957@woody.linux-foundation.org> <18324.27370.96611.769276@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 11:14:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGtg2-0001K1-NB
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 11:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764035AbYAUKNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 05:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764032AbYAUKNj
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 05:13:39 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6316 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764020AbYAUKNi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 05:13:38 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JGtef-000379-TA; Mon, 21 Jan 2008 11:13:26 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 17182A33B; Mon, 21 Jan 2008 11:13:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <18324.27370.96611.769276@cargo.ozlabs.ibm.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71251>

Paul Mackerras schrieb:
> Linus Torvalds writes:
> 
>> In the current git repository, try this:
>>
>> 	gitk origin/master..origin/pu
>>
>> and it starts out looking ok.
>>
>> But then scroll down a bit (say, press "PageDown" ten to twenty times), 
>> and scroll up again, and now that thing is totally unusable.
>>
>> Is it just me?
> 
> No, I have seen it occasionally (though not recently), but I've never
> been able to trigger it when I had some time to debug it. :/
> 
> I'd be interested to know if you can trigger it with the "dev" branch
> of gitk, too.  The dev branch doesn't use --topo-order or
> --date-order, but instead does the topological sort itself, so the
> cold-cache case is a lot faster (and the hot-cache case goes just as
> fast as before).  And because I can now reorder the commits, I can put
> each open-circle commit just after the last merge that has it as a
> parent, which ends up looking much nicer too.

The dev branch is fine in this regard. In fact, this is the primary reason
why I'm using it.

BTW, there are still a few layout glitches, in particular, when F5
(Update) is used after frequent rebase/cherry-pick/commit/--amend. I'll
bug you once I know how to reproduce them.

-- Hannes
