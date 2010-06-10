From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git and svn as target
Date: Thu, 10 Jun 2010 03:11:13 -0400
Message-ID: <AANLkTino5sVtNEFV5_nGi9NmlhBCc0-_4NhTZwKdDzho@mail.gmail.com>
References: <4C107BEB.6020209@fechner.net> <20100610060525.GA2177@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthias Fechner <idefix@fechner.net>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 10 09:11:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMbvR-0000Ti-2a
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 09:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab0FJHLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 03:11:35 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48568 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab0FJHLe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 03:11:34 -0400
Received: by gwj15 with SMTP id 15so568903gwj.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=zJL4HoFNpaFYWhXzZf8YNOxDbMgO0TvQYLo+Ic0HEWU=;
        b=OxxSs+xMYTo/bTSSx27LvErSTTs7WBaT6Bv7LEck9gCSH2igvDVuVanf6ke4UHBx8I
         WpluiLPV+aALBROWYu6ElZji/jSrHQsy0pqmWoYaT4XQAgYgv6Of3v1WjVM1bo+GYptD
         l0RoZCzXkif7PKW1YXlYbZJKtAbTE2Li69C2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TRoBVnppohyeW095H+A3pWDfxTiedhByn7T81tvwuzltFhFAKvTOYQD47sgDuh3fgA
         7BgjnJMNmXwDxDxtFdvdt9x4ZKBIEhAgXd1iHFNmyhBchYUDkGdSXS+SFWLpp/xWFBZt
         bwP03875CBx9laDsmdOZ5Ww5Q/DQzfnX7vEqE=
Received: by 10.150.114.2 with SMTP id m2mr885389ybc.327.1276153893223; Thu, 
	10 Jun 2010 00:11:33 -0700 (PDT)
Received: by 10.151.8.1 with HTTP; Thu, 10 Jun 2010 00:11:13 -0700 (PDT)
In-Reply-To: <20100610060525.GA2177@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148833>

On Thu, Jun 10, 2010 at 2:05 AM, Peter Baumann <waste.manager@gmx.de> wrote:
> On Thu, Jun 10, 2010 at 07:45:15AM +0200, Matthias Fechner wrote:
>> In the commit of svn I see only merged test...
>> Could I say git to put all the commit comments into the merge?
>
> AFAIK git svn doesn't handle git merges very well. If you rebase your test branch onto
> master and then do the git-svn dcommit, everything should work as expected.

Right.  I actually like it that way much more than I like rebasing
onto master, but that's a matter of opinion, of course.  Another
option would be to simply do "git svn dcommit" from the 'test' branch
rather than merging it into master first.  (This essentially asks
git-svn to do your rebasing for you, so it's roughly the same thing as
merge-rebase-dcommit.)

You might like to look at the option "merge.log" in "man git-config".
This summarizes your commit messages into the merge commit's commit
message, sort of like how svn itself does it.  Then you still only
have one merge commit - like you do in svn - but it has a useful
commit message.

Have fun,

Avery
