From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2008, #02; Sun, 14)
Date: Sun, 14 Dec 2008 03:08:24 -0800 (PST)
Message-ID: <m3prjvdngm.fsf@localhost.localdomain>
References: <7v7i632mg9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 12:09:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBor7-00020p-06
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 12:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbYLNLI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 06:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbYLNLI2
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 06:08:28 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:45407 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbYLNLI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 06:08:26 -0500
Received: by ewy10 with SMTP id 10so2514295ewy.13
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 03:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=uhG6ZQ0ltC4gVRYoHqMLkKnr74caGWxm+PZUAaSa+b0=;
        b=hPXb7IlUWGRx67JDRAY3/h8VPGgieOmn7u+svMK6foTWm5YyXTUX5U4T+UVqCwvheV
         4uPwrGsmXac7nonPwv0Fe+VtDrDrdpbE+CnTcfyIpHBzJlK/IbtKiUsQLPQIvRLdVDCC
         pfU7z/TfoCKnQO9ydKhnMVio0ueCQ5C1XvuOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=ZVD7Y0J+ACKrwDiT8NQE6rSwiHPxa4zjy/Jsc2vrZcCvN1fDzXn2J0nX2S1mx10cDB
         BsQ3Om+ykkfRLYhHjVyA3BOSHnvioJn4s3K7a67wKyVahKHcBiCzL666tkLE1ve1N2g2
         fJhkpWsZiL2D6Ql6ZN2Wey4anYVxl2nWL4HTg=
Received: by 10.210.122.5 with SMTP id u5mr6457173ebc.83.1229252904849;
        Sun, 14 Dec 2008 03:08:24 -0800 (PST)
Received: from localhost.localdomain (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id 5sm800036eyf.18.2008.12.14.03.08.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 03:08:24 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBEB7roj015811;
	Sun, 14 Dec 2008 12:07:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBEB7bmA015806;
	Sun, 14 Dec 2008 12:07:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v7i632mg9.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103065>

Junio C Hamano <gitster@pobox.com> writes:

> ----------------------------------------------------------------
> [New Topics]
> 
> * jn/gitweb-blame (Thu Dec 11 01:33:29 2008 +0100) 3 commits
>  - gitweb: cache $parent_commit info in git_blame()
>  - gitweb: A bit of code cleanup in git_blame()
>  - gitweb: Move 'lineno' id from link to row element in git_blame
> 
> I've briefly looked at the resurrection of Ajaxy blame that comes on top
> of this series and it looked promising.

AJAXy blame in my opinion is not yet ready.  Close, but not yet.
At minimal I'd have to remove or separate the 'time to generate'
patch.

I wonder if it should made into 1.6.1 for the performance improvements
in 'blame' view...
 
> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
>  - gitweb: Optional grouping of projects by category
>  - gitweb: Split git_project_list_body in two functions
>  - gitweb: Modularized git_get_project_description to be more generic

It shapes nicely, and I think with one more commit on top (or with
extending topmost commit) we can have categories sorted in given
order, and not hardcoded to always be in alphabetic order.

> ----------------------------------------------------------------
> [Post 1.6.1 items]
> 
> * gb/gitweb-patch (Sat Dec 6 16:02:35 2008 +0100) 3 commits
>  - gitweb: link to patch(es) view from commit and log views
>  - gitweb: add patches view
>  - gitweb: add patch view
> 
> Updated series.  Reviews and Acks?

I'll try to find time to review (and most probably Ack) later today.
 
> ----------------------------------------------------------------
> [Graduated to "master"]
>
> * jn/gitweb-utf8 (Mon Dec 1 19:01:42 2008 +0100) 1 commit
>  + gitweb: Fix handling of non-ASCII characters in inserted HTML
>    files.
> 
> A bugfix.

What about

   + gitweb: Fix bug in insert_file() subroutine

Isn't it in the same topic branch?

I am very sorry for buginess of this patch series...

[...] 
> ----------------------------------------------------------------
> [On Hold]
> 
> * jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
>  - git-am --forge: add Signed-off-by: line for the author
>  - git-am: clean-up Signed-off-by: lines
>  - stripspace: add --log-clean option to clean up signed-off-by:
>    lines
>  - stripspace: use parse_options()
>  - Add "git am -s" test
>  - git-am: refactor code to add signed-off-by line for the committer

What happened to this series to be so stale^Wstalled?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
