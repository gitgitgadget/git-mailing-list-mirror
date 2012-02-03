From: "Neal Groothuis" <ngroot@lo-cal.org>
Subject: Re: Push from an SSH Terminal
Date: Fri, 3 Feb 2012 12:10:27 -0500 (EST)
Message-ID: <34592.38.96.167.131.1328289027.squirrel@mail.lo-cal.org>
References: <CAG94OYxX5foffvaFLQv7=wXguGC2TLgccdDFrC+ERzv_gXZ=ug@mail.gmail.com>
    <21607.38.96.167.131.1328286083.squirrel@mail.lo-cal.org>
    <CAG94OYxbOYCjd5qNBh8EF2gyezHWMqX1-R2MYgk8gkFYcrMjuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Feanil Patel" <feanil@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 18:10:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtMed-0007iu-OD
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 18:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190Ab2BCRK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 12:10:27 -0500
Received: from dharma.lo-cal.org ([208.70.151.129]:36242 "EHLO
	dharma.lo-cal.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756877Ab2BCRK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 12:10:26 -0500
Received: from mail.lo-cal.org (localhost [127.0.0.1])
	by dharma.lo-cal.org (Postfix) with ESMTP id 4B8682AEAB4;
	Fri,  3 Feb 2012 11:10:27 -0600 (CST)
Received: from 38.96.167.131
        (SquirrelMail authenticated user ngroot)
        by mail.lo-cal.org with HTTP;
        Fri, 3 Feb 2012 12:10:27 -0500 (EST)
In-Reply-To: <CAG94OYxbOYCjd5qNBh8EF2gyezHWMqX1-R2MYgk8gkFYcrMjuQ@mail.gmail.com>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189785>

> On Fri, Feb 3, 2012 at 11:21 AM, Neal Groothuis <ngroot@lo-cal.org> w=
rote:
>>> The
>>> repository is password protected so if I'm physically at Comp B, I =
get
>>> a gui prompt for my username and password. However Comp A does not
>>> have X Forwarding setup to Comp B so I can't get the gui interface =
for
>>> the username and password when I try to do the push. =C2=A0Is there=
 an
>>> alternative way to provide my credentials when doing a git push tha=
t
>>> does not require a gui?
>>
>> What protocol are you using to access the repository on Comp C?
>>
> I'm pulling and pushing over HTTP from Comp C.

Check to see if the GIT_ASKPASS and/or SSH_ASKPASS environment variable=
s
are set, and if the core.askpass config variable is set.  If any of the=
se
are set, unset them.  Git should fall back to a simple password prompt.

- Neal
