From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Template commit messages.
Date: Sun, 5 Aug 2007 13:32:48 +0100
Message-ID: <18071eea0708050532x2d9bfddw96a9428f4840b1fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 14:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHfHw-00087B-Uw
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 14:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799AbXHEMcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 08:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755830AbXHEMcu
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 08:32:50 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:18579 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789AbXHEMct (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 08:32:49 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1456182wah
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 05:32:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qoDq7EfymLLzgp1ObPtH48S6QpPvchL4pICvueYU2zflHj8RMxYchOG2yHiZvZip2LBGBdKnt6ITUdZIkzaDO0/6/6uw7aTBt14i8+e2L97em4ovceM9bWD9j2VkSFDaE4alDgS9cJxc/9bD+J+ysAzMTNw80fbNDEBjCohiKRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tabTRvbljwmsNYIqJ6jweBxuOQ7Sx7Yfme9y8EgZs1VBgqphZ7RWfNJiSDePR/uzNv6mpx1ssxWZvATnOiyWJsoz63loxiiE1/r3hfj3G36ogM+pa0KQqGlQDbjdlp0lGXb9YnhCAhQobueq/sOPC5LVGhqb6f/65lfpDqfMLc8=
Received: by 10.115.55.1 with SMTP id h1mr4681941wak.1186317168843;
        Sun, 05 Aug 2007 05:32:48 -0700 (PDT)
Received: by 10.114.135.16 with HTTP; Sun, 5 Aug 2007 05:32:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55009>

Hello all,

Am I correct in thinking that the new template messages that will be
in the up and coming git release will alleviate an "annoyance" I've
currently got with commit messages?

Basically, I want a way of removing what is now, a long list of
untracked files from the commit message before it hits the editor --
I've looked at $GIT_DIR/.git/hooks/{pre,post}-commit as well as:
$GIT_DIR/.git/hooks/commit-msg in the hopes I could add  a sed command
there to remove the list of files, and whilst the sed command worked
fine on the command line, adding it to any of those files didn't.

Was this even the right approach?  I didn't want to go messing with
git-commit, frankly, so I am hoping that these new templates might
just do the trick.

You might ask why I've got such a large list of untracked files -- the
reason is because I use the same repository to build files in, which
themselves have no need to be added.  And whilst I can catch some of
these instances by using .gitignore, it's not enough since not all of
the files have a common extension or anything.  And whilst I realise
the list of untracked file is just a friendly warning to me, I find it
annoying and would rather it didn't appear at all if possible, since I
know myself which files need explicitly adding.  :)

Hope that makes sense, at least.  :)

Kindly,

Thomas Adam
