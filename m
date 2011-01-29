From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't find the revelant commit with git-log
Date: Sat, 29 Jan 2011 16:17:58 +0100
Message-ID: <4D442FA6.8000504@lsrfire.ath.cx>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>	<m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>	<4D4063EC.7090509@lsrfire.ath.cx> <4D433CA7.9060200@lsrfire.ath.cx>	<m2sjwb6feo.fsf@gmail.com> <4D440FED.2010203@lsrfire.ath.cx> <m2k4hn6cek.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 29 16:23:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjCe0-0005sn-E5
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 16:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab1A2PS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Jan 2011 10:18:28 -0500
Received: from india601.server4you.de ([85.25.151.105]:35223 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab1A2PS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jan 2011 10:18:27 -0500
Received: from [192.168.2.104] (p4FFDB056.dip.t-dialin.net [79.253.176.86])
	by india601.server4you.de (Postfix) with ESMTPSA id 694BE2F8091;
	Sat, 29 Jan 2011 16:18:26 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <m2k4hn6cek.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165660>

Am 29.01.2011 14:57, schrieb Francis Moreau:
> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Am 29.01.2011 13:52, schrieb Francis Moreau:
>>> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>>
>>>> Am 26.01.2011 19:11, schrieb Ren=E9 Scharfe:
>>
>>>>> - Make git grep report non-matching path specs (new feature).
>>>>
>>>> This is a bit complicated because grep can work on files, index en=
tries
>>>> as well as versioned objects and supports wildcards,
>>>> so it's not that easy to tell if a path spec matches something or =
is a
>>>> rather typo.  But it's not impossible either, of course.
>>>
>>> I don't understand this for the following use case:
>>>
>>>    $ cd ~/linux-2.6/drivers/pci/
>>>    $ git grep blacklist v2.6.27 -- drivers/pci/intel-iommu.c
>>>
>>> From what you said, it sounds that git grep is actually searching t=
he
>>> string 'somewhere'. But where ?
>>
>> All files in the directory are looked at and checked if they match t=
he
>> given path spec first.  Since none of them do, no actual text search=
 has
>> to take place.
>=20
> and in this case, it is complicated to tell that the given path spec
> match nothing. right ?

The specific case is easy to handle, but a complete solution would have
to address files, index entries as well as versioned objects and suppor=
t
wildcards.  Presumably it would come on top of Duy's pathspec work
that's in next now.

Ren=E9
