From: Frank Ammeter <git@ammeter.ch>
Subject: Re: wrong handling of text git attribute leading to files incorrectly reported as modified
Date: Sat, 12 Apr 2014 13:29:35 +0200
Message-ID: <D552B854-59FB-406A-8CDE-3A1269CD0F6E@ammeter.ch>
References: <E8A9F28E-FF68-4899-B02C-DB7A2C66F38A@ammeter.ch> <534852D4.5070608@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 12 13:30:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYw8c-0006td-Cb
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 13:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbaDLL3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2014 07:29:40 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:31240 "EHLO
	mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754319AbaDLL3i convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 07:29:38 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
	by mxout012.mail.hostpoint.ch with esmtp (Exim 4.82 (FreeBSD))
	(envelope-from <git@ammeter.ch>)
	id 1WYw7t-000FLA-Cc; Sat, 12 Apr 2014 13:29:37 +0200
Received: from [91.190.10.159] (helo=[192.168.0.105])
	by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.82 (FreeBSD))
	(envelope-from <git@ammeter.ch>)
	id 1WYw7t-000B1g-AR; Sat, 12 Apr 2014 13:29:37 +0200
X-Authenticated-Sender-Id: git@ammeter.ch
In-Reply-To: <534852D4.5070608@web.de>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246167>


Am 11.04.2014 um 22:38 schrieb Torsten B=F6gershausen <tboegi@web.de>:

> On 2014-04-11 22.20, Frank Ammeter wrote:
>> I=92m not a git expert and this might be the wrong place to ask this=
 question,
>> so please send me somewhere else if I=92m in the wrong place.
>>=20
>> I asked the same question on stack overflow, but didn=92t get any re=
sponse:
>> http://stackoverflow.com/questions/22823004/files-incorrectly-report=
ed-modified-git-attributes-buggy-leading-to-inconsist
>>=20
>> If a file is committed with crlf line endings with the text attribut=
e unset in the working tree, but the text attribute is set in the repo,=
 the file will be incorrectly shown as modified - for all users checkin=
g out the file.
>> Resetting or manually modifying the file will not help - The only re=
medy is to commit the .gitattributes with the text attribute set for th=
e file.
>>=20
>> Wouldn=92t it be better to only consider the checked-in gitattribute=
s instead of the attributes in the working tree?
> No.
> If you change stuff in your working tree (and .gitattributes is a par=
t of the working tree)
> how should Git know what you want?
I don=92t see that argument.
I don=92t know why at the time of a commit git should read unstaged fil=
es from my working tree - that affect my commit.

> The primary assumption is that you know what you are doing in the wor=
king tree.
>> Is this a bug in git handling gitattributes or is this wrong usage?=20
> I thinkk No, yes.
>=20
> If it is wrong usage, is it documented anywhere?
> Please have a look here:
> https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
I=92ve read this, can=92t see anything about my problem in this documen=
t.
No offense, but because I don=92t understand the reasoning behind this,=
 I can=92t really help improve the documentation.
I don=92t think it makes much sense if I as a non-git-developer add som=
ething like =20
=84please apologize the git developers didn=92t really think far enough=
 when they invented git attributes, because they don't care if your rep=
o gets inconsistent=85"=20
