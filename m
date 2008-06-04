From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 04 Jun 2008 00:39:07 -0700 (PDT)
Message-ID: <m3r6bdzm22.fsf@localhost.localdomain>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David <wizzardx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 09:40:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3nbT-0007ci-8z
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 09:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbYFDHjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 03:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754015AbYFDHjO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 03:39:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:8049 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbYFDHjL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 03:39:11 -0400
Received: by ug-out-1314.google.com with SMTP id h2so230361ugf.16
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 00:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ZZZK1t4z3Asqd287y39a5HU83307GUKV3ZBrUlXZXdc=;
        b=A0MsCx/zmC0ctUyROZedu3UIdJtilG+oPhYDryf+SJBEChIPu+/bbcBRkzJnxyM5Yy
         RMmx+jyGO6C1Fnz0ZE9Y7FJrhKojxPg5JD6O2GEDXfKBw6QdOeUqVQx7mcN7kSXvbTTq
         2jvfB/gDZoxAZ6afeG45kg9MfhX+fXPGIS1M0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=LeCQnGf6hckIv6sVUCQYAVjtp95UftJ+NezLVd9vnTuVSyVLAlgwQ0l31EO/Fh64Cy
         K2UULDjdz1uL1umi2kuKFLJMALqcTol07SsVtIowWHJoHvowVQXgUdAL5RmtI2nyTT1R
         YXADQsMoj9ONWqWNnxEn+6PMT3ZPG87Mc0GJM=
Received: by 10.66.234.13 with SMTP id g13mr175903ugh.5.1212565149304;
        Wed, 04 Jun 2008 00:39:09 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.199])
        by mx.google.com with ESMTPS id i39sm11716498ugd.28.2008.06.04.00.39.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 00:39:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m547d3Kb001861;
	Wed, 4 Jun 2008 09:39:03 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m547d1Fh001857;
	Wed, 4 Jun 2008 09:39:01 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83754>

David <wizzardx@gmail.com> writes:

> I've tried Googling for these, and checked the FAQ.
> 
> 1) Is there a separate Git Users mailing list or FAQ?
> 
> So that git noobs like myself don't bother the developers directly :-)
> Also so that non-git-developer users who want to help other users
> don't get a lot of mails with patches & git internal development
> discussions.

There is Git User's mailing list ("Git for human beings", heh)
  git-users@googlegroups.com
  http://groups.google.com/group/git-users
  nntp://news.gmane.org/gmane.comp.version-control.git.user
 
There is GitFaq at Git Wiki:
  http://git.or.cz/gitwiki/GitFaq

> 2) Is it possible to cherry pick multiple patches?
> 
> Sometimes git rebase isn't appropriate, and it's a pain to do multiple
> 'git-cherry-pick' commands. Here is my current recipe:
> 
> for C in $(git log --reverse <commit1>..<commit2> --pretty=format:%H);
> do git-cherry-pick $C; done
> 
> Is there an easier syntax for doing this?

 $ git rebase --onto
 $ git rebase --onto --interactive

(if you want to copy, just create new branch using "git branch", or
something).

Why can't you simply use merge, BTW?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
