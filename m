From: Thomas Riboulet <riboulet@gmail.com>
Subject: git faq : draft and rfc
Date: Thu, 16 Feb 2006 01:36:20 +0100
Message-ID: <22e91bb0602151636r2e70e60cpa5038f4b6caccc9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Feb 16 01:36:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9X8H-0006lB-0q
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 01:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWBPAgV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 19:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWBPAgV
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 19:36:21 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:53770 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751294AbWBPAgV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 19:36:21 -0500
Received: by zproxy.gmail.com with SMTP id x3so55553nzd
        for <git@vger.kernel.org>; Wed, 15 Feb 2006 16:36:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l//uM2EBi6WCRGa6YmfUmA5J4jqJyWnlP8r4LIHBnLUIM0KdK7Evuu/itJC+BaF2xrMJ2QWbKwFoqUyJknH/dkO9fhQRQYvgFDK38HL7VeqOd/cfbJ7pcm1GHh6MoWwrymLtn9Y/ccIivF4RYHXUOq0yerzZ6TLHPejUlaQTw+A=
Received: by 10.37.12.45 with SMTP id p45mr470260nzi;
        Wed, 15 Feb 2006 16:36:20 -0800 (PST)
Received: by 10.36.177.3 with HTTP; Wed, 15 Feb 2006 16:36:20 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16256>

hi,

After a quick talk on irc with pasky, fonseca and Tv, I've started to
write a git faq starting with questions I had and they have suggested.

I've setted up a git repos : http://git.librium.org/git_faq.git (atm
it's on my DSL link, so it could be slow, should move soon)

The faq is available in both docbook xml and text format (don't know
what you prefer).
You can see the html output there : http://koalabs.org/~ange/git_faq/faq.html
and the text file : http://koalabs.org/~ange/git_faq/faq.txt
if needed I can write specific xsl stylesheets to handle better or
more suited output.

Comments and suggestions are welcome (on the content, the form, format, etc ...)
I'll try to add questions from the archives of this ml, I'm also open
to any suggestions.

Here is a first (text) version :
----

. Why the 'git' name ?
As Linus' own words as the inventor of git :
"git" can mean anything, depending on your mood.
  - random three-letter combination that is pronounceable, and not
    actually used by any common UNIX command.  The fact that it is a
    mispronunciation of "get" may or may not be relevant.
  - stupid. contemptible and despicable. simple. Take your pick from the
    dictionary of slang.
  - "global information tracker": you're in a good mood, and it actually
    works for you. Angels sing, and a light suddenly fills the room.
  - "goddamn idiotic truckload of sh*t": when it breaks

. Can I use my git public repository in a shared way ?
Yes. Use cg-admin-setuprepo -g or do git-init-db --shared and some
additional stuff. It's ok that refs aren't group writable, it's
enough the directory is. See Cogito README or GIT's cvs-migration doc,
"Emulating the CVS Development Model" for details.

. Git commit is dying telling me "fatal : empty ident <user@myhost>
not allowed", what's wrong ?
Make sure your Full Name is not empty in chsh or the 5th field of your
user line in /etc/passwd isn't empty. If you @myhost is empty make sure
your hostname is correctly set.

. What's the difference between fetch and pull ?
Fetch : download objects and a head from another repository.
Pull : pull and merge from another repository.
See man git-fetch and git-pull for more.

. Can I tell git to ignore files ?
Yes. Put the files path in the repository in the .git/info/exclude file.

. Can I import from cvs ?
Yes. Use git-cvsimport. See the cvs-migration doc for more details.

. Can I import from svn ?
Yes. Use git-svnimport. See the svn-import doc for more details.

. What can I use to setup a public repository ?
A ssh server, an http server, or the git-daemon.
See the tutorial for more details.


--
Thom/ange
