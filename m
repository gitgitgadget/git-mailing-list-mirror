From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Does Git really need a commit message to go with a commit?
Date: Sun, 4 Apr 2010 14:37:59 +0200
Message-ID: <n2madf1fd3d1004040537jd61d70c6we5ba3b294dfc10be@mail.gmail.com>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
	 <p2kadf1fd3d1004031526r3beff4e3ldd977dfc7e9da782@mail.gmail.com>
	 <h2m51dd1af81004040415xc7381f6cp1bf81bcfd684b99d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 14:38:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyP5d-00074r-QR
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 14:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113Ab0DDMiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Apr 2010 08:38:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:39531 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab0DDMiB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 08:38:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so447451fgg.1
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 05:37:59 -0700 (PDT)
Received: by 10.103.239.19 with HTTP; Sun, 4 Apr 2010 05:37:59 -0700 (PDT)
In-Reply-To: <h2m51dd1af81004040415xc7381f6cp1bf81bcfd684b99d@mail.gmail.com>
Received: by 10.102.216.24 with SMTP id o24mr2359278mug.67.1270384679772; Sun, 
	04 Apr 2010 05:37:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143920>

On Sun, Apr 4, 2010 at 1:15 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Sat, Apr 3, 2010 at 22:26, Santi B=E9jar <santi@agolina.net> wrote=
:
>> On Sun, Apr 4, 2010 at 12:06 AM, =C6var Arnfj=F6r=F0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> git-commit(1) doesn't allow you to make a commit without a commit
>>> message. This is annoying and doesn't properly preserve history in
>>> applications like snerp-vortex which replay a SVN dump into Git. Yo=
u
>>> have to add `$msg =3D "Git made me do it" unless length $msg' somew=
here.
>>>
>>> Is there really no way to add a commit with no message with the git
>>> tools? Will anything break if I manually construct a commit with no
>>> message? Are commit messages inherently part of the format or does
>>> git-commit(1) just think it knows better than me?
>>
>> Normally it does not make sense an empty commit message, so it is
>> forbidden by default. But there is a flag (documented in the man pag=
e)
>> since v1.5.4 (v1.5.3.7-994-g36863af git-commit --allow-empty,
>> 2007-12-03) to allow it.
>
> Actually --allow-empty allows you to commit an empty /tree/. It
> doesn't do anything for the commit message itself.

Arg! You are right, sorry for the noise. I should not write emails
during the night...

I then suppose your only option is to use plumbing commands (see
git(1)), in this case git-commit-tree. In general if you write scripts
around git you should use only plumbing commands as they don't change
the behavior.

HTH,
Santi
