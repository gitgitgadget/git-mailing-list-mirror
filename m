From: Stephan Hugel <urschrei@gmail.com>
Subject: Re: Error when verifying tags signed using 1.7.3.1
Date: Tue, 5 Oct 2010 14:28:51 +0100
Message-ID: <AANLkTikVYSwGjJUgA8KUdNrkHL3+1mSjv8efLwO5+C9E@mail.gmail.com>
References: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com>
	<201010041851.46838.ComputerDruid@gmail.com>
	<AANLkTin1Ysn7Fp32Eoyjo3jjhHwVrc=hMuq+okgKNfmr@mail.gmail.com>
	<201010041959.48336.ComputerDruid@gmail.com>
	<AANLkTinA9K6BQ_gmNE8H02nGTSduhZWjujj6NiGDRALy@mail.gmail.com>
	<4CAADB19.30707@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 15:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P37Zk-0005SP-9y
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 15:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab0JEN2y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 09:28:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44938 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab0JEN2x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 09:28:53 -0400
Received: by wwj40 with SMTP id 40so5586807wwj.1
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 06:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KtFeyxbdwKFHkgyAXdU8lb9hXLbwUJmvmsyvs74tZRc=;
        b=E15aUERkQczgeijbbnjWUF96s9V3Z8xUbq9+nGH79XbR5citibWy4894s6CCqAt4vr
         kScQs34asHQbJbIMlYrzNds6xHRAy+9Q1TIGmFDSsrTOaGMUI79uJSwaMwgDu0XWztY7
         eInTbZLa7WHdVmkBotOLWBbWL7bfyNs05zi+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g1AMBZh/u0g/03g1ptNUN4o/YJqopcADwQhGUL+xwijArxRpa0+kKkFL0zfCiDngsj
         Tj0ZncZBkxOBXGzYWNT1HREyjt57kxDjM6IlNvZAOLexBRMNyYB0KJlkKuwLnnFLfcoo
         Y2RkUTIO1HoAbhjKFj2QL72LSE85CgGRC/L9c=
Received: by 10.227.128.134 with SMTP id k6mr9684077wbs.23.1286285332012; Tue,
 05 Oct 2010 06:28:52 -0700 (PDT)
Received: by 10.216.230.232 with HTTP; Tue, 5 Oct 2010 06:28:51 -0700 (PDT)
In-Reply-To: <4CAADB19.30707@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158196>

On 5 October 2010 09:00, Michael J Gruber <git@drmicha.warpmail.net> wr=
ote:
> Stephan Hugel venit, vidit, dixit 05.10.2010 02:17:
>> On 5 October 2010 00:59, Daniel Johnson <computerdruid@gmail.com> wr=
ote:
>>> On Monday 04 October 2010 19:04:51 Stephan Hugel wrote:
>>>> Daniel,
>>>> Those are the exact steps I'm using.
>>>>
>>>> When I run tag -v on existing tags, I don't see the
>>>>
>>>> -----BEGIN PGP MESSAGE-----
>>>> Version: GnuPG v1.4.9 (Darwin)
>>>>
>>>> iD8DBQBMqlpo8Y2TgZsQ1pARAmBQAJ9NV0IX7jlzeB8ogddlutFKAjyWJwCfSI5A
>>>> yZeXw/EddYrfdad/VvOrL1o=3D
>>>> =3D/0PJ
>>>> -----END PGP MESSAGE=E2=80=94=E2=80=94
>>>>
>>>> block. It's only present on tags created using the current version=
=2E
>>>> I've also just upgraded to GnuPG 1.4.10, but the result is the sam=
e.
>>>> I'm not sure how else I can determine where the problem arises; I'=
m
>>>> using the git and GnuPG versions for OS X built by homebrew, and G=
nuPG
>>>> is happy to use the same key for en/decryption and signing. I've a=
lso
>>>> verified that none of the subkeys are expired, and that the trust =
db
>>>> is OK.
>>>
>>> If you have the tests available, can you try running t7004 to see i=
f it fails
>>> there too?
>>>
>> I rebuilt and installed from source
>> Passed all 105 tests in t7004-tag.sh
>> Problem remains with tags I create
>>
>> This would seem to imply a problem with my key, even though nothing
>> else is complaining about it.
>
> Here's a very basic way to check: If foo is your tag, do
>
> git cat-file tag foo > a
> git cat-file tag foo > a.sig
>
> From the file "a", delete the signature (everything lines between and
> including "-----BEGIN/END PGP SIGNATURE-----"), invoking an editor or
> your favorite sed/awk/perl magic.
>
> a is the data on which git invoked gpg for signing the tag. (I'm not
> sure why gpg can't notice the inline sig directly but that doesn't
> matter; maybe because it is none ;))
>
> Now, gpg --verify a.sig should check the signature a.sig for a. Doing
> that, maybe with --verbose, you may find out whether the tag object i=
s
> bogus or git misunderstands gpg's response. If your key is on a key
> server you can also share the file a.sig with us so that we can check=
=2E
>
> Michael
>
Michael,
When I do this, gpg is able to verify the signature. So does this mean
that gnupg is failing to ignore the PGP block (possibly because it
expects "SIGNATURE", not "MESSAGE"?)


--=20

steph
