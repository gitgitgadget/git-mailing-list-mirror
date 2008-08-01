From: David Kastrup <dak@gnu.org>
Subject: Re: Git vs Monotone
Date: Fri, 01 Aug 2008 11:57:53 +0200
Message-ID: <86abfxawgu.fsf@lola.quinscape.zz>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
	<alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org>
	<63BEA5E623E09F4D92233FB12A9F79430238A5EC@emailmn.mqsoftware.com>
	<alpine.LFD.1.10.0807311244240.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 11:59:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOrPm-0003R5-My
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 11:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbYHAJ6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 05:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbYHAJ6L
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 05:58:11 -0400
Received: from main.gmane.org ([80.91.229.2]:45264 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746AbYHAJ6K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 05:58:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KOrOf-0006VK-6R
	for git@vger.kernel.org; Fri, 01 Aug 2008 09:58:05 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 09:58:05 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 09:58:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:YDDd135qXwLKE9zY+9XUV8wDRWg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91049>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 31 Jul 2008, Craig L. Ching wrote:
>> 
>> It's possible he's doing that, but it's also possible he just isn't that
>> familiar with git.
>
> Possible. But it really sounded like he didn't even try. Because quite 
> frankly, if he had even bothered to _try_, he wouldn't have gotten the 
> numbers he got.
>
> The fact is, even without "-s", a local clone will do hardlinks for the 
> database.

That means that git takes up less disk space.  It does not mean that it
looks like it.

If you do a df before and afterwards, you'll notice (but that does not
seem reliable as other changed might happen in the file system).  If you
do "du" into the individual clones, you won't notice it.

It is quite plausible that he might have tried it, but misinterpreted
the results.

It is a similar situation with size estimates when sparse files are
involved: they may take up less space than what it looks like.

-- 
David Kastrup
