From: Chris Wilson <chris@aptivate.org>
Subject: Re: Possible bug: Git submodules can get into broken state
Date: Thu, 4 Apr 2013 21:40:13 +0100 (BST)
Message-ID: <alpine.DEB.2.02.1304042138100.965@lap-x201.fen.aptivate.org>
References: <alpine.DEB.2.02.1304041758140.965@lap-x201.fen.aptivate.org> <7vmwtei1wu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Chris Wilson <chris+gitscm@aptivate.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:41:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqxv-0004YV-Lr
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760070Ab3DDUk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:40:29 -0400
Received: from lin-mail.aptivate.org ([176.58.121.181]:51403 "EHLO
	lin-mail.aptivate.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760032Ab3DDUk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:40:29 -0400
Received: from 08022234.dsl.redstone-isp.net ([193.164.111.21] helo=lap-x201.local)
	by lin-mail.aptivate.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <chris@aptivate.org>)
	id 1UNqxO-0000eG-Qm; Thu, 04 Apr 2013 21:40:27 +0100
X-X-Sender: chris@lap-x201.fen.aptivate.org
In-Reply-To: <7vmwtei1wu.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220095>

Hi Junio,

On Thu, 4 Apr 2013, Junio C Hamano wrote:

>> This state is broken (wrong URLs in .git/config), and AFAIK there's
>> nothing you can do to check out these submodules without either:
>>
>> (a) manually hacking them out of .git/config, or
>
> I do not think updating the config is "hacking", but is a perfectly
> normal thing to do for a submodule user who wants to use a custom
> URL different from what is recorded in .gitmodules (even when the
> URL in .gitmodules is _working_, you may have a closer mirror you
> would prefer to use, for example).  It is how the configuration is
> designed to be used, if I am not mistaken.

It may be possible, but there's no easy command to do it, especially in 
automated (fabric) deployment scripts. I do not want to write an awk/sed 
script to remove all the submodules from .git/config so that I can 
successfully run git submodule init again. What other choices do I have?

> So I do not see any breakage here.

I do, it seems bizarre that git submodule init can create this situation 
but cannot rectify it.

Cheers, Chris.
-- 
Aptivate | http://www.aptivate.org | Phone: +44 1223 967 838
Future Business, Cam City FC, Milton Rd, Cambridge, CB4 1UY, UK

Aptivate is a not-for-profit company registered in England and Wales
with company number 04980791.
