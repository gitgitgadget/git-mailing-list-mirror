From: David Kastrup <dak@gnu.org>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Fri, 03 Aug 2007 08:14:25 +0200
Message-ID: <858x8tw3em.fsf@lola.goethe.zz>
References: <200708010216.59750.jnareb@gmail.com>
	<alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	<7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
	<20070801092428.GB28106@thunk.org>
	<7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
	<87tzrjfe5h.wl%cworth@cworth.org>
	<alpine.LFD.0.999.0708010937050.3582@woody.linux-foundation.org>
	<7vejim1n92.fsf@assigned-by-dhcp.cox.net>
	<86tzrikz5x.fsf@lola.quinscape.zz>
	<7v3az1samx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 08:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGqQn-00049w-1Y
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 08:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbXHCGOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 02:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbXHCGOe
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 02:14:34 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:40211 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755293AbXHCGOd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 02:14:33 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id B4B9B27AC90;
	Fri,  3 Aug 2007 08:14:32 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id A24B823D303;
	Fri,  3 Aug 2007 08:14:32 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-210.pools.arcor-ip.net [84.61.0.210])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 620722351B7;
	Fri,  3 Aug 2007 08:14:32 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 959E61C4F931; Fri,  3 Aug 2007 08:14:25 +0200 (CEST)
In-Reply-To: <7v3az1samx.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 02 Aug 2007 17\:51\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3848/Thu Aug  2 22:22:06 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54674>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>  * With -l, as long as the source repository is healthy, it is
>>>    very likely that the recipient would be, too.  Also it is
>>>    very cheap.  You do not get any back-up benefit.
>>
>> Oh, but one does: an overzealous prune or rm -oopswrongoption in one
>> repo does not hurt the other.
>
> That's not "back-up" benefit I was thinking about.  It is more
> about protecting your data from hardware failure.  You
> physically have bits in two places, preferrably on separate disk
> drives.
>
> And that is what you do not get from hardlinked clone.

Not at the inode/blob level, but at least the directory manipulations
of one are safe from the other.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
