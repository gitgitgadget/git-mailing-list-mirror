From: Arnaud Lacurie <arnaud.lacurie@gmail.com>
Subject: Re: [RFD] Proposal for git-svn: storing SVN metadata (git-svn-id) in notes
Date: Sat, 28 May 2011 15:30:54 +0200
Message-ID: <BANLkTimsmTHdJQNWsvmJxfCPUp5DV+nmYw@mail.gmail.com>
References: <201105281154.25223.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 28 15:31:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQJbt-0001yV-Fm
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 15:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab1E1NbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 09:31:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42242 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab1E1NbP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 09:31:15 -0400
Received: by vws1 with SMTP id 1so1873789vws.19
        for <git@vger.kernel.org>; Sat, 28 May 2011 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=tiH6vD6xeifLstiL92X+9KyrmcMw6RzVB4puPrgyp1s=;
        b=TTrRBixa15U3STfbGYgwAccxpEA7gREkmuvSA9Zoq5iqkCmxXKuBOTzEJ6WpfwuJPp
         m2mvd5ULULlwQWup+U9K5t1YXDQkLwapsaTK3lnHhCzIxdYIboaWzjMGIMK1rPsERkE4
         1SjHvAN0i5ikq8ECk7UClZUYf25vFR98Tow7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jI4U/xrxaP3mLF1p2eXIxFqoKY5EoEC6rOt6exUaP4dlgo6TE4aJgjqvzJQRy20A2a
         agCpUvZ9YVHp52EMu+083SaWOd76bFBWZfr+9rOttVNq6XPynVko9DvcQ2+ujnJWTgPc
         FSD3NLw4stdu0py/X1ImhrWaAIRdzVZdNwEOQ=
Received: by 10.220.42.7 with SMTP id q7mr1240449vce.43.1306589474185; Sat, 28
 May 2011 06:31:14 -0700 (PDT)
Received: by 10.220.189.8 with HTTP; Sat, 28 May 2011 06:30:54 -0700 (PDT)
In-Reply-To: <201105281154.25223.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174662>

2011/5/28 Jakub Narebski <jnareb@gmail.com>:
> Now that git supports annotating comments with `git notes` utility,
> could we have an option to git-svn which would make it store SVN
> metadata, i.e. git-svn-id: lines using git-notes (separate svnmetadata
> or git-svn notes ref)?

I think that it's a great idea, it would make git-svn more like git
itself without poisoning the git log indeed.
We're trying to do this with the gate between git and mediawiki :
http://www.spinics.net/lists/git/msg158701.html.
When it's done, feel free to have a look at the code. Doing it with
git-svn should be similar.

-- 
Arnaud Lacurie
