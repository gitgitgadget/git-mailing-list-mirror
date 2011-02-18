From: Vampire <Vampire@masters-of-disaster.de>
Subject: Re: git svn clone failing
Date: Fri, 18 Feb 2011 15:21:48 +0100
Message-ID: <AANLkTim9obiU2H_PLb=O1=YxTr1nZ0v-zXC7mxUORVAH@mail.gmail.com>
References: <AANLkTi=Y64ohHnduBqxs--aLW3AYKCxrag2YoAFt58NC@mail.gmail.com> <1298033812.10893.23.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Feb 18 15:22:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqRDz-0003Tm-KC
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 15:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174Ab1BROWT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Feb 2011 09:22:19 -0500
Received: from masters-of-disaster.de ([85.214.103.232]:57656 "EHLO
	masters-of-disaster.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab1BROWR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 09:22:17 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174])
	by h1362875.stratoserver.net with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.69)
	(envelope-from <Vampire@masters-of-disaster.de>)
	id 1PqRDr-0003C3-LO
	for git@vger.kernel.org; Fri, 18 Feb 2011 15:22:15 +0100
Received: by iwn9 with SMTP id 9so3676702iwn.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 06:22:08 -0800 (PST)
Received: by 10.231.166.205 with SMTP id n13mr561000iby.58.1298038928104; Fri,
 18 Feb 2011 06:22:08 -0800 (PST)
Received: by 10.231.149.19 with HTTP; Fri, 18 Feb 2011 06:21:48 -0800 (PST)
In-Reply-To: <1298033812.10893.23.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167212>

Hi Drew,

SVN client is in version 1.6.5.
svn co http://svn.apache.org/repos/asf/ant/core/trunk .
works fine and without problem.
I guess it is in the phase of searching for history in other places in
the repository and there some place is accessed that is password
protected.
I did not contact the server admin as the normal svn client works fine
and so it seems to be a problem of git-svn, not of the SVN server.
Did you try the command I gave you and does it succeed for you? It is
a publicly available repository so you should be able to reproduce the
problem.

Regards
Bj=F6rn

2011/2/18 Drew Northup <drew.northup@maine.edu>:
>
> On Mon, 2011-02-14 at 18:24 +0100, Vampire wrote:
>> Hi,
>>
>> I'm trying to issue the following command:
>>
>> git svn clone --stdlayout http://svn.apache.org/repos/asf/ant/core/ =
=2E
>>
>> But unfortunately this fails after some time with the message:
>>
>> RA layer request failed: Server sent unexpected return value (403
>> Forbidden) in response to REPORT request for
>> '/repos/asf/!svn/vcc/default' at /usr/lib/git-core/git-svn line 4354
>>
>> Regards
>> Bj=F6rn
>
> Bj=F6rn,
> Have you made sure your subversion client is up-to-date? Does this wo=
rk
> as a plain svn clone? Have you contacted the server admin?
> Without context we cannot act on this.
>
> --
> -Drew Northup
> ________________________________________________
> "As opposed to vegetable or mineral error?"
> -John Pescatore, SANS NewsBites Vol. 12 Num. 59
>
>
