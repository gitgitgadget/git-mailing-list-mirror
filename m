From: matt davies <mjdavies@glam.ac.uk>
Subject: Re: starting off
Date: Wed, 7 May 2008 14:24:02 +0100
Message-ID: <C7099BC4-3459-4EC7-8AF0-B6A76B096535@glam.ac.uk>
References: <loom.20080507T121321-885@post.gmane.org> <8aa486160805070600v5d7b3d2eqce5ee893d0016148@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:24:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtkY4-0006IB-3Q
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 16:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632AbYEGOWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 May 2008 10:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbYEGOWW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 10:22:22 -0400
Received: from jess.glam.ac.uk ([193.63.147.97]:35093 "EHLO jess.glam.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754604AbYEGOWU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2008 10:22:20 -0400
Received: from mailserv1.isd.glam.ac.uk ([192.168.244.1])
	by jess.glam.ac.uk with esmtp (Exim 3.35 #1)
	id 1Jtjd7-0002FB-00
	for git@vger.kernel.org; Wed, 07 May 2008 14:24:21 +0100
Received: from j235-md.isd.glam.ac.uk ([193.63.135.79]) by MAILSERV1.isd.glam.ac.uk with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 7 May 2008 14:23:50 +0100
In-Reply-To: <8aa486160805070600v5d7b3d2eqce5ee893d0016148@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
X-OriginalArrivalTime: 07 May 2008 13:23:50.0119 (UTC) FILETIME=[96511F70:01C8B045]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81439>

Hi Santi, thanks for getting back to me.

> Can you remove the double spacing?


I've accidentally posted twice, the first post was me emailing my =20
question in.  That took so long to appear that I then reposted using =20
this site.
http://permalink.gmane.org/gmane.comp.version-control.git/81433

Posting on that site only allows lines with 80 characters in, so I had =
=20
to press enter at the end of every line so that it would post.

>> Why a link? Paste this inside the mail, this way the mail is self
>> consistent, the others do not have to go to this site and can quote
>> it.

Same reason as above.

> git rebase --whitespace=3Dfix

I'm going to update my git and give that a go, also, I'll only send =20
emails into the list from now on.


On 7 May 2008, at 14:00, Santi B=E9jar wrote:

> On Wed, May 7, 2008 at 2:17 PM, Matt Davies <mjdavies@glam.ac.uk> =20
> wrote:
>> Hello everyone
>>
>> I'm as new as new can be so please be gentle.
>>
>> git version 1.5.4.5
>
> Can you remove the double spacing?
>
>>
>> I'm following the peepcode tutorial peepcode-015-git.mov
>>
>> I've created a branch, and now we're trying to use
>>
>> rebase to 'watch' the master branch from the new branch.
>>
>> When I run the rebase command from the other branch
>>
>> I get these types of warnings/errors
>>
>> http://pastie.caboo.se/192951
>
> Why a link? Paste this inside the mail, this way the mail is self
> consistent, the others do not have to go to this site and can quote
> it.
>
>>
>> Can someone explain to me what's happening here and if I
>>
>> should be worried about it?
>
> Some of the patches introduced lines with trailing whitespaces, git
> apply warns about it. You can remove the warnings setting the config
> "apply.whitespace" to nowarn, or you can remove them or get used to.
>
> The final result was OK? what you expected?  Did it keept the trailin=
g
> whitespaces?
>
> You can try rebase with different
> --whitespaces=3D<nowarn|warn|fix|error|error-all>
>
>>
>> If I should be worried about it
>>
>> can anyone point me in the direction of some
>>
>> documentation of a good (easy)way
>>
>> to remove the whitespace?
>>
>
> git rebase --whitespace=3Dfix
>
> At least 1.5.5
>
>> Thanks everyone.
>>
>> PS, I do check the archives and found this from yesterday
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=3D=
81336
>
> It's a long mail...
>
> Santi
