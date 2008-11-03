From: 7rans <transfire@gmail.com>
Subject: Re: commit type
Date: Mon, 3 Nov 2008 01:34:39 +0000 (UTC)
Message-ID: <loom.20081103T011526-296@post.gmane.org>
References: <loom.20081031T174821-603@post.gmane.org>  <ee77f5c20810311104m6044bf70r1d9d405fa04454e0@mail.gmail.com>  <loom.20081031T191102-81@post.gmane.org>  <alpine.DEB.1.00.0811010025570.22125@pacific.mpi-cbg.de.mpi-cbg.de>  <loom.20081101T034635-562@post.gmane.org> <3e8340490811021502p70ab40a1ocdc9fca012769a29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 02:36:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwoMh-00050W-GM
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 02:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbYKCBe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 20:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbYKCBe4
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 20:34:56 -0500
Received: from main.gmane.org ([80.91.229.2]:33335 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752878AbYKCBez (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 20:34:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KwoLA-0003q1-Cs
	for git@vger.kernel.org; Mon, 03 Nov 2008 01:34:48 +0000
Received: from 216.241.118.70.cfl.res.rr.com ([70.118.241.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 01:34:48 +0000
Received: from transfire by 216.241.118.70.cfl.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 01:34:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 70.118.241.216 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99895>

bd_ <bdonlan <at> gmail.com> writes:

> The problem with this approach is that it begins to dictate a set of
> annotations which are considered 'more important' by the git core than
> others. By allowing in your 'commit type', it sets a precedent that
> git will add random, possibly not backwards compatible metadata
> changes just to support the local policies of some subset of git
> users. It's far better to provide a generic feature that will cover
> all users; and using the commit description, with hooks to enforce
> proper format according to local policy, is just that.
> 
> If using the commit description, with hooks to enforce whatever
> formatting you prefer, is not sufficient for your needs, then it would
> be useful to discuss exactly how this would be deficient, and then
> possibly think about adding a /generic/ feature that meets your needs.

Except for going so far as to add full-on tagging to commits, I'd don't see how
it could be more generic. Perhaps I'm misunderstood. I'm not suggesting any
particular set of types, if that's what you think. Just the ability to add one.
For example:

  git commit -m "describe some change" --type anything-at-all

So the types *I* would use are 'major', 'minor' and 'bug', but others could use
whatever types they'd like. Ie. developers could have their one type policies.
And I agree, it would be cool to define hooks to enforce the policy.

The problem with adding them to the description is that other tools have no idea
about them and so can't not display them when they aren't wanted --a logging
tool is a good example. It is also means more complicated scripting is required
to do anything with them, not a huge deal, but a pita nonetheless.
