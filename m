From: Jakub Narebski <jnareb@gmail.com>
Subject: Comparison of CVS and Git (was: Re: Migration from CVS to GIT)
Date: Thu, 23 Jun 2011 01:11:59 -0700 (PDT)
Message-ID: <m3mxh955nm.fsf_-_@localhost.localdomain>
References: <1308733591425-6503493.post@n2.nabble.com>
	<4E01CAD5.8080808@alum.mit.edu>
	<1308808706969-6507269.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: sandy2010 <sandeeptt@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 10:12:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZf1J-00058X-3O
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 10:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436Ab1FWIME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 04:12:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63695 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab1FWIMC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 04:12:02 -0400
Received: by fxm17 with SMTP id 17so1119066fxm.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 01:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=SBX+U4x2pgWlghrpVkjN6h5vN7O1QHtwPWJ+w2+GOQM=;
        b=ON9WqSNLgbl166+xv5WawjobdgPSjnEssnosDLKKStary+g3bschtQjBHoqOJjX8Ug
         0Rq250X0D8QcKFGOIF5G9aWecRMOakCNptobHK0CV/NGfYo3BQ6yri8dE0uAarLYLIgZ
         A4y5plTO42+QEwLvS/59SEajsgg7+kX8xpIkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=TsK6KzAy6sA0pkzq4YvERPPsNd0JlVsKFhY7vB2j6JWR6qrupJ5SuccMYxim3thQUR
         7+LyRRxb9UXKCso04bEkNjhLVK2r2Ly8pELXP+lMpjv9FGi2DmOYnniOs0MTh+Agoslr
         XKPk3f5ZrOpCUEkKirf7dKK9qsr9SsUuDK3io=
Received: by 10.223.5.13 with SMTP id 13mr2290035fat.1.1308816720913;
        Thu, 23 Jun 2011 01:12:00 -0700 (PDT)
Received: from localhost.localdomain (abva28.neoplus.adsl.tpnet.pl [83.8.198.28])
        by mx.google.com with ESMTPS id w15sm816464faj.47.2011.06.23.01.11.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 01:11:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5N8BPO8007347;
	Thu, 23 Jun 2011 10:11:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5N8BAMc007342;
	Thu, 23 Jun 2011 10:11:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1308808706969-6507269.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176265>

sandy2010 <sandeeptt@yahoo.com> writes:

> Thanks Michael! This worked like a charm! I was not aware that we can do such
> things in CVS. Can you point me to some good docs/articles on such
> comparison of CVS and Git?

A bit of self-promotion:

  "Difference between GIT and CVS" on StackOverflow (my answer)
  http://stackoverflow.com/questions/802573/difference-between-git-and-cvs/824241#824241

A blog post I recently found, describing how the workflow changed
rather that the differences between Git and CVS:

  "From CVS to Git, 9 Things I\u2019ve Learned" on EclipseSource blog
  http://eclipsesource.com/blogs/2011/06/09/git-lessons-learned/

This article describes how Git could came into being, IMHO quite well
presenting Git philosophy as well:

  "The Git Parable" by Tom Preston-Werner (of GitHub)
  http://tom.preston-werner.com/2009/05/19/the-git-parable.html


And just FYI, another tool to convert CVS to Git (non-incremental):

  http://cvs2svn.tigris.org/cvs2git.html

-- 
Jakub Narebski
Poland
ShadeHawk on #git
