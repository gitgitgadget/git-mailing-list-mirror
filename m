From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 07:40:54 -0800 (PST)
Message-ID: <m3lk7sovt0.fsf@roke.D-201>
References: <20071217110322.GH14889@albany.tokkee.org>
	<506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
	<7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
	<57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
	<7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
	<20071218105941.GA17251@albany.tokkee.org>
	<Pine.LNX.4.64.0712181231420.23902@racer.site> <4767D7A2.30703@op5.se>
	<Pine.LNX.4.64.0712181445420.23902@racer.site>
	<4767E07A.2020100@op5.se>
	<Pine.LNX.4.64.0712181513060.23902@racer.site>
	<4767E717.2060902@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sebastian Harl <sh@tokkee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Dec 18 16:41:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4eZU-0007mZ-3G
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 16:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215AbXLRPlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 10:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757058AbXLRPlD
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 10:41:03 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:56280 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756807AbXLRPlB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 10:41:01 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1384400nfb.21
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 07:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=3rXBVBkMDNogB3FE1DraoUCzEWoo1cVc44c0RJtYpZI=;
        b=V6eVXcnMFoKeNjO6L/OtZnBKW//qGGFuLIabg+VTQ5LrOtD8k9nuBj+lktZftVy1g4iOffLwZzwdGe7DP26uJgb/zU5mkiszS9HCCzUXleSN9S/4ODG7gKJaQ1TTYXfPyGn4gHZrFW9NFez0jpsv4vYBfQnMp0ea82+KtRAOXvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=L6DHhusJGbNuOb9eaeeM37gqoxf+whvGTMbw/KZXuMgrxwnVY2Qw/e+Zqlhhdk1fjdxUPy2Xw/6J7AIsuipsyv0L/XIa8sKBvzXGw8+lbVRUFcPcESydITSY/2soeSWG9TtcJ6TpagDSX+TIJe5eJ93gv9XLeAdwiG+VZG8C5q8=
Received: by 10.86.96.18 with SMTP id t18mr7785619fgb.13.1197992455345;
        Tue, 18 Dec 2007 07:40:55 -0800 (PST)
Received: from roke.D-201 ( [83.8.255.201])
        by mx.google.com with ESMTPS id d4sm8003012fga.2007.12.18.07.40.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 07:40:54 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBIFejP5013693;
	Tue, 18 Dec 2007 16:40:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBIFeia6013690;
	Tue, 18 Dec 2007 16:40:44 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <4767E717.2060902@op5.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68763>

Andreas Ericsson <ae@op5.se> writes:
> Johannes Schindelin wrote:
>> On Tue, 18 Dec 2007, Andreas Ericsson wrote:
>>> Johannes Schindelin wrote:
>>>
>>>> In the alternative, you could just scrap all those default
>>>> actions, showing synopses instead.  For all commands, including
>>>> "git commit", "git log", "git fetch", etc.
>>>
>>> Like we do for the git wrapper, you mean? Yes, that would be one
>>> solution, although not a very good one for all commands.
>>
>> Exactly.  Not a good one.
>>
>>> It's probably not a bad idea for commands where the primary use is
>>> something else than producing visual output though, such as tag or
>>> branch, but those handle creation/deletion of stuff, so the default
>>> action for them is to list stuff of the kind they operate on. I
>>> fail to see why stash should be any different.
>>
>> I also fail to see why stash should be any different.  And that's why
>> I expect it to have a default operation, which is -- you guessed it -- 
>> "stash the changes!"
> 
> Actually, I guessed "list the stashes".
> 
>> If I am not sure what I am about to do, there is -- wonder of wonders -- 
>> the "-h" option!  And indeed:
>> 	$ git stash -h
>> 	Usage: /home/gitte/bin/git-stash [  | save | list | show |
>> apply | 		clear | create ]
>> So what exactly was your point again?
>>
> 
> My point is that it would be nice if all git commands that actually
> manipulate objects (create/delete/modify) had a safe default, and
> that experienced users such as yourself could endure the insufferable
> agony of retraining your fingers to type five more chars so that
> people won't have to get bitten by surprises.

Also for "git commit"?

In my opinion _basic_ usage of git-stash is simply using it with
one stash only: "git stash" / "git unstash" (i.e. "git stash apply";
by the way this is one (beside "git view") use case for builtin
predefined aliases).  Using it with multiple stashes (only then
"git stash list" is needed) is advanced usage; and for advanced
usage longer form is preferred, I think.

"git branch", "git log" and "git remote" are horse of differenc color
because the _cannot_ function without name of branch/tag/remote given,
so hey provide "list" when no name was given.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
