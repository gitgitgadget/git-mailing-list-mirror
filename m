From: David Kastrup <dak@gnu.org>
Subject: Re: way to automatically add untracked files?
Date: Mon, 06 Aug 2007 20:19:53 +0200
Message-ID: <85tzrcfrue.fsf@lola.goethe.zz>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<20070805041320.GH9527@spearce.org>
	<7vwsw9capl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 20:20:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II7BV-0000nR-R7
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 20:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814AbXHFST7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 14:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754692AbXHFST6
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 14:19:58 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:50054 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752661AbXHFST5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2007 14:19:57 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id AAD2D31F0E1;
	Mon,  6 Aug 2007 20:19:56 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 9AA342D3B6A;
	Mon,  6 Aug 2007 20:19:56 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-070-185.pools.arcor-ip.net [84.61.70.185])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 5696D3425E8;
	Mon,  6 Aug 2007 20:19:56 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id AAD431C3C79D; Mon,  6 Aug 2007 20:19:53 +0200 (CEST)
In-Reply-To: <7vwsw9capl.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Mon\, 06 Aug 2007 01\:45\:58 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3878/Mon Aug  6 18:24:41 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55164>

Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> We recently talked about this on the mailing list and decided that
>> git-add shouldn't remove files that have disappeared, as doing so
>> might break most user's expections of what git-add does.
>> ...
>> "git commit -a" will remove disappeared files.  It has for quite
>> some time.
>
> It obviously is not the time to do this as I have already said
> that I won't look at anything but fixes and documentation
> updates until 1.5.3, but I am not opposed to have "git add -a $paths"
> which would do something like "git add $paths && git add -u $paths".

I'm all for it.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
