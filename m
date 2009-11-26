From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: OS X and umlauts in file names
Date: Thu, 26 Nov 2009 09:28:04 +0100
Message-ID: <4B0E3C14.9070404@syntevo.com>
References: <4B0ABA42.1060103@syntevo.com>	<alpine.LNX.2.00.0911231403100.14365@iabervon.org>	<4B0CEFCA.5020605@syntevo.com> <m21vjmkyxh.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 09:27:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDZhI-0003bT-KR
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 09:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759590AbZKZI1R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 03:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759572AbZKZI1R
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 03:27:17 -0500
Received: from syntevo.com ([85.214.39.145]:52811 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759476AbZKZI1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 03:27:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 0A42137C7B0
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <m21vjmkyxh.fsf@igel.home>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133777>

Hi Andreas,

Thank you for this hint. When trying

 toms-mac-mini:git-umlauts tom$ git stage $'U\314\210berla\314\210nge.t=
xt'

git shows me no error or other output, but invoking 'git status' again =
shows
no difference, the file is still showing up as new file.

I've also tried to use double backslashes, but I could not enter a back=
slash
in the OS X Terminal (works fine in other applications). :(

--=20
Tom

Andreas Schwab wrote:
> Thomas Singer <thomas.singer@syntevo.com> writes:
>=20
>> I've did following:
>>
>>  toms-mac-mini:git-umlauts tom$ ls
>>  =C3=9Cberl=C3=A4nge.txt
>>  toms-mac-mini:git-umlauts tom$ git status
>>  # On branch master
>>  #
>>  # Initial commit
>>  #
>>  # Changes to be committed:
>>  #   (use "git rm --cached <file>..." to unstage)
>>  #
>>   #	new file:   "U\314\210berla\314\210nge.txt"
>>  #
>>  toms-mac-mini:git-umlauts tom$ git stage "U\314\210berla\314\210nge=
=2Etxt"
>>  fatal: pathspec 'U\314\210berla\314\210nge.txt' did not match any f=
iles
>=20
> Try $'U\314\210berla\314\210nge.txt' instead.
> "U\314\210berla\314\210nge.txt" is the same as
> "U\\314\\210berla\\314\\210nge.txt" to the shell.
>=20
> Andreas.
>=20
