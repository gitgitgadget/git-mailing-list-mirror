From: Wincent Colaiuta <win@wincent.com>
Subject: Re: gitweb bug: broken "next" and other links
Date: Tue, 19 Feb 2008 01:23:04 +0100
Message-ID: <FFA9B31C-F8B1-4844-8247-8AAACD547BE1@wincent.com>
References: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com> <200802152216.42533.jnareb@gmail.com> <C8D96592-DD9C-47D3-93AB-3F74719F4D46@wincent.com> <200802190032.36712.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>, Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 01:25:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRGIt-0005qN-11
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 01:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbYBSAZM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Feb 2008 19:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbYBSAZM
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 19:25:12 -0500
Received: from wincent.com ([72.3.236.74]:34837 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbYBSAZK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Feb 2008 19:25:10 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1J0N5qH026415;
	Mon, 18 Feb 2008 18:23:06 -0600
In-Reply-To: <200802190032.36712.jnareb@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74361>

El 19/2/2008, a las 0:32, Jakub Narebski escribi=F3:

> Dnia niedziela 17. lutego 2008 11:51, Wincent Colaiuta napisa=B3:
>> El 15/2/2008, a las 22:16, Jakub Narebski escribi=F3:
>>>
>>> WORKSFORME. I could not reproduce this error with the patch
>>> below applied. I think that the previous version of patch should
>>> give the same result; should also fix this bug.
>>>
>>> Besides, both "next" and "raw" links are generated using the same
>>> mechanism. It would be strange if one of them broke and other =20
>>> didn't.
>>
>> Just re-tested again, this time applying on top of 1.5.4.2 and
>> definitely doesn't work for me.
>>
>> The "next" links are fixed, the "raw" links still exhibit the same
>> problem.
>>
>> eg. here's a commitdiff page with a broken "raw" link from my
>> installation:
>>
>> http://git.wincent.com/wikitext.git?a=3Dcommitdiff;h=3D03b8fda6594aa=
7e6fab3b95b66a4f3c178d6a156
>>
>> And here's a shortlog page with now-working "next" links:
>>
>> http://git.wincent.com/wikitext.git?a=3Dshortlog;h=3D03b8fda6594aa7e=
6fab3b95b66a4f3c178d6a156
>
> Could you reproduce this error with git.git repository (after any of
> the two patches, but please tell which)? Please provide an URL to the
> page, and fragment of HTML with wrong link.
>
> BTW. I have just checked above link, and the "raw" link is most
> certainly not broken. Were you using updated gitweb (with patch),
> and reloaded page?

Well I'll be darned. Looks like my browser (Safari) was showing me an =20
older version of the commitdiff page. Crazy browser.

I had confirmed that both links were not working, then applied your =20
patch, then reloaded both pages (or so I thought) and saw that the =20
commitdiff page was still broken.

I went through this cycle at least twice (once when you first the =20
patch, and again days later when I reapplied and retested) and both =20
times got the same results.

But now having left the server alone (patch still applied) I revisit =20
the link and you're right: it works.

Sorry for the confusion and thanks for fixing the bug. Darn browser.

Cheers,
Wincent
