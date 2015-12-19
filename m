From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: Help debugging git-svn
Date: Fri, 18 Dec 2015 22:31:13 -0600
Message-ID: <CAOc6etanJZub-rwqT-45WpKsutVe_wkDHbPS_RorxXLGHOE9tA@mail.gmail.com>
References: <CAOc6etaOKSN0KyB9v2caiQbaQBEGrHxi3NmFy3aJkFxczGdqHA@mail.gmail.com>
	<20151216074158.GB28518@dcvr.yhbt.net>
	<CAOc6eta=ZGyWFuBPAYe_4xWSH79RRmPcP5thCHYd8SsKScwW6g@mail.gmail.com>
	<CAOc6etaUUN_OdQqVJbHZ7XPq70hzEgO2HR1Uq0XxxEtK5CeDEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Dec 19 05:31:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA9BQ-0002lg-4n
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 05:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbbLSEbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 23:31:14 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36600 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbbLSEbN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 23:31:13 -0500
Received: by mail-pf0-f178.google.com with SMTP id o64so58818495pfb.3
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 20:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=idQ6qnL/wtjWSm424MB2lA0D12F37cvgPyCa5xBihrs=;
        b=rDjZWWEcBfR6B82qMyGwMHDUR9iheEgdDILJq/ugWqwOFEq1eHa/TEJfsk+NLQJpz2
         xLYs3A1lWR41sJFCl+HJSDuLUhhrBHesNvnjmnrjkuLhJ+ySTORwY4CGXz+Uz+ivk/R7
         gvM/PwYqOR2L6YgrNrPwD68BEznEfFIkKfduV2nlomavsnWEpDqL47u1xkZtRdbxI5Xd
         Lel2cNFpTD5x/VUg5obHp5WJ9IpIx8rCNFKyE/lXSQRJhW5JugniP1MXh+g+AZOims/v
         PY3Ccdpvf87p2Kr5R2hG3YVpIQXZiL3yNiN1pxWqx2vFpkdsSei8Q8JFX2wFHj8if33D
         JMTg==
X-Received: by 10.98.67.74 with SMTP id q71mr10353028pfa.134.1450499473466;
 Fri, 18 Dec 2015 20:31:13 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Fri, 18 Dec 2015 20:31:13 -0800 (PST)
In-Reply-To: <CAOc6etaUUN_OdQqVJbHZ7XPq70hzEgO2HR1Uq0XxxEtK5CeDEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282734>

On Fri, Dec 18, 2015 at 11:28 AM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> Ok.... I came up with another idea to avoid having to deal with the
> old svn history (I'm having no problems fetching/dcommitting with my
> current repo). I already have the branches I work with, the thing is
> that the revisions I fetched before I started using the svn authors
> file have nasty IDs instead of human names. I though that I could
> create a script to rewrite the whole history of the project adjusting
> the usernames to real names (I'll take care of the details, no problem
> there... just found out about filter-branch, could work for what I'm
> thinking of). My question would be in the direction of rebuilding
> git-svn metainfo once I'm done so that I can continue fetching from
> svn as if nothing had happened. I checked the documentation in
> git-scm.com but didn't find the details about it. Is there a
> straight-forward document that explains how the git-svn metadata files
> are built?
>
> Thanks in advance.

.rev_map files appear to be simple enough. I'll have fun with them a
little bit. Will let you know how it goes later (don't hold your
breath.... it might take a while).
