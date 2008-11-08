From: Andreas Ericsson <ae@op5.se>
Subject: Re: libgit2 - a true git library
Date: Sat, 08 Nov 2008 15:35:55 +0100
Message-ID: <4915A3CB.5010909@op5.se>
References: <20081031170704.GU14786@spearce.org> <4915939B.1070306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: =?ISO-8859-15?Q?Steve_Fr=E9cinaux?= <nudrema@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 15:37:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyowF-00077h-9z
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 15:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451AbYKHOgE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 09:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753447AbYKHOgD
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 09:36:03 -0500
Received: from mail.op5.se ([193.201.96.20]:40099 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753040AbYKHOgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 09:36:01 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2A5461B80066;
	Sat,  8 Nov 2008 15:29:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DkJY4f622GaL; Sat,  8 Nov 2008 15:29:48 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 7CC201B80076;
	Sat,  8 Nov 2008 15:29:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <4915939B.1070306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100404>

Steve Fr=E9cinaux wrote:
> Shawn O. Pearce wrote:
>> During the GitTogether we were kicking around the idea of a ground-u=
p
>> implementation of a Git library.  This may be easier than trying
>> to grind down git.git into a library, as we aren't tied to any
>> of the current global state baggage or the current die() based
>> error handling.
>>
>> I've started an _extremely_ rough draft.  The code compiles into a
>> libgit.a but it doesn't even implement what it describes in the API,
>> let alone a working Git implementation.  Really what I'm trying to
>> incite here is some discussion on what the API looks like.
>=20
> Just a random question: is there a reason why you have put all the .h=
 in=20
> a separate includes/ directory instead of relying on the install targ=
et=20
> to put the include files at the right place ?
>=20
> To me it makes it much harder to hack on the files as one is always=20
> required to switch between both directories...

I agree with this, but as I guess Shawn will do roughly 45 times more
work on it than me (according to current commit-count in git.git), I'll
live with it.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
