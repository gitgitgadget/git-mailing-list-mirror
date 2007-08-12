From: David Kastrup <dak@gnu.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 18:40:59 +0200
Message-ID: <85y7ggogdg.fsf@lola.goethe.zz>
References: <85ir7kq42k.fsf@lola.goethe.zz> <46BF1756.5070305@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 18:41:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKGVL-0004V4-CR
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 18:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759276AbXHLQlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 12:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755327AbXHLQlY
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 12:41:24 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:45698 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752522AbXHLQlW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 12:41:22 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 6E7A615C2B4;
	Sun, 12 Aug 2007 18:41:05 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 5B2B6100F6;
	Sun, 12 Aug 2007 18:41:05 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 292982BB62B;
	Sun, 12 Aug 2007 18:41:00 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 444701C3C79D; Sun, 12 Aug 2007 18:40:59 +0200 (CEST)
In-Reply-To: <46BF1756.5070305@midwinter.com> (Steven Grimm's message of "Sun\, 12 Aug 2007 22\:21\:10 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3935/Sun Aug 12 15:45:12 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55689>

Steven Grimm <koreth@midwinter.com> writes:

> David Kastrup wrote:
>> Mapping a repository into newsgroups (one per branch head?), complete
>> with threads, references, header display, article fetch (by
>> git-format-patch), Message Ids (=commit id) is much more
>> straightforward than creating an HTML server.  And it means that
>> everybody can use his favorite newsreader for navigating a repository.
>
> The news data model has one big problem. It is a tree structure (or
> rather, a set of tree structures). But git's ancestry graphs are not
> trees; a commit can have multiple parents as well as multiple
> children, and branches can join each other multiple times (via merges)
> as well as split off indefinitely.
>
> I realize that you can give a list of parent message IDs in a news
> header, but I'm going to go out on a limb and guess that all
> existing newsreaders expect that list to be a linear series of
> messages going back toward the root of the thread (since that's all
> that ever occurs in real netnews), rather than an arbitrary DAG.

Well, I never claimed that the threading display would necessarily be
correct.  But with most readers, you can turn it off.  And you can
even tell git to turn off merges in the revision lists.  After all, it
has to linearize things like "whatchanged", too.

> Not saying it's a worthless idea, but I bet you will not be able to
> get an accurate display of a repository's history using a news
> reader without modifying it to deal with more complex ancestry
> structures.

It would still be lots more convenient for finding one's way around
patch series than the current model.  And putting out every branch
into a group of its own (which makes merges somewhat close to
crosspostings in that the reader will not usually try tracking the
changes in the other group) would help keeping the peculiarities in a
single branch display limited.

At the current point of time, _all_ tools I have available for
browsing the history of a large project like Emacs suck _big_ time
compared to what my newsreader can handle.  They render my system
(256MB, about 1GHz) unusable if they work at all.  Being able to, say,
cherrypick stuff together by marking articles and piping the bunch
through git-am (which is what I sometimes do with articles on the git
list) would be quite nice.

And the charm over an http server is that an nntp server can basically
just serve git data raw, without the necessity to add any dressing.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
