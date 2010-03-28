From: Thomas Anderson <zelnaga@gmail.com>
Subject: updating github.com forks, developing in remote branches and 
	svn:eol-style equiv?
Date: Sun, 28 Mar 2010 01:32:51 -0500
Message-ID: <15b345f1003272332u2f4d38ear5c8aeef9b35f5037@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 28 08:33:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvm3P-0000xA-KO
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 08:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab0C1Gcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 02:32:53 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64003 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab0C1Gcw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 02:32:52 -0400
Received: by pva18 with SMTP id 18so2030671pva.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 23:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=CHBhCcRjp/SAtor/hEs8xcc2WPZv/mkKsdgP1em/kr0=;
        b=BOXRXsPxDYIF/4/2pkDqDTcQlUvxzR5+Jv0fiLjPrIavnAougejDraEqK36YCUN811
         XKPpPG+oCw/UixzmQrFYKN2PpjCAz3XBskC5V/SFaZHvpCW3vJghxVy4rzNrpCQ4DlXJ
         Gsa3oIljHSjADIqbxyU7cC6XhYGwNe30lKhc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WEyetxvt5Bbo9N1W6/6dioIg6RokwTKUaMlIq77y/Sre0RrSuaFQFa5yCiI5xJSE+5
         pycz1nhINpKQT+aAiTkIJGQz2t7bUkmGTlBHNbzcPha+I5j2WvwbO89w+wA/2/iiIaiv
         W0Gay4nPNI8WtDLTz11ycPCkQhyXcDi1ZbVXk=
Received: by 10.143.167.17 with HTTP; Sat, 27 Mar 2010 23:32:51 -0700 (PDT)
Received: by 10.142.74.3 with SMTP id w3mr1314314wfa.243.1269757971738; Sat, 
	27 Mar 2010 23:32:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143379>

Say on github.com I fork a repository.  Two weeks later, updates have
been made to the original repository and now I want to update my fork.
 How do I do this?

One possibility that occurs to me: I can create a new remote
repository - let's say "upstream" - with the URL of the original
repository and I can pull from that instead of the forked "origin"
repository.  I can then push the updates to the forked repository.

Is that the best way to do it, though?  It seems to me that I ought to
be able to have my github.com fork pull updates itself without my
having to pull and push with my own local repo.

Also, I'm unclear how to develop in remote branches.  If I go to the
"Switch/Checkout..." dialog I can switch to, say,
"remotes/origin/random-branch".  I do that, make some changes to one
of the new files and I then try to push those changes back.  In the
local drop down menu I only see two local branches, however - "(no
branch)" and the default branch.  Why is that?  If I just switched the
branch to, say, "remotes/origin/random-branch", shouldn't I now be
seeing that branch locally?

Finally, is there any Git equivalent to SVN's svn:eol-style and if so
how do I take advantage of it?
