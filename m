From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Confusing error message in rebase when commit becomes empty
Date: Fri, 13 Jun 2014 08:25:43 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1406130823251.27436@ds9.cixit.se>
References: <alpine.DEB.2.00.1406111321090.6307@ds9.cixit.se> <CABURp0rC3yktDiRVQwo9E+x5_wKLnLVRx87ej+m+TyUdBkMpOA@mail.gmail.com> <alpine.DEB.2.00.1406111854180.21431@ds9.cixit.se> <CABURp0q1c+75VzMfttDWVXhTFma3g=Tj938J_9i9xhG1yuMpdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Fabian Ruch <bafain@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 09:25:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvLs5-000412-8B
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 09:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbaFMHZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 03:25:53 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:42686 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752591AbaFMHZw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 03:25:52 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s5D7PhR5004804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 13 Jun 2014 09:25:44 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s5D7PhGv004800;
	Fri, 13 Jun 2014 09:25:43 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <CABURp0q1c+75VzMfttDWVXhTFma3g=Tj938J_9i9xhG1yuMpdQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 13 Jun 2014 09:25:44 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251523>

Phil Hord:

> Did you have a series of three commits being squashed in your to-do
> list?  I mean, did you have a list like this:
>
>   pick ...  do foo
>   squash ...  revert "do foo"
>   squash ...  What I really meant to do.

Yes, that is exactly what I had. Plus an extra commit that I moved to 
the end, which was originally placed between the "do foo" and "revert 
do foo" commits (which is why I wasn't 110% sure the combination of 
the two would produce an empty commit).

> Yes, but empty commits are discouraged on some projects.  If you 
> want your "change + revert = empty" commit to appear after the 
> squash, I would expect you would want to use --keep-empty on your 
> inital rebase command.  But I'm not sure that will do what you 
> expected either; it may only keep previously-empty commits during 
> the rebase.

The thing is that I wasn't expecting it to come out empty, as I had 
another commit to squash into it. That the interim throw-away squashed 
commit was empty should have been an internal matter to rebase, IMHO.

-- 
\\// Peter - http://www.softwolves.pp.se/
