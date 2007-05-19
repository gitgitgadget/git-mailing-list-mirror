From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-archive: recursive prefix directory creation
Date: Sat, 19 May 2007 21:56:59 +0200
Message-ID: <464F568B.9030308@lsrfire.ath.cx>
References: <464EE169.30306@lsrfire.ath.cx> <7vbqggy8ym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 21:57:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpV3J-0007VD-RI
	for gcvg-git@gmane.org; Sat, 19 May 2007 21:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764334AbXEST5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 May 2007 15:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764348AbXEST5F
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 15:57:05 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:48713
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764334AbXEST5E (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2007 15:57:04 -0400
Received: from [10.0.1.201] (p508E434C.dip.t-dialin.net [80.142.67.76])
	by neapel230.server4you.de (Postfix) with ESMTP id D41D13D009;
	Sat, 19 May 2007 21:57:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <7vbqggy8ym.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47767>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Currently git-archive only adds a single directory entry for prefixe=
s,
>> e.g. for --prefix=3Da/b/c/ only the directory a/b/c/ would be added =
to
>> the archive, not a/ nor a/b/.  While tar and unzip don't seem to hav=
e
>> a problem handling these missing entries, their omission was not
>> intended.
>=20
> Until we start tracking directories (we briefly discussed, and I
> think I agree with Linus that it should not be too painful), I'd
> rather keep the current behaviour which I feel is more
> consistent with what we really are doing.

Hmm, fair enough.  I started out with a simple cleanup and then I guess
went a bit overboard with that overblown path walker. :-]

Ren=C3=A9
