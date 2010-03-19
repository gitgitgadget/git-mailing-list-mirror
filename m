From: Harry Putnam <reader@newsguy.com>
Subject: About single user setup for lightweights
Date: Thu, 18 Mar 2010 20:53:28 -0500
Organization: Still searching...
Message-ID: <87r5nht6uf.fsf@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar@lists.canonical.com, mercurial@selenic.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 02:53:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsRPN-0003HY-5o
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 02:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297Ab0CSBxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 21:53:48 -0400
Received: from lo.gmane.org ([80.91.229.12]:50622 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab0CSBxr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 21:53:47 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NsRPF-0003Fu-1u
	for git@vger.kernel.org; Fri, 19 Mar 2010 02:53:45 +0100
Received: from c-98-215-178-110.hsd1.in.comcast.net ([98.215.178.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 02:53:45 +0100
Received: from reader by c-98-215-178-110.hsd1.in.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 02:53:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-215-178-110.hsd1.in.comcast.net
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:N8tGX2cLii2Xp+tVbkp3cJgFKeQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142552>

Hold your fire on this one if possible.  I'm not just a lazy slug who
can't think and study for himself.

I'm a little confused about the different way of using rcs that git,
mercurial bazaar and probably several others offer.

I've not used anything but cvs.  I use it at least every couple of
days but really only a limited set of commands, and no deep knowledge
even of that style.

My usage is basically to keep up with rc files for the several OSs' I
tinker with on my home lan and a fair bit of scripting and
experimenting with shell, perl, c, etc. that I've built up over the
years and find reason to change a bit every so often.

I keep a central cvs repo and on each host I do a check out of the
entire thing from the base up.  Mostly to have copies of various style
of rc files the  OSs need but also to keep the scripts I've written
over the years and learned to rely on, available and in sync.

To me, keeping up with cvs is always a PITA.  I've never hit on a
handy and efficient way to do it. Even for a just my light usage.

And I do mean lignt.  For example, even after yrs of using cvs my
$CVROOT is still tiny:

  du -sh /usr/local/cvsroot
  12M	/usr/local/cvsroot

So, I'm wondering if one of the newer systems would be less of a PITA.

How would a workflow actually go:
I'd create and populate a repo, then what?.  Create clones on each
machine I guess and if I found a need to change or add files, I'd then
push back to the original repo?  Its sounding a whole lot like cvs so far.

So, am I likely to see some improvement in the chore of keeping up an
rcs system with git, mercurial or bazaar?

Anther thing I'm really curious about concerns binary rcs.  I'm thinking
of photo editing and things like flash where I might be changing a
project over time and want access to past versions.

I'm told cvs is not good for that... consequently I've never tried
it.  Am I likely to find that one of git, mercurial or bazaar is far
better for that?
