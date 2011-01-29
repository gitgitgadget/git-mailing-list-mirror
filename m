From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't find the revelant commit with git-log
Date: Sat, 29 Jan 2011 14:02:37 +0100
Message-ID: <4D440FED.2010203@lsrfire.ath.cx>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>	<m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>	<4D4063EC.7090509@lsrfire.ath.cx> <4D433CA7.9060200@lsrfire.ath.cx> <m2sjwb6feo.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 29 14:03:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjASZ-0004Sr-7T
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 14:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab1A2NDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Jan 2011 08:03:07 -0500
Received: from india601.server4you.de ([85.25.151.105]:49094 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab1A2NDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jan 2011 08:03:07 -0500
Received: from [192.168.2.104] (p4FFDB056.dip.t-dialin.net [79.253.176.86])
	by india601.server4you.de (Postfix) with ESMTPSA id BEC502F8091;
	Sat, 29 Jan 2011 14:03:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <m2sjwb6feo.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165658>

Am 29.01.2011 13:52, schrieb Francis Moreau:
> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Am 26.01.2011 19:11, schrieb Ren=E9 Scharfe:
>>> - Make git grep report non-matching path specs (new feature).
>>
>> This is a bit complicated because grep can work on files, index entr=
ies
>> as well as versioned objects and supports wildcards,
>> so it's not that easy to tell if a path spec matches something or is=
 a
>> rather typo.  But it's not impossible either, of course.
>=20
> I don't understand this for the following use case:
>=20
>    $ cd ~/linux-2.6/drivers/pci/
>    $ git grep blacklist v2.6.27 -- drivers/pci/intel-iommu.c
>=20
> From what you said, it sounds that git grep is actually searching the
> string 'somewhere'. But where ?

All files in the directory are looked at and checked if they match the
given path spec first.  Since none of them do, no actual text search ha=
s
to take place.

Ren=E9
