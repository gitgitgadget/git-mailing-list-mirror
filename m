From: Matthew Woehlke <mw_triad@users.sourceforge.net>
Subject: document git-svn --minimize-url option or make it default
Date: Thu, 18 Mar 2010 15:37:22 -0500
Message-ID: <hnu2u3$gqq$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 21:40:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsMW0-0006C7-CM
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 21:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab0CRUkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 16:40:18 -0400
Received: from lo.gmane.org ([80.91.229.12]:43061 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab0CRUkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 16:40:17 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NsMVh-0005vj-KA
	for git@vger.kernel.org; Thu, 18 Mar 2010 21:40:05 +0100
Received: from 65.207.248.83 ([65.207.248.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 21:40:05 +0100
Received: from mw_triad by 65.207.248.83 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 21:40:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 65.207.248.83
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.23) Gecko/20090825 Fedora/2.0.0.23-1.fc10 Thunderbird/2.0.0.23 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142516>

Here's a problem I was having. I was trying to clone branches/foo/bar 
from a certain repo, where the last change on branches/foo looked like:

    A /branches/foo
    A /branches/foo/bar (from /trunk/foo/bar:12345)

By itself I couldn't get this to work; it would check out the HEAD, but 
wouldn't follow the copy to fetch any history.

I tried --stdlayout, but that worked even worse; nothing got checked out 
whatsoever.

Finally by trial and error I figured out to use --minimize-url.

I'd like to ask that this be more properly documented, especially 
stating that it is necessary to follow copies between branches and 
trunk. Or better yet, given that not following such copies is arguably 
broken, make it the default (even without -T/-t/-b/-s).

-- 
Matthew
Please do not quote my e-mail address unobfuscated in message bodies.
-- 
It is training and experience that gives us the ability to abstract 
problems, remain objective, use previous knowledge, interact with users, 
and herd cats.
   -- Celeste Lyn Paul, on Usability Experts
