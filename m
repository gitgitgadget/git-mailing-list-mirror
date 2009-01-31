From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: understanding index
Date: Sat, 31 Jan 2009 21:57:29 +0100
Message-ID: <adf1fd3d0901311257j1501d222nc24514b013bd13f3@mail.gmail.com>
References: <20090131111011.GA29748@ultras> <20090131124022.GB29748@ultras>
	 <adf1fd3d0901310409y28dc493ak358749e0c29154cc@mail.gmail.com>
	 <20090131201920.GC29748@ultras>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Sat Jan 31 22:04:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTN0b-00043F-Oe
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 22:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbZAaVCn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jan 2009 16:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZAaVCm
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 16:02:42 -0500
Received: from mu-out-0910.google.com ([209.85.134.185]:45810 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbZAaVCl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jan 2009 16:02:41 -0500
Received: by mu-out-0910.google.com with SMTP id g7so704582muf.1
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 13:02:40 -0800 (PST)
Received: by 10.103.106.1 with SMTP id i1mr1190258mum.0.1233435449173; Sat, 31 
	Jan 2009 12:57:29 -0800 (PST)
In-Reply-To: <20090131201920.GC29748@ultras>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107938>

2009/1/31 Nicolas Sebrecht <nicolas.s-dev@laposte.net>:
>
> On Sat, Jan 31, 2009 at 01:09:49PM +0100, Santi B=E9jar wrote:
>
>> You omitted the help message of git status, where it says how to uns=
tage:
>> # Changes to be committed:
>> #   (use "git reset HEAD <file>..." to unstage)
>>
>> So to not commit foo at all:
>>
>> git reset HEAD foo
>
> Thanks. I didn't omitted the help message of git status.

These help messages (helpful messages?) were not in old version, but
in current git you get this indications when you execute "git status",
and it was what you put as "[...]".

$ git status
# On branch next
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   Makefile
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#	modified:   Makefile
#


> The "unstage"
> action is what I was looking for but I was wrongly presuming (and I'v=
e
> read git docs !) that 'HEAD' is a kind of shortcut to the last commit=
 of
> the current branch (not to the last state of the working tree).

By default git reset only acts on the head of the branch and the index,=
 so with:

git reset HEAD foo

what you are saying is, use the HEAD as the head of the branch (don't
change my branch), but put in the index the state of foo in HEAD, so
in brief reset the index state of foo.
>
> Working on branch master for example, we have in .git/HEAD :
> ref: refs/heads/master
> And in .git/refs/heads/master, the hash of the last commit of branch
> master.

Right.

HTH,
Santi
