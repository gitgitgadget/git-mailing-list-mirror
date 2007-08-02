From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 00:02:43 +0200
Message-ID: <85zm19y4qk.fsf@lola.goethe.zz>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<7vodhptyk3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:02:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGikw-0000OH-LS
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbXHBWCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 18:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbXHBWCu
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:02:50 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:59739 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754637AbXHBWCt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 18:02:49 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 6982E27B1C6;
	Fri,  3 Aug 2007 00:02:48 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 5ABEA5BD63;
	Fri,  3 Aug 2007 00:02:48 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-245.pools.arcor-ip.net [84.61.49.245])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 39835225126;
	Fri,  3 Aug 2007 00:02:48 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 1FD5D1D0344E; Fri,  3 Aug 2007 00:02:43 +0200 (CEST)
In-Reply-To: <7vodhptyk3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 02 Aug 2007 14\:29\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3848/Thu Aug  2 22:22:06 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54622>

Junio C Hamano <gitster@pobox.com> writes:

> You might find this thread amusing.
>
>     http://thread.gmane.org/gmane.comp.version-control.git/7116/focus=7136
>
> Historically, I have even avoided accepting ${var#word}, ${var%word},
> and arithmetic expansions.

I learnt Unix with a Banaham/Rutter primer in the early eighties.  I
got hit so often by the "this is now supposed to work in Bourne
shells?" surprise it wasn't funny.

The first time I saw "for ((i=0; i<$NR; i++)) ..."  I thought the
author had been smoking too much C and got things confused.  It still
creeps me out.  I am more comfortable doing arithmetic with dc rather
than sh.

Employing the existing globbing machinery for # and %, on the other
hand, seems quite bournesque (still-bourne sounds so ugly) to me.  And
it is certainly quite more readable than the regexp/expr stuff.

If it works.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
