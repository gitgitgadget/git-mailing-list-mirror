From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: branch management
Date: Wed, 10 Jun 2009 07:43:25 -0700 (PDT)
Message-ID: <m3d49c40ai.fsf@localhost.localdomain>
References: <7vfxe9udln.fsf@alter.siamese.dyndns.org>
	<4A2E0C88.70805@gmail.com> <20090609080612.GG9993@laphroaig.corp>
	<7viqj5nzgz.fsf@alter.siamese.dyndns.org>
	<20090609172302.GH9993@laphroaig.corp>
	<08614AC584A6ED42BD836DE9286376E12A211FA9CA@spswchi6mail1.peak6.net>
	<20090609195018.GA17848@blimp.localdomain>
	<08614AC584A6ED42BD836DE9286376E12A211FA9D0@spswchi6mail1.peak6.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Alex Riesen'" <raa.lkml@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Harry Duin <hduin@optionshouse.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 16:43:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEP1m-0002aO-MS
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 16:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758022AbZFJOn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 10:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757114AbZFJOnZ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 10:43:25 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:42381 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329AbZFJOnY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 10:43:24 -0400
Received: by ewy6 with SMTP id 6so1058429ewy.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=eKTJ/jF7WK3NYuTBAcwPEh1XgJUG9YTfgtcFZd47cKE=;
        b=BxdbdVDysZOikoOn5aujOLvDvt0RV0QxNoRG/aqLRp0O1pPUCOSXeyo09mMIYgbIpD
         4KAFqLAZFlEeQERURDl5+1NiYuWNaFjuCeCoTige4oU2kbqrOb9BoSBxBfQaK5zGUU6e
         SZPbfGGBdVVgp11jUNMeAE9Nwzas0FC5K4MsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=rSi3uxxRhYdEaz/wCjNsTDJgOJN0N0hHx+ttxnypmV12GhKHTovWKhh3h3ALfwF1H6
         2zWh7VMUod1fmlFgubZL8oB2VoJEmndRS0ZLGFpS159FvaKfxlmpLslbqmvzf6M7Eqqo
         xZdn0k1ovpEZwBdOjRATqOEPn/yzsr1wVvF8M=
Received: by 10.210.130.14 with SMTP id c14mr547889ebd.55.1244645005923;
        Wed, 10 Jun 2009 07:43:25 -0700 (PDT)
Received: from localhost.localdomain (abvn21.neoplus.adsl.tpnet.pl [83.8.211.21])
        by mx.google.com with ESMTPS id 28sm147056eyg.44.2009.06.10.07.43.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Jun 2009 07:43:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5AEhLko028062;
	Wed, 10 Jun 2009 16:43:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5AEhIhT028059;
	Wed, 10 Jun 2009 16:43:18 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <08614AC584A6ED42BD836DE9286376E12A211FA9D0@spswchi6mail1.peak6.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121281>

Harry Duin <hduin@optionshouse.com> writes:

> Yes, I am aware that branching is different in git than what I have
> used so far with SVN. But apart from the implementation, I have some
> information that I want to gather about work done on a branch. Here
> are a few questions/scenarios that I want to make sure we can
> handle. Remember that our branches are mapped one to one to a Jira
> ticket.
>

First, the syntax to get all commits in a branch 'branch' which was
created ffrom trunk, i.e. branch named 'master' would be

  master..branch

See git-rev-list(1), git-rev-parse(1) and git-log(1) for details
of A..B syntax.

> 1. show all code changes performed on a branch (for code review)

$ git log -p master..branch

> 2. show list of files/directories touched by a branch (useful when
>    looking for past fixes, but are unsure where the fix was done)

If you can use pickaxe search (git log -S...), or git-blame, or just
looking throught "git log ... -- <path>", you can use

$ git rev-list master..branch | 
  git diff-tree --stdin -r --name-only |
  sort -u

(excluding sha1 hashes).

> 
> So far I have not found the exact syntax to get this information,
> but am convinced that git can provide it!

-- 
Jakub Narebski
Poland
ShadeHawk on #git
