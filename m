From: Xavier Maillard <xma@gnu.org>
Subject: Re: Switching branches without committing changes
Date: Sun, 23 Mar 2008 02:00:02 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803230100.m2N102oR025238@localhost.localdomain>
References: <A17C3E8C-3D0E-41B4-8A43-37EC8C3F55C2@faithfulgeek.org>
 <20080321040647.GE8410@spearce.org>
 <20080321041013.GA2502@coredump.intra.peff.net> <7vod98u1pr.fsf@gitster.siamese.dyndns.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: peff@peff.net, spearce@spearce.org, joe@faithfulgeek.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 02:39:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdFBF-0005Iw-34
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 02:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631AbYCWBin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 21:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755591AbYCWBin
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 21:38:43 -0400
Received: from master.uucpssh.org ([193.218.105.66]:41945 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585AbYCWBim (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 21:38:42 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id DC713D5B25; Sun, 23 Mar 2008 02:35:52 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2N104Rw025302;
	Sun, 23 Mar 2008 02:00:04 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2N102oR025238;
	Sun, 23 Mar 2008 02:00:02 +0100
In-reply-to: <7vod98u1pr.fsf@gitster.siamese.dyndns.org> (message from Junio C
	Hamano on Thu, 20 Mar 2008 21:42:56 -0700)
User-Agent: Rmail in GNU Emacs 23.0.60.3 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.382,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.02,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77864>


   Jeff King <peff@peff.net> writes:

   > On Fri, Mar 21, 2008 at 12:06:47AM -0400, Shawn O. Pearce wrote:
   >
   >> Use `git checkout -m` to switch the branch anyway.  However, if
   >> there is a merge conflict while you are trying to carry the changes
   >> to the other branch you may be faced with a merge conflict you are
   >> not prepared to resolve, or simply cannot resolve in a reasonable
   >> period of time.
   >
   > Ah, for some reason I didn't think of '-m' in the advice I gave (I guess
   > I have just never used it). It is almost certainly simpler than using a
   > 'stash' at this point (but I do think stashing _beforehand_ still has
   > advantages).

   The thing is, that -m is really to mollify people who are _too_ accustomed
   to CVS/SVN update behaviour.  Over there, "scm update" does not give you
   any choice other than having to merge.

This post is *yet* another valuable candidate to put onto the wiki.

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
