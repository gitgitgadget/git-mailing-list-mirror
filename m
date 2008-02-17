From: Wincent Colaiuta <win@wincent.com>
Subject: Re: gitweb bug: broken "next" and other links
Date: Sun, 17 Feb 2008 11:51:17 +0100
Message-ID: <C8D96592-DD9C-47D3-93AB-3F74719F4D46@wincent.com>
References: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com> <200802111630.29159.jnareb@gmail.com> <E16BED2E-C146-44D8-BD90-ECF0DF89CA35@wincent.com> <200802152216.42533.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 11:52:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQh8R-0003dV-CQ
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 11:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363AbYBQKv2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Feb 2008 05:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbYBQKv2
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 05:51:28 -0500
Received: from wincent.com ([72.3.236.74]:59506 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042AbYBQKvY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Feb 2008 05:51:24 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1HApIc2020366;
	Sun, 17 Feb 2008 04:51:19 -0600
In-Reply-To: <200802152216.42533.jnareb@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74117>

El 15/2/2008, a las 22:16, Jakub Narebski escribi=F3:

> On Tue, 12 Feb 2008, Wincent Colaiuta wrote:
>> El 11/2/2008, a las 16:30, Jakub Narebski escribi=F3:
>
>>> Below there is a fix for that; actully only second part mentioned
>>> (and first in patch) is needed, i.e. moving setting =20
>>> $params{'project'}
>>> before dealing with -replay is needed I think to fix this bug.
>
> Below there is minimal patch which I am using, which only
> moves setting $params{'project'}, and does not affect replay.
>
>>> Could you test it please?
>>
>> Your patch fixes the "next" links in the shortlog and log views.
>>
>> It doesn't fix the broken "raw" links in the commitdiff view. I'm
>> still seeing links like:
>>
>> http://example.com/ARRAY(0x8c97f64)?a=3Dcommitdiff_plain;h=3Df29d562=
69a1c3bd4a970897397470f41553a64f9
>
> WORKSFORME. I could not reproduce this error with the patch
> below applied. I think that the previous version of patch should
> give the same result; should also fix this bug.
>
> Besides, both "next" and "raw" links are generated using the same
> mechanism. It would be strange if one of them broke and other didn't.

Just re-tested again, this time applying on top of 1.5.4.2 and =20
definitely doesn't work for me.

The "next" links are fixed, the "raw" links still exhibit the same =20
problem.

eg. here's a commitdiff page with a broken "raw" link from my =20
installation:

http://git.wincent.com/wikitext.git?a=3Dcommitdiff;h=3D03b8fda6594aa7e6=
fab3b95b66a4f3c178d6a156

And here's a shortlog page with now-working "next" links:

http://git.wincent.com/wikitext.git?a=3Dshortlog;h=3D03b8fda6594aa7e6fa=
b3b95b66a4f3c178d6a156

Cheers,
Wincent
