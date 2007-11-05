From: Aghiles <aghilesk@gmail.com>
Subject: git pull opinion
Date: Mon, 5 Nov 2007 16:52:12 -0500
Message-ID: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 22:52:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9rx-00039d-6d
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbXKEVwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbXKEVwP
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:52:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:50073 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbXKEVwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 16:52:14 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1495664nfb
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 13:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ctjYJTPuU8+GCVUbmh9NlRrAPyu2fblDOPTtGixOD8M=;
        b=IP20ingNAmeMmUL+g+/CQMj/hEEUOWcsUQ1nQCphf5e+EVoTQJnAOUN7bgiHgIEX3NifYxSopIQ53yPKGFP95IbNgITzAFGUvC6QCImY7pInwGnJRdomcFufR4gsSmfZoYM3Df4IFNzLk5QgBS1a19iJkLTa9LkI9b3NGGfCL74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lhOYK/WGPvnChM9ihxzOclR00XKXllYqIKZHZeVUW1WX9Vk+5jqlN/6FMNmRZWYOXAR80q7B7QVbSCLPrQpE0Ens4nLdPD9HcERfmYeq9KaaCoiaNJ02mkTP+bisfvI0c+Q0/JYmcQz5M7jKdQIX1UNJ+EXQT+2sCPe3d8n91y4=
Received: by 10.78.157.19 with SMTP id f19mr4229115hue.1194299532751;
        Mon, 05 Nov 2007 13:52:12 -0800 (PST)
Received: by 10.78.185.1 with HTTP; Mon, 5 Nov 2007 13:52:12 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63566>

Hello,

I am not sure this is the best place to write about this. Anyway,
we just switched a couple of repositories to git (from svn) here
at work and one thing people find annoying is a pull into
a dirty directory. Before the "stash" feature it was even worse
but now we can type:

    git stash
    git pull
    git stash apply

But isn't that something we should be able to specify to the "pull"
command ? Additionally and if I am not mistakn, those commands will
create "dangling" commits and blobs. So one has to execute:

    git prune

Is there an "easier" way to pull into a dirty directory ? I am
asking this to make sure I understand the problem and not
because I find it annoying to type those 4 commands to perform
a pull (although some of my colleagues do find that annoying :).

For now, I am recommanding to my colleagues to commit very often
(even unfinished changes), pull, and then rebase the commits into
a more meaningful commit before pushing. Which seems to be a good
practice anyway,

Thank you for git,

- Aghiles.

ps; if someone is interested to hear what is the general opinion
on switching to git from svn in our company, I could elaborate.
