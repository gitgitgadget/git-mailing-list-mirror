From: David Kastrup <dak@gnu.org>
Subject: Re: How do I manage this setup with git-svn and/or git remotes?
Date: Fri, 17 Aug 2007 23:04:22 +0200
Message-ID: <85abspyisp.fsf@lola.goethe.zz>
References: <86y7gaxef5.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708171042570.30176@woody.linux-foundation.org>
	<86d4xmxbjf.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708171142510.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 23:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM8zo-0006Wz-Fw
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 23:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504AbXHQVEf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 17:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757483AbXHQVEf
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 17:04:35 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:33902 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757490AbXHQVEe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2007 17:04:34 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id DCBF619B762;
	Fri, 17 Aug 2007 23:04:32 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id CFB92ABF1B;
	Fri, 17 Aug 2007 23:04:32 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-047-037.pools.arcor-ip.net [84.61.47.37])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 843D81037E3;
	Fri, 17 Aug 2007 23:04:24 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 780C31C3D500; Fri, 17 Aug 2007 23:04:23 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708171142510.30176@woody.linux-foundation.org> (Linus Torvalds's message of "Fri\, 17 Aug 2007 11\:53\:06 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3974/Fri Aug 17 20:13:57 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56083>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 17 Aug 2007, David Kastrup wrote:
>> 
>> But it isn't an independent git project: the superproject has its
>> _own_ copy of dsp, with its _own_ specific commits and fixes that are
>> not supposed to ever end up in the dsp "mothership". 
>
> Sure. And that's different from any git "branch" exactly how?

Different directory structure.  That can't easily be rectified as far
as I can see since the stuff still needs to get synched with
Subversion.

> So you'd have different branches in the superproject - the way you
> always have when you have two copies of a git project. And then you
> merge between the two at will.

The problem is the different location: root vs subdirectory.

>> With Subversion, I can actually merge files in different projects
>> of the repository even when they are in different directory levels.
>> Of course, since Subversion does not track any merge info, that is
>> not an accomplishment.
>
> Right. Git can do that too. It's called "patches".

Yup.  The question is just whether it is possible to do better than
that.

>> Well, that would be at least quite handy for propagating upstream
>> dsp fixes into project/great.  How do I merge one project into a
>> _subdirectory_ of another one?
>
> There's a special "subtree" merge that does exactly that: it
> basically is the normal recursive merge, except it merges into a
> subtree.

Sounds like just the thing.

> I think that's how Junio does the "git-gui" merges. Junio?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
