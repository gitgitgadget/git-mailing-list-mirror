From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2008, #04; Mon, 29)
Date: Tue, 30 Dec 2008 15:15:43 -0800 (PST)
Message-ID: <m3fxk5b6di.fsf@localhost.localdomain>
References: <7vocyt1is2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 00:17:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHnpl-0004oz-J3
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 00:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbYL3XPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 18:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbYL3XPr
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 18:15:47 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:36783 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbYL3XPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 18:15:46 -0500
Received: by ewy10 with SMTP id 10so5748323ewy.13
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 15:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ApJP9MMuwLmqvNHGgd/i6ojKUzxYhwhQMBjQP7+8wOY=;
        b=h+qU/R7JqZt/AfsGaxHS6P4x7rxqJBq46m5Z0+v2usy8YKplRQOjpPs2oBWW/hKyvX
         DGuGCfeEqu3yFSFJT8fmYKNXn2gnfIIJrwyzVjVIoj60svzGcMcyDa+me/jNeaPN4V5a
         M6iUkUiRuGyf7vzFFr+oj67qUqqizzEfl94vI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=KoOk5I44RdXLrkIDOL+xi3yLpKgsy0UrCFYJYzY4aL2rsxHQ4W6E2BT+9f+cTD6Kkz
         oK2Y+e3zj4YVVy43clFxNE+cuDug+BRgU69GDcNU0wDeuw/kQNlZ61/xf20RIqfCzOeM
         x6Q0rMu+rvX92bbAgdr0eW/WByU8QNtq5aqW0=
Received: by 10.210.22.16 with SMTP id 16mr4170745ebv.68.1230678944565;
        Tue, 30 Dec 2008 15:15:44 -0800 (PST)
Received: from localhost.localdomain (abwv44.neoplus.adsl.tpnet.pl [83.8.245.44])
        by mx.google.com with ESMTPS id c22sm39105898ika.20.2008.12.30.15.15.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Dec 2008 15:15:43 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBUNHGpA028583;
	Wed, 31 Dec 2008 00:17:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBUNHDbH028580;
	Wed, 31 Dec 2008 00:17:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vocyt1is2.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104224>

Junio C Hamano <gitster@pobox.com> writes:

> with '-' are only in 'pu' while commits prefixed with '+' are
> in 'next'.  The ones marked with '.' do not appear in any of the branches,
> but I am still holding onto them.
> 
> The topics list the commits in reverse chronological order.  The topics
> meant to be merged to the maintenance series have "maint-" in their names.
> 
> ----------------------------------------------------------------
> [Actively cooking]
> 
> * mk/gitweb-feature (Mon Dec 15 22:16:19 2008 -0800) 1 commit
>  - gitweb: unify boolean feature subroutines

Nice thing from what I remember (I assume it is last incantation?).
 
> * jn/gitweb-blame (Thu Dec 11 01:33:29 2008 +0100) 3 commits
>  - gitweb: cache $parent_commit info in git_blame()
>  - gitweb: A bit of code cleanup in git_blame()
>  - gitweb: Move 'lineno' id from link to row element in git_blame
> 
> Jakub seemed to feel they are not yet ready.

This is, I think, ready. It is incremental AJAX-y blame in gitweb
that is not yet ready; this is simple cleanup and performance
improvement.
 
> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
>  - gitweb: Optional grouping of projects by category
>  - gitweb: Split git_project_list_body in two functions
>  - gitweb: Modularized git_get_project_description to be more generic

I think this needs a bit more cooking; with one more commit I think
you can have categories within requested sort order, and not always
sorted alphabetically.
 
> * gb/gitweb-patch (Thu Dec 18 08:13:19 2008 +0100) 4 commits
>  - gitweb: link to patch(es) view in commit(diff) and (short)log view
>  - gitweb: add patches view
>  - gitweb: change call pattern for git_commitdiff
>  - gitweb: add patch view

I think it is ready, or almost ready. I'll try to review this series
within a week. Feel free to prod me if I forget.


P.S. BTW. what is the status on using parse_options among git
commands?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
