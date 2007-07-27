From: David Kastrup <dak@gnu.org>
Subject: Re: gitk screenshots of complex history
Date: Fri, 27 Jul 2007 07:49:23 +0200
Message-ID: <85k5sm5rbw.fsf@lola.goethe.zz>
References: <20070727041300.GD20052@spearce.org>
	<alpine.LFD.0.999.0707262219210.3442@woody.linux-foundation.org>
	<20070727052934.GH20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:49:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEIhm-0006qm-Io
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759942AbXG0Ftg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759809AbXG0Ftf
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:49:35 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:59622 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751863AbXG0Ftf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2007 01:49:35 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 2BC4033696D;
	Fri, 27 Jul 2007 07:49:34 +0200 (CEST)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 1BBAC2DAB40;
	Fri, 27 Jul 2007 07:49:34 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-061-025.pools.arcor-ip.net [84.61.61.25])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id A249145475;
	Fri, 27 Jul 2007 07:49:33 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 511091C39595; Fri, 27 Jul 2007 07:49:23 +0200 (CEST)
In-Reply-To: <20070727052934.GH20052@spearce.org> (Shawn O. Pearce's message of "Fri\, 27 Jul 2007 01\:29\:34 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53897>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Fri, 27 Jul 2007, Shawn O. Pearce wrote:
>> > 
>> > I just compared my own history to Linus' linux-2.6 history.
>> > The kernel team can't hold a candle to this mess.
>> 
>> Rather on purpose, I might add. I've actually been fairly anal about 
>> having people maintain clean histories, to the point where I refuse to 
>> pull from trees that don't do a good enough job.
>
> For 4 of our internal repositories I've taken that policy up now
> myself, and nobody is allowed to create releases from them except me.
> This has helped.  A lot.  So does sensible use of `git rebase -i`.
> You and Junio have really sold me on the value of having someone
> play a very strict gatekeeper role.  I get better work product from
> my coworkers this way too.  They know someone else is looking at
> what they are doing and try harder.
>
> But it doesn't help the really old history, nor does it help
> the repository these images came from.  I don't own/control that
> development.  I just provide git help as much as I can.

One idea I have not yet put into any code is using graphviz for
creating a nice (possibly clickable) layout of a commit history.  It
might be able to rearrange things such that the long parallel lines
get avoided.  Could be an interesting feature for the HTML
visualizers.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
