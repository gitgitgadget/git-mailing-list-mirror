From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] rebase--interactive: do not use one-or-more (\+) in sed.
Date: Sun, 02 Sep 2007 09:20:08 +0200
Message-ID: <85zm05ttxz.fsf@lola.goethe.zz>
References: <200709010925.27926.johannes.sixt@telecom.at>
	<7vmyw6u5ca.fsf@gitster.siamese.dyndns.org>
	<7vejhiu565.fsf_-_@gitster.siamese.dyndns.org>
	<85abs5v9q1.fsf@lola.goethe.zz>
	<7vfy1xr1lz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 09:20:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRjl9-0004g8-9S
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 09:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932819AbXIBHUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 03:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932920AbXIBHUP
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 03:20:15 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:54235 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932309AbXIBHUN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 03:20:13 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 559CF2F28B0;
	Sun,  2 Sep 2007 09:20:12 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 48BB92D29B9;
	Sun,  2 Sep 2007 09:20:12 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-038-061.pools.arcor-ip.net [84.61.38.61])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 240E630A9CA;
	Sun,  2 Sep 2007 09:20:12 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 0CE531C15372; Sun,  2 Sep 2007 09:20:08 +0200 (CEST)
In-Reply-To: <7vfy1xr1lz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 02 Sep 2007 00\:02\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4128/Sun Sep  2 07:54:56 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57302>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Just for the record: I believe that \{1,\} might be portable.
>
> Yeah, I obviously looked at the page I quoted that describes
> what's in and what's not in BRE definition ;-)

> As a maintainer of a public project I understand you have to deal
> with the current set of variations, and you might know better than
> me about the current portability situation.

Don't ask.  That was what "just for the record" was about.  In
practice, one uses the most simplistic expressions (and then some) and
prays, and your patches are quite in line with that.

Basically, one has to bear up under attack from two sides: the Windows
side with its idiosyncratic file names (and habitual spaces) under the
Cygwin and MSYS environments (which are quite Posix and GNU), and the
non-Posix madness from all sorts of Unices all across the utilities.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
