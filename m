From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to undo a git merge?
Date: Fri, 11 Jul 2008 10:13:35 -0700 (PDT)
Message-ID: <m34p6we43y.fsf@localhost.localdomain>
References: <fa7d16350807110916x689e316fr6bae01f28e2e1acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ff <ff@member.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 19:14:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHMCd-0002uv-0E
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 19:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbYGKRNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 13:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754245AbYGKRNk
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 13:13:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:3697 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbYGKRNj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 13:13:39 -0400
Received: by ug-out-1314.google.com with SMTP id h2so101485ugf.16
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=3H/oDtLEWW51Dgxa7ViW8Dr02SSQE3FdrmJ2y3vTxwE=;
        b=uFCVDZATrmaSasptvwSMwEJbGmrlpgHDzUFGdI5+wBPqXyVhAkLqf+DCNcBU2fS8DK
         6L6tx+oKq3/kKOajxytJflklVfqiONrD2T0pOxUZO6uKtZByD0xEI6bhJ+QP8Rl8zkRT
         QlUVYejURPU9Nj/EBEUr3AIjxiwrHUysc3LZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=qyAt1EHV5K3UsA29fbUODkVCN1LCFC9EouZJOw+4KlVedr7vY6uWSsciu2RcF0E9tK
         fvgPCfYR/STFV0yaxb8jQ0/qMjkXTgYyoB3PBBUMgnBoVHRmrpE2KCPvKDc8EXfyOGK6
         ZAiOF3JV+Vi2xM7I+8yjt7trJJ0g/YRtcEMjY=
Received: by 10.67.115.4 with SMTP id s4mr697580ugm.60.1215796417267;
        Fri, 11 Jul 2008 10:13:37 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.227.34])
        by mx.google.com with ESMTPS id a1sm2043745ugf.29.2008.07.11.10.13.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jul 2008 10:13:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6BHDQL7015707;
	Fri, 11 Jul 2008 19:13:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6BHDL9a015702;
	Fri, 11 Jul 2008 19:13:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <fa7d16350807110916x689e316fr6bae01f28e2e1acb@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88147>

ff <ff@member.org> writes:

> I have two git branches that stem from the same exact master branch.
> Many commits happened independently on these two branches overtime.
> Then, I inadvertently did a merge from one branch into another. The branch
> where I merged into now has mixed commits, and also a commit for the merge
> itself. I then had more commits added to the branch that I merged into.
> 
> Now I would like to revert the merge... what is the best way of doing that?
> I would like very much to use something like git-revert <merge_commit_id>
> But that does not seem to work.

If you have published history, then the only sane option is
"git revert -m".  If you haven't published history, you can
try "git rebase --interactive".

-- 
Jakub Narebski
Poland
ShadeHawk on #git
