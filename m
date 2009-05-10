From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: [PATCH] fix for incorrect index update
Date: Sat, 9 May 2009 21:46:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905092139050.21000@narbuckle.genericorp.net>
References: <alpine.DEB.2.00.0905091356070.21000@narbuckle.genericorp.net> <7vskjd4mfh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 06:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M30xi-0002Nr-8F
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 06:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbZEJEqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 00:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbZEJEqT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 00:46:19 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:60395 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751079AbZEJEqS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 May 2009 00:46:18 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id n4A4kFET023930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 9 May 2009 23:46:16 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <7vskjd4mfh.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118703>

On Sat, 9 May 2009, Junio C Hamano wrote:

> Thanks.  I'd add:
>
> 	From: Dave Olszewski <cxreg@pobox.com>
>
> at the beginning, so you would not be shown as "Dave O" in "git shortlog"
> and friends.

Ok, sounds good.  Thanks for the explanation of the issue.  Much of the
git internals are still mysterious but that's slowly changing :-)

> Much nicer than Dscho's ;-)

Well, it was mine first, can't fault him for that!

> You inherited a bug from Dscho's patch, it seems.  Have you tried running
> the test with debug option?
>
> This could have been
>
> 	test_debug "echo create a bunch of files" &&
>
> but I'd say we just make them into comments.

I didn't, sorry for that.  Making them comments seems ok to me.

Thanks once again.

     Dave Olszewski
