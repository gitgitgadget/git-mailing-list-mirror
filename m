From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [git subtree] documentation and new --squash mode
Date: Sun, 31 May 2009 07:12:47 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh24bff.n9t.sitaramc@sitaramc.homelinux.net>
References: <32541b130905301136i2d9ec05ew9ba54c6ca746af15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 31 09:13:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAfEJ-0007r2-5S
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 09:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbZEaHNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 03:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753037AbZEaHNE
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 03:13:04 -0400
Received: from main.gmane.org ([80.91.229.2]:36244 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738AbZEaHND (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 03:13:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MAfE7-0005G1-Pp
	for git@vger.kernel.org; Sun, 31 May 2009 07:13:03 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 31 May 2009 07:13:03 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 31 May 2009 07:13:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120383>

On 2009-05-30 18:36:18, Avery Pennarun <apenwarr@gmail.com> wrote:

> I've finally had some time to write an asciidoc man page for git
> subtree, which is included below for your convenience.

Great!  Thanks; I've been sort of holding off on trying this
for a while and this ought to push me.

I have a very high level question.  My situation is that I
am evangelising git at work, and the bulk of the audience
are SVN, with some VSS and CVS here and there.

As such, one of the main things I have to tell them is "you
can't just take a subdirectory of the main project and check
it out/work/commit, etc", and that "if you can plan it
properly you can do it using submodules".

The flaw in the above is that I myself have not yet used
submodules other than doing the toy example in the docs, and
am not confident of being able to solve arbitrary problems
that may be presented to me by folks.  The need to force
them to think and plan this in advance is also sometimes an
impediment.  [If you're surprised, you need to put "the
daily wtf" on your RSS feed ;-)]

As I understand the documentation (and past emails, snippets
of IRC traffic, etc) git subtree will help me do precisely
what I want -- a simple way to deal with this all-too-common
SVN-ism.  If not "simple", at least

  - simpler than submodules, and

  - no need for advance planning [1] about what parts will
    be subprojects.

Is my understanding correct?

Thanks,

Sitaram

[1] I do understand filter-branch quite well, and I know that
even without advance planning it is possible to separate a
subdirectory into its own repo using filter-branch.  I don't
fancy teaching *them* filter-branch, so that makes me
personally central to their projects, which is not scalable
at all.
