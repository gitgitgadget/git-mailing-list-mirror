From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 02:11:51 +0200
Message-ID: <857iodxyrc.fsf@lola.goethe.zz>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
	<7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
	<20070802232126.GU29424@schiele.dyndns.org>
	<85k5sdy0lk.fsf@lola.goethe.zz>
	<20070802234515.GW29424@schiele.dyndns.org>
	<85d4y5xznj.fsf@lola.goethe.zz>
	<20070803000113.GX29424@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 02:12:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGkmA-0000F0-Qy
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 02:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757939AbXHCAMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 20:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757556AbXHCAMA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 20:12:00 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:36891 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756677AbXHCAL7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 20:11:59 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 4493731EEC6;
	Fri,  3 Aug 2007 02:11:58 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 37181212FB4;
	Fri,  3 Aug 2007 02:11:58 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-245.pools.arcor-ip.net [84.61.49.245])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 1CBC330A919;
	Fri,  3 Aug 2007 02:11:58 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3BB1B1D0344E; Fri,  3 Aug 2007 02:11:51 +0200 (CEST)
In-Reply-To: <20070803000113.GX29424@schiele.dyndns.org> (Robert Schiele's message of "Fri\, 3 Aug 2007 02\:01\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3848/Thu Aug  2 22:22:06 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54653>

Robert Schiele <rschiele@gmail.com> writes:

> On Fri, Aug 03, 2007 at 01:52:32AM +0200, David Kastrup wrote:
>> I was starting to doubt my sanity here.  Sorry that this thread
>> resulted in wasted work for you.
>
> That's ok.  I mean I didn't spot the SHELL_PATH thing in the first
> place although I already had seen that one before (what I remember
> now).
>
> At least in that case I don't have to worry any longer since I
> always can put some compliant shell at some random place and use
> that one.
>
> But at least you have learned now that not everything in the real
> world looks like as it is written in some standard books. ;-)

You are aware that I am the maintainer of AUCTeX?  Which has an
autoconf-based setup that works under AIX, Solaris, MinGW, Cygwin,
HP/UX and a few other oddities, all with the respective native tools?

I know more about stupid shells than I really want to.  But that does
not change that I could not imagine a shell such as yours to work
"mostly" with the current git code base.

For autoconf, it is fine to call sed (and you would probably not
believe how small the portable language subset for sed is) all the
time.  Performance is not an issue.  For normal user commands, this is
different.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
