From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Pushing everything
Date: Sun, 31 Oct 2010 10:48:43 +0000 (UTC)
Message-ID: <loom.20101031T113039-859@post.gmane.org>
References: <loom.20101031T064406-734@post.gmane.org> <AANLkTikG5yTPwkjmnSv8yg2QRNNjDu_JxBdHzLBjO1RP@mail.gmail.com> <m28w1epu9o.fsf@whitebox.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 31 11:52:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCVWn-00034F-Lx
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 11:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226Ab0JaKs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 06:48:57 -0400
Received: from lo.gmane.org ([80.91.229.12]:57168 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755135Ab0JaKs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 06:48:56 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PCVT5-0001my-0j
	for git@vger.kernel.org; Sun, 31 Oct 2010 11:48:55 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 11:48:55 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 11:48:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.63)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160432>

Andreas Schwab <schwab <at> linux-m68k.org> writes:
> 
> Tay Ray Chuan <rctay89 <at> gmail.com> writes:
> 
> > On Sun, Oct 31, 2010 at 1:47 PM, Maaartin <grajcar1 <at> seznam.cz> wrote:
> >> I'd like to push all my branches and tags to the server, but for whatever 
reason
> >> "--all" ignores tags and is incompatible with "--tags". I could imagine 
there's
> >> a reason I'm not experienced enough to see?
> >
> > You can spell the refs explicitly, like this:
> >
> >   $ git push refs/heads/* refs/tags/*
> 
> The first argument needs to be a reference to a repository, so insert an
> origin here.

Nice, that works. It answers only a part of my questions, but maybe I can 
complete it. I want to use a repo as both a private backup (which everybody may 
read but nobody should) and a shared base. So maybe something like

git push origin +refs/heads/*:refs/heads/maaartin-* +refs/tags/*:refs/tags/
maaartin-* :

would do both the backup (where everything gets prefixed by my name) and normal 
pushing of tracking branches. Could it work? Should I try it out or can it be 
destructive?
