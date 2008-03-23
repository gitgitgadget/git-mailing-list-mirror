From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: git-config: aliases with parameter expansion ($1 and such)
Date: Sun, 23 Mar 2008 15:04:50 +0100
Message-ID: <47E66382.5030800@dirk.my1.cc>
References: <47E65AF5.4060708@dirk.my1.cc> <76718490803230645k13471472sc99932563b0239da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQpW-0005PB-8w
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639AbYCWOEz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Mar 2008 10:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756439AbYCWOEz
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:04:55 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:52550 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083AbYCWOEy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 10:04:54 -0400
Received: from [84.176.102.166] (helo=[192.168.2.100])
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JdQoe-00040q-Hv
	for git@vger.kernel.org; Sun, 23 Mar 2008 15:04:52 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <76718490803230645k13471472sc99932563b0239da@mail.gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77899>

Jay Soffian schrieb:
> On Sun, Mar 23, 2008 at 9:28 AM, Dirk S=C3=BCsserott <newsletter@dirk=
=2Emy1.cc> wrote:
>  =20
>> Hi, I've a question concerning git config and the alias things.
>>  I'd like to create an alias 'atag' that creates an annotated
>>  tag with the message being the same as the tag. Usually I create
>>  annotated tags like this:
>>
>>  $ git tag -a -m "mytag" mytag
>>
>>  (BTW: It's not documented, but I have the impression that
>>  the '-a' switch is implicitely added when the '-m' switch
>>  is present. Is that true?)
>>
>>  I'd like to have an alias like this:
>>
>>  [alias]
>>     atag =3D tag -a -m "$1"
>>
>>  So that I can simply call
>>
>>  $ git atag mytag
>>
>>  Is it possible to pass parameters to the alias definition?
>>  With the definition above I got a tag with message "$1".
>>    =20
>
> atag =3D !git tag -a -m "$1"
>
> j.
>  =20
Thanks for the quick reply. Did you try that out? I did

$ git atag foo

with your definition and got a tag with message "$1" and
the tag's name was "'foo'" (surrounded by single quotes).

If you tried it and it worked (with linux), then it might
be a problem with my environment: I'm using Git with windows
and the bash (Git-1.5.4-preview20080202.exe). Usually that
works very good, but sometimes it doesn't. Probably this
is one of the few "it doesn't" things.

Dirk
