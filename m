From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: OS X and umlauts in file names
Date: Fri, 27 Nov 2009 11:20:07 +0100
Message-ID: <4B0FA7D7.1050302@syntevo.com>
References: <4B0ABA42.1060103@syntevo.com>	 <alpine.LNX.2.00.0911231403100.14365@iabervon.org>	 <4B0CEFCA.5020605@syntevo.com> <76718490911260927h9ff796bgbebcccab7e52ffbe@mail.gmail.com> <4B0FA388.4030507@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 11:19:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDxv9-0003QP-DR
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 11:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbZK0KTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 05:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbZK0KTE
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 05:19:04 -0500
Received: from syntevo.com ([85.214.39.145]:55828 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbZK0KTD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 05:19:03 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 7210637C7B3
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B0FA388.4030507@syntevo.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133888>

Thomas Singer wrote:
> Jay Soffian wrote:
>>>  toms-mac-mini:git-umlauts tom$ git status
>>>  # On branch master
>>>  #
>>>  # Initial commit
>>>  #
>>>  # Changes to be committed:
>>>  #   (use "git rm --cached <file>..." to unstage)
>>>  #
>>>  #     new file:   "U\314\210berla\314\210nge.txt"
>>>  #
>> Wait, what's the problem here? It's staged according to the above,
>> just commit it.
>=20
> You are completely right and I feel quite foolish.
>=20
> What about this one:
>=20
> toms-mac-mini:git-umlauts tom$ git status
> # On branch master
> #
> # Initial commit
> #
> # Changes to be committed:
> #   (use "git rm --cached <file>..." to unstage)
> #
> #	new file:   "U\314\210berla\314\210nge.txt"
> #
> toms-mac-mini:git-umlauts tom$ git rm --cached "U\314\210berla\314\21=
0nge.txt"
> fatal: pathspec 'U\314\210berla\314\210nge.txt' did not match any fil=
es

OK, I've found it. This works (I have to complete the file name after h=
aving
typed an U):

toms-mac-mini:git-umlauts tom$ git rm --cached =C3=9Cberl=C3=A4nge.txt

--=20
Tom
