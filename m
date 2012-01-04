From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to deal with historic tar-balls
Date: Wed, 4 Jan 2012 20:04:45 -0000
Organization: OPDS
Message-ID: <E6EC04F6AE4545F8923507F7CC4A6B07@PhilipOakley>
References: <4EFF5CDA.5050809@gmail.com> <4EFFA868.50605@dbservice.com> <B375E525C4704EA8807B5A59257B690B@PhilipOakley> <4C50794C7EED42A0B1A25ABD77CE7DB0@PhilipOakley> <4F01F6D2.8020005@dirk.my1.cc>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Tomas Carnecky" <tom@dbservice.com>,
	"nn6eumtr" <nn6eumtr@gmail.com>, "Git List" <git@vger.kernel.org>
To: =?utf-8?Q?Dirk_S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Wed Jan 04 21:04:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiX4c-0000xT-Bi
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 21:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201Ab2ADUEa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jan 2012 15:04:30 -0500
Received: from out1.ip08ir2.opaltelecom.net ([62.24.128.244]:2131 "EHLO
	out1.ip08ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755440Ab2ADUE3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2012 15:04:29 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgkFAKavBE9Z8rT1/2dsb2JhbABDggWDCoVNog2BBoFtAQQBAQUIAQEZDwEFHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBxcGEwgCAQIDAYU3gikLpAuRO4EviUozYwSNMpoG
X-IronPort-AV: E=Sophos;i="4.71,457,1320624000"; 
   d="scan'208";a="513123168"
Received: from host-89-242-180-245.as13285.net (HELO PhilipOakley) ([89.242.180.245])
  by out1.ip08ir2.opaltelecom.net with SMTP; 04 Jan 2012 20:04:26 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187941>

Many thanks - That explanation works for me. I just hadn't seen the=20
association.
Philip

=46rom: "Dirk S=C3=BCsserott" <newsletter@dirk.my1.cc>: Monday, January=
 02, 2012=20
6:26 PM
> Am 02.01.2012 11:07 schrieb Philip Oakley:
>>> From: "Tomas Carnecky" <tom@dbservice.com> : Sunday, January 01, 20=
12
>>> 12:27 AM
>>>> On 12/31/11 8:04 PM, nn6eumtr wrote:
>>>>> I have a number of older projects that I want to bring into a git
>>>>> repository. They predate a lot of the popular scm systems, so the=
y are
>>>>> primarily a collection of tarballs today.
>>>> There is a script which will import sources from multiple tarballs=
,
>>>> creating a commit with the contents of each tarball. It's in the g=
it
>>>> repository under contrib/fast-import/import-tars.perl.
>>> I wasn't aware of those scripts. I'll be having a look at the zip i=
mport
>>> script for my needs.
>>>
>>>> tom
>>> Philip
>>>
>> I had a look at the script but Python isn't part of the Msysgit inst=
all,
>> so the example wouldn't run.
>>
>> Also I couldn't see how the "fast_import.write(" method was being
>> created - my ignorance of Python? Otherwise I could look at scriptin=
g it.
>>
>> Philip
>
> Philip,
>
> I'm not a Python guy, but I think fast_import.write() writes sth. to
> whatever the popen() call in line 24 returned:
>
>  fast_import =3D popen('git fast-import --quiet', 'w')
>
> I guess it returns a filehandle and 'git fast-import' reads its data
> from stdin. My guess is, that -- instead of writing to that pipe -- y=
ou
> could as well write everything to a temporary file and finally call
>
>  git fast-import < $tempfile
>
> But that's only a guess.
>
> Dirk
>>=20
