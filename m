From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2009, #02; Wed, 12)
Date: Fri, 14 Aug 2009 15:27:02 -0700 (PDT)
Message-ID: <m3k516nic0.fsf@localhost.localdomain>
References: <7vtz0co3xe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:27:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc5Fc-0005da-NI
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 00:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739AbZHNW1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 18:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbZHNW1G
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 18:27:06 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:61349 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756197AbZHNW1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 18:27:04 -0400
Received: by bwz22 with SMTP id 22so1384782bwz.18
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=/BKYCXD34Zark55Nt/XkdlNjRSjX4Ht+LTIqYLaQ31Y=;
        b=mLMSVkHsWIjUGrbmPZ4fcf1GmHYnLBpyGQco9mgQa0GFjPvES3pwgosuR/HusrRsKH
         2XbPGnXTPD0Cz+5U66JwsjgTHDi/Ap991IQ+wISV++0c/Y+DdaXM5lXmIfrQYG1LDOpu
         HZf+mgPtmTadyrQJwvgtXJxYcoZsl24oca3XU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=TOpfjyMQVwXF8lbKY3kuoN5isGtplXLjyO4OKc+QqDM8VnWntisxWpYDtbFMEc3WXf
         tZHgJZDmBeKMXNlW6tZHjxfxNx6tR0eUGFc9u+yOpdduWRYMelaToU8tsr6YEyPpRbwN
         LrP2jD0zDleQReo6dkLTJ5RBwzdCWvn2FYXNU=
Received: by 10.103.37.33 with SMTP id p33mr769679muj.132.1250288823272;
        Fri, 14 Aug 2009 15:27:03 -0700 (PDT)
Received: from localhost.localdomain (abwe173.neoplus.adsl.tpnet.pl [83.8.228.173])
        by mx.google.com with ESMTPS id s10sm8646221muh.47.2009.08.14.15.26.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Aug 2009 15:27:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7EMQ8Kn022954;
	Sat, 15 Aug 2009 00:26:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7EMPpsJ022948;
	Sat, 15 Aug 2009 00:25:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vtz0co3xe.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125964>

Junio C Hamano <gitster@pobox.com> writes:

> * mr/gitweb-xz (Thu Aug 6 10:28:25 2009 -0400) 3 commits
>  - gitweb: add support for XZ compressed snapshots
>  - gitweb: update INSTALL regarding specific snapshot settings
>  - gitweb: support to globally disable a snapshot format
> 
> This should be safe as long as it does not silently enable itself for
> folks who merely updated gitweb to this version without explicitly asking
> for the new format (but I do not remember if that is what the patch does).

The latest version (v5, from 6.08) has XZ compressed snapshot ('txz')
disabled by default.
 
> * zf/maint-gitweb-acname (Sun Aug 2 09:42:24 2009 +0200) 1 commit
>  - gitweb: parse_commit_text encoding fix

Good.

> * jn/gitweb-blame (Thu Aug 6 19:11:52 2009 +0200) 14 commits
>  - gitweb: Create links leading to 'blame_incremental' using
>    JavaScript
>  - gitweb: Incremental blame (proof of concept)
>  - gitweb: Add optional "time to generate page" info in footer
>  + Revert the four topmost commits from jn/gitweb-blame topic
>  + gitweb: Create links leading to 'blame_incremental' using
>    JavaScript
>  + gitweb: Incremental blame (proof of concept)
>  + gitweb: Add optional "time to generate page" info in footer
>  + gitweb: Add -partial_query option to href() subroutine
>  + gitweb: Use light/dark for class names also in 'blame' view
>  + gitweb: Add author initials in 'blame' view, a la "git gui blame"
>  + gitweb: Mark commits with no "previous" in 'blame' view
>  + gitweb: Use "previous" header of git-blame -p in 'blame' view
>  + gitweb: Mark boundary commits in 'blame' view
>  + gitweb: Make .error style generic
> 
> I haven't picked up Jakub's replacement to the second one from the tip.
> We probably should merge up to "Use light/dark" (aef3768) to 'master' and
> start the rest over.

That would be good idea.
 
[...]

What about 'gitweb: fix variable scoping issue in git_get_projects_list'
latest version of patch, adding (re)declaring $project_maxdepth,
$projectroot as global variables using our?  Or are you waiting for
response of our resident Perl expert: Randal L. Schwartz (merlyn)?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
