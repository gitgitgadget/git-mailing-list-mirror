From: Aaron Gray <aaronngray.lists@googlemail.com>
Subject: Re: problems getting uptodate from a remote repository
Date: Tue, 19 May 2009 17:09:38 +0100
Message-ID: <9719867c0905190909q74e4a6b9r4857fb6f32ff394@mail.gmail.com>
References: <33710F9891EA4BFD8ACD60798E354138@HPLAPTOP> <9719867c0905190908n2364da92s88ad646e8667298c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 18:10:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6RtH-0002xR-OL
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 18:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbZESQJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 12:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753095AbZESQJ7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 12:09:59 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:52533 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbZESQJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 12:09:58 -0400
Received: by bwz22 with SMTP id 22so3926026bwz.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=AiTrcfT4iwyvejb43FIK1cAigLjf32SGBo6tFE4ged8=;
        b=E68rgUr6celkW4VbDPiHTi+DbxGWa+4HCMNvxs7pnYHh0nMa81oGauBDGzUvw52OXU
         ooo4hfc1cHLG9aAANv4sMoWScEtke/iBD685HYiKqKyBv45xJdCcw9NPQsH99/6sDH/b
         JXNer1FP08Jx3W6ulhSXfomPmIku3ob1vvjGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=kRqFv7ykgbzXQ/wXsEI48OUspD/weN9LPxW4XGxKEoBrabmPxaNq84HoKfMXLccHk+
         s08nl3wA4AnPnRV/kvd0MRDRJSx0nvc62bdf+cw5s5g2f1zT75WGWZF6L6PGOPbHeAfU
         6m/Kyl9BaLLFIjQfdD0qcn9HrEIMXZrdzkTUU=
Received: by 10.204.62.68 with SMTP id w4mr195035bkh.93.1242749398543; Tue, 19 
	May 2009 09:09:58 -0700 (PDT)
In-Reply-To: <9719867c0905190908n2364da92s88ad646e8667298c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119541>

I have done a 'git fetch' but the repo is not being updated to latest changes.

I am getting the message :-

    "Your branch is behind 'origin/master' by 53 commits, and can be
fast-forwarded.

when I do a 'git checkout master'

What is going on here and what can I do about it ?

Here's my config :-

$ git config -l
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
remote.origin.url=git://git.cybercomms.org/llvm/trunk/.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.master.remote=origin
branch.master.merge=refs/heads/master

Many thanks in advance,

Aaron
