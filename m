From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: short log and email address
Date: Wed, 30 Jul 2008 00:30:01 +0200
Message-ID: <488F99E9.2010806@lsrfire.ath.cx>
References: <9e4733910807281106y56f8b67ao86f78822c4b4ad58@mail.gmail.com>	 <alpine.DEB.1.00.0807281928400.8986@racer> <9e4733910807281157u44c08a59ld3bdc0416e8a1d03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 00:31:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNxiu-0003GT-JP
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 00:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbYG2WaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2008 18:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754905AbYG2WaO
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 18:30:14 -0400
Received: from india601.server4you.de ([85.25.151.105]:60235 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbYG2WaN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 18:30:13 -0400
Received: from [10.0.1.200] (p57B7EFDE.dip.t-dialin.net [87.183.239.222])
	by india601.server4you.de (Postfix) with ESMTPSA id A01B62F8068;
	Wed, 30 Jul 2008 00:30:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <9e4733910807281157u44c08a59ld3bdc0416e8a1d03@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90694>

Jon Smirl schrieb:
> On 7/28/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>>
>>  On Mon, 28 Jul 2008, Jon Smirl wrote:
>>
>>  > Using the -e option in shortlog changes the results by spitting t=
hings
>>  > out by email address instead of leaving them combined by name. Th=
at's
>>  > probably not what you want. Instead you want everything combined =
by name
>>  > and then display the most recent email address used.
>>
>>
>> What is so wrong with _not_ using -e (since you do not want to see t=
he
>>  email address stored in the commit message, and -e would be asking =
for
>>  that _exactly_)?
>=20
> I wanted -e to give me the most recent email so that I would know how
> to sort the mailmap alias list.

<snip>

> If the name isn't in mailmap, tell them to make a patch adding their
> name or to change their name.

That makes sense if you want to list all contributors in .mailmap...

> If the name is there but the email is not the last one in the list,
> tell them to make a patch rearranging mailmap to reflect their curren=
t
> name/email.

=2E.. but why would you want to check if they used their respective ema=
il
entry that is sorted last in the file?  A person might have multiple
current email addresses, e.g. someone could send patches for one
subsystem from work and patches for something else from home, as a hobb=
y.

Ren=E9
