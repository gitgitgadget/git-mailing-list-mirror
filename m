From: Anteru <newsgroups@catchall.shelter13.net>
Subject: Deciding between Git/Mercurial
Date: Sun, 27 Sep 2009 14:24:32 +0200
Message-ID: <h9nlhj$heq$1@ger.gmane.org>
Reply-To: newsgroups@catchall.shelter13.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 27 14:30:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrstL-000317-67
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 14:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbZI0MaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 08:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753874AbZI0MaD
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 08:30:03 -0400
Received: from lo.gmane.org ([80.91.229.12]:52006 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852AbZI0MaB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 08:30:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MrstA-0002yH-QY
	for git@vger.kernel.org; Sun, 27 Sep 2009 14:30:04 +0200
Received: from lmontsouris-156-26-18-33.w80-14.abo.wanadoo.fr ([80.14.177.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 14:30:04 +0200
Received: from newsgroups by lmontsouris-156-26-18-33.w80-14.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 14:30:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: lmontsouris-156-26-18-33.w80-14.abo.wanadoo.fr
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129207>

Hi,

I'm currently evaluating DVCS for a project, and we're at a point where
it comes down to either Mercurial or Git. Right now, I'm advocating for
Git, while my co-workers like Mercurial, so I'd like to provide some
good arguments in favor of git. Unfortunately, I'm not a git expert, so
I hope I can get some help here ...

First of all, what's the matter with git and Windows, is there some
long-term commitment to make git work on Windows as well as on Linux?
I'm using msysgit on Windows, and personally I'm happy with it, but my
co-workers constantly nag that Mercurial has superior portability ...

Mercurial's revision number system: With git, I get an SHA1 hash for
every commit, but it's not possible to see whether Hash1 is newer than
Hash2, while Mecurial also adds a running number to each commit. What's
the rationale behind this decision for git, and is it possible to
emulate Mercurial's behavior somehow?

Integration into tools: We're using Trac currently, which also has a
nice binding to Mercurial (well, obviously easy to do as Mercurial is
written in Python, just as Trac itself), while the git support is in
development and looks quite alpha'ish. Do you plan to make it easier to
integrate git with other tools by providing bindings to other languages,
or is this a low-priority issue?

So far, my key arguments are that git is more robust (more projects
using it, larger developer base), of course git's excellent performance
and the much better support for SVN, which is important for us as we can
slowly migrate from SVN->Git, while hgmercurial is still in the making
(and Python's SVN->Hg switch is for instance waiting for it).

Cheers,
  Anteru
