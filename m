From: David Kastrup <dak@gnu.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 21:48:34 +0200
Message-ID: <85sl6omt4d.fsf@lola.goethe.zz>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org>
	<9e4733910708121228v2fa8d356ld93efa7d1d5effd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:48:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJQV-0000Bt-Nz
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 21:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937107AbXHLTsg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 15:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936535AbXHLTsg
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 15:48:36 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:44767 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936633AbXHLTsf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 15:48:35 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 096D637A70C;
	Sun, 12 Aug 2007 21:48:35 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id F0E715BF30;
	Sun, 12 Aug 2007 21:48:34 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id D218D7FC5;
	Sun, 12 Aug 2007 21:48:34 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 82C991C3C79D; Sun, 12 Aug 2007 21:48:34 +0200 (CEST)
In-Reply-To: <9e4733910708121228v2fa8d356ld93efa7d1d5effd6@mail.gmail.com> (Jon Smirl's message of "Sun\, 12 Aug 2007 15\:28\:18 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55711>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> On 8/12/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> IOW, showing the whole history for a big project is simply pretty
>> expensive. If you have a hundred thousand commits, just keeping track of
>> the tree structure *is* going to take megabytes and megabytes of data.
>> Limiting the size of the problem is usually a really good solution,
>> especially since most people tend to care about what happened in the last
>> few days, not what happened five months ago.
>
> Could the topological graph for a packfile be computed at pack time
> and stored in the packfile so that gitk doesn't have to keep
> recomputing it? Does it work to merge multiple precomputed graphs
> retrieved from the pack files?

The parent information basically _is_ a bare-bones specification of
the topological graph.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
