From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] gitweb/Makefile: Remove static/gitweb.js in the clean
 target
Date: Wed, 26 Oct 2011 22:30:46 +0100
Message-ID: <4EA87C06.8080808@ramsay1.demon.co.uk>
References: <4EA6EEA8.3000204@ramsay1.demon.co.uk> <1319583484.10399.41.camel@drew-northup.unet.maine.edu> <201110260236.59509.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Drew Northup <drew.northup@maine.edu>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 19:31:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJTna-0006zI-9F
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 19:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202Ab1J0RbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 13:31:20 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:48660 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751486Ab1J0RbT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 13:31:19 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1RJTnR-0002mW-kl; Thu, 27 Oct 2011 17:31:18 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <201110260236.59509.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184301>

Jakub Narebski wrote:
> Drew Northup napisa=B3:
>> On Tue, 2011-10-25 at 18:15 +0100, Ramsay Jones wrote:
>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>> ---
>>>  gitweb/Makefile |    4 +++-
>>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/gitweb/Makefile b/gitweb/Makefile
>>> index 1c85b5f..4191c6b 100644
>>> --- a/gitweb/Makefile
>>> +++ b/gitweb/Makefile
>>> @@ -185,7 +185,9 @@ install: all
>>>  ### Cleaning rules
>>> =20
>>>  clean:
>>> -	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWE=
B-BUILD-OPTIONS
>>> +	$(RM) gitweb.cgi static/gitweb.js \
>>> +		static/gitweb.min.js static/gitweb.min.css \
>>> +		GITWEB-BUILD-OPTIONS
>>> =20
>>>  .PHONY: all clean install test test-installed .FORCE-GIT-VERSION-F=
ILE FORCE
>>> =20
>> Forgive me for sounding a bit numb, but what does this fix? I don't =
see
>> it in the commit message.
>=20
> gitweb.js is nowadays a generated file.  Though that bit should be
> in commit message...

Yep, will do ...

ATB,
Ramsay Jones
