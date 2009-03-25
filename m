From: Eric Raible <raible@gmail.com>
Subject: Re: reverting initial commit
Date: Wed, 25 Mar 2009 21:06:40 +0000 (UTC)
Message-ID: <loom.20090325T205905-856@post.gmane.org>
References: <49CA7428.70400@obry.net> <7v1vsl4fxo.fsf@gitster.siamese.dyndns.org> <8c9a060903251133x33749041oc2a5152097da0ae8@mail.gmail.com> <gqe1kf$pg1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 22:08:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmaKo-00030z-6Q
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbZCYVG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbZCYVG6
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:06:58 -0400
Received: from main.gmane.org ([80.91.229.2]:40580 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755237AbZCYVG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 17:06:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LmaJI-0001Yh-1j
	for git@vger.kernel.org; Wed, 25 Mar 2009 21:06:52 +0000
Received: from adsl-75-24-106-84.dsl.pltn13.sbcglobal.net ([75.24.106.84])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 21:06:52 +0000
Received: from raible by adsl-75-24-106-84.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 21:06:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.24.106.84 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.48 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114663>

Giuseppe Bilotta <giuseppe.bilotta <at> gmail.com> writes:

> Actually, rebase --interactive cannot be used to amend the first commit.
> This is something that has hit me a couple of times when I realised, after
> the second or third commit, that I needed to fix the first one. I found
> the fastest way in this case to be to just format-patch all but the first
> commit, reset --hard to the first commit, amend, and git am what I format-
> patched.
> 
> I wish there was a way to tell rebase -i to go back to the first commit,
> inclusive, but the two or three times I've tried hacking at it I never
> managed to come to anything useful 8-/

I like to be able to rebase -i back to the first commit as well,
which is why I generally start off with:

git init && git commit --allow-empty -m'initial commit'

- Eric
