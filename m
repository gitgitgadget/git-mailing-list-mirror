From: David Kastrup <dak@gnu.org>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 08:16:08 +0200
Message-ID: <85ir75h2zb.fsf@lola.goethe.zz>
References: <1187716461.5986.71.camel@beauty>
	<20070821134030.b763e9d3.seanlkml@sympatico.ca>
	<1187817948.5986.159.camel@beauty>
	<alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
	<1187905879.5986.199.camel@beauty>
	<7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Josh England <jjengla@sandia.gov>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 08:16:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOSTU-0003Kq-35
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 08:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbXHXGQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 02:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760217AbXHXGQU
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 02:16:20 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:37320 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763364AbXHXGQQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 02:16:16 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id E005117F8D1;
	Fri, 24 Aug 2007 08:16:14 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id CF1461B8E45;
	Fri, 24 Aug 2007 08:16:14 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-032-149.pools.arcor-ip.net [84.61.32.149])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 967151B3262;
	Fri, 24 Aug 2007 08:16:10 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 740781C36605; Fri, 24 Aug 2007 08:16:09 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org> (Linus Torvalds's message of "Thu\, 23 Aug 2007 16\:30\:21 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4047/Fri Aug 24 03:14:44 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56548>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 23 Aug 2007, Junio C Hamano wrote:
>>
>> "Josh England" <jjengla@sandia.gov> writes: 
>> > Looking at the index struct, it already has fields in it for file mode
>> > uid and gid (woohoo!).
>> 
>> I can see that storing textual names in gitattributes and having
>> the root user run git so that it can chown(), would work.
>
> Well, the nice thing is that even non-root can actually resolve
> merge conflicts and generally use the archive, even if non-root
> obviously cannot then actually set the files to those users/groups!
>
> So handling ownership outside of the actual filesystem, in a
> separate file that git tracks, actually allows you to do things that
> you couldn't otherwise sanely do.

Well, about that "sane" bit: I don't see an application for tracking
unrestorable ownership values.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
