Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEE771F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 19:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbeGJTKW (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 15:10:22 -0400
Received: from mail-out7.apple.com ([17.151.62.29]:58627 "EHLO
        mail-in7.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732378AbeGJTKW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 15:10:22 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2018 15:10:20 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=apple.com; s=mailout2048s; c=relaxed/simple;
        q=dns/txt; i=@apple.com; t=1531248896; x=2395162496;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:Mime-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K7q3payYxL22l7H7ElXkbG+HR8rJFi5oQZ2kztUbT+c=;
        b=pTHOFrZIv4I1lSiOyWMY/n9G1MeMXATMmRWRT7cokf4ePGfzKr5h6kX8igvP5fmh
        7wii98t305AaMSCjLdmk/tPf3kwXgm8jypklo1hzNLhjX/BcmOLajK85APm4FjdM
        AVmLrWKj/F4Yw0hGDr46ufQGNvvXI4HWA0CYb9mLo8brgoeylBCenqcruiKLvirM
        0lZjBdyrCc46p+9PEUq2Rkjo/Bbgvv7NLQlF7JKOlpbkBImRva0L3Cb413pz7aLN
        Zt4739a1m3783dVHue3DJ6egzuZ/EEknx+lzdtAIyYa56eezLf8ftac84Ccogz/g
        q5AYX/OSw/VN8urt6AteDQ==;
Received: from relay3.apple.com (relay3.apple.com [17.128.113.83])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail-in7.apple.com (Apple Secure Mail Relay) with SMTP id 50.26.29708.001054B5; Tue, 10 Jul 2018 11:54:56 -0700 (PDT)
X-AuditID: 11973e16-be8749e00000740c-fb-5b4501001849
Received: from barret.apple.com (barret.apple.com [17.212.150.79])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by relay3.apple.com (Apple SCV relay) with SMTP id 28.A4.03895.001054B5; Tue, 10 Jul 2018 11:54:56 -0700 (PDT)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Message-Id: <B325BFBF-E084-4163-BF46-78C2FE295870@apple.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_DA921391-BE1A-4291-91CB-D8348792C197"
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.15\))
Subject: Re: Subscribing Apple people to git-security@googlegroups.com
Date:   Tue, 10 Jul 2018 11:54:53 -0700
In-Reply-To: <CACBZZX4X05EHd+OpBpLotGuY6H=pnB9dS9Rv5BONfCKjZM3a1A@mail.gmail.com>
Cc:     Jeff King <peff@peff.net>, Akilsrin <Akilsrin@apple.com>,
        Christian Couder <christian@gitlab.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Tim Triemstra <timt@apple.com>,
        Eliran Mesika <eliran@gitlab.com>,
        Git Mailing List <git@vger.kernel.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <CAGba+=U4nbxL2uuSxyqyZqiiavJpo_E=GhUkipz6DczLdmnkgQ@mail.gmail.com>
 <20180702195016.GA17102@sigill.intra.peff.net>
 <91A9F3A0-5F3F-4137-9A40-CB42EDE4F243@apple.com>
 <20180703133645.GA20316@sigill.intra.peff.net>
 <CACBZZX4X05EHd+OpBpLotGuY6H=pnB9dS9Rv5BONfCKjZM3a1A@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.100.15)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsUi2FAYrMvA6Bpt8O+WgsXaZ3eYLDauO8tm
        sfPYC3aLrivdTBZvby5htPjR0sPswObxZOJUdo+ds+6yezzr3cPo8XmTXABLFJdNSmpOZllq
        kb5dAlfGl2utLAWH6ypWfV7J1MB4Ir+LkZNDQsBEYturZexdjFwcQgKrmST2TjrNApPYtf44
        VGIhk8T5lcsZQRJsQIlbfyCKeAVsJJ6eWARUxMHBLBAj8e9aKkTYTOJv5yMmEFtYwE1i9pud
        rCA2i4CqxPr119hAbE6BQIkjh26BzWcWaAJavGEnWEJEwF1i0tSjLBCL1zBJvDuwlA1kgYSA
        ikT3BQ+QuITAUg6JG30LWCYwCsxC2D0LyW4Qm1lAW2LZwtfMELamxP7u5SwQdrbEziur2WeB
        7Z7CKLHx7wyohLzE9rdzwBpg/oQomsYo8f/XWcZZUE8fvfCPFcI2kHjy6BhYXAJo2/v1d9ln
        gX3tJPHvfQ9YDcjXj8/sZYGocZV4umkr4yyw534ySix6OQ9sg4hAB6PE2mfnwCZxCthKPLm1
        gRHTDwYSTztfsULYphJP3m5ng7CtJX7OeQRVrygxpfshO6peUBDpSExeyLiAUXIVo1BuYmaO
        bmaeuV5iQUFOql5yfu4mRlCKm24ntoPx4SqrQ4wCHIxKPLwXfrhEC7EmlhVX5h5ilOZgURLn
        lTsFFBJITyxJzU5NLUgtii8qzUktPsTIxMEp1cCY1fK9/ELUtJkpx8+1K/yK97u8eX7Lm+6I
        6f3azwrqjeIPf/mhudDf2y/0xgq1Ob/u3FZQ6r6x78WxF2oqoUyxgd+4L9+3kCq33BAqdF/1
        j17Om2rGl+qLjKdFNvRpqRht3vw6Xe1JUuiS6vMeraevhO/T5d3iPiOqYIPInfedl1n/n922
        wmi9EktxRqKhFnNRcSIAMgTDIlIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsUieGWavy4Do2u0wcSjUhZXf9RbrH12h8li
        47qzbBY7j71gt+i60s1k8fbmEkaLHy09zBY32zYwOnB4bD35g83jycSp7B47Z91l93jWu4fR
        4/MmuQDWKC6blNSczLLUIn27BK6ML9daWQoO11Ws+rySqYHxRH4XIyeHhICJxK71x9m7GLk4
        hAQWMkmcX7mcESTBBpS49ec0C4jNK2Aj8fTEIqAiDg5mgRiJf9dSIcJmEn87HzGB2MICbhKz
        3+xkBbFZBFQl1q+/xgZicwoEShw5dAtsPrNAE5PE3g07wRIiAu4Sk6YeZYFYvIZJ4t2BpWwg
        CyQEVCS6L3hMYOSdhbBuFpJ1IDazgLbEsoWvmSFsTYn93ctZIOxsiZ1XVrPPAls3hVFi498Z
        UAl5ie1v54A1wLwGUTSNUeL/r7OMs6D+PHrhHyuEbSDx5NExsLgE0Lb36++yzwJ71Eni3/se
        sBqQRx+f2csCUeMq8XTTVsZZYP/8ZJRY9HIe2AYRgQ5GibXPzoFN4hSwlXhyawMjph8MJJ52
        vmKFsE0lnrzdzgZhW0v8nPMIql5RYkr3Q3ZUvaAg0pGYvJBxAaPkKkaBotScxEpjvcSCgpxU
        veT83E2MoHTVUBi8g/HPMqtDjAIcjEo8vBd+uEQLsSaWFVfmHmJUAZrwaMPqC4xSLHn5ealK
        Irxm04HSvCmJlVWpRfnxRaU5qcWHGKU5WJTEefVjVKKFBNITS1KzU1MLUotgskwcnFINjDx2
        zsvPzuX5Z7653+/M3uU8H1/GP3p52k6eXf0HW3XDJN5ZnVaLfzdxXZ+avEWoUPgv/021yvpN
        4n+21qz88WPJ21t/vr+Vmn37zf/gFY6M3NMbPnI31i+/7yfbFzA9UXnNipVxM041MJy6eX+B
        IH8n/wnJFU0+Ki8suTm0nvo+9vft2ctbrqrEUpyRaKjFXFScCACyHlYYXwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_DA921391-BE1A-4291-91CB-D8348792C197
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Jul 10, 2018, at 5:27 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
> On Tue, Jul 3, 2018 at 3:36 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Jul 02, 2018 at 01:15:19PM -0700, Jeremy Huddleston Sequoia =
wrote:
>>=20
>>>> I hope that maybe they're also interested in reducing the overall
>>>> diff between upstream Git and what ships with XCode. Last time I
>>>> looked (which was admittedly a while ago), a lot of the changes
>>>> seemed like things that could probably be considered upstream.
>>>=20
>>> I'm very very interested in having reduced differences between what =
we
>>> ship in Xcode and what is upstream.  I've been maintaining a repo =
with
>>> our patches that I rebase as we move forward, in the hope that these
>>> changes might be useful to others and a derivative of them might
>>> eventually be accepted upstream.  See
>>> https://github.com/jeremyhu/git/commits/master for the current set =
of
>>> changes that are in our shipping git (currently on top of 2.17.1).
>>=20
>> Thanks for sharing. Skimming over it, I see:
>>=20
>> - several of the changes look related to run-time relocation. There =
was
>>   a series that shipped in v2.18.0 related to this, so that may =
reduce
>>   your diff once you rebase.
>>=20
>> - The xcode_gitattributes() bits aren't likely to go upstream as-is.
>>   But possibly these could ship as a default =
$sysconfdir/gitattributes?
>>=20
>> - the rest look like assorted little fixes that probably could go
>>   upstream
>=20
> Jeremy, could you elaborate on what
> https://github.com/jeremyhu/git/commit/61b42bc5d2 was about? I.e.
> where was this discussed & tests for this refused?
>=20
> Seems sensible to me to have this in some form, but the test as-is
> seems to be a general regression test, not Apple-specific, so it would
> need to be changed somewhat, or does it only happen with some other
> custom patch of yours?

It was a bug in upstream git and not a bug specific to an Apple change.  =
We haven't traditionally had many custom changes on our end.  The few we =
have, we didn't feel they were appropriate or were often rejected when =
we tried (eg: using CommonCrypto and Security.framework, this one, =
etc.).

For this particular case, I discussed the bug with the committer (Carlo) =
and reviewer (Junio) of the commit =
(18e051a3981f38db08521bb61ccf7e4571335353) via email back in October =
2011.  My proposed fix and test were never accepted.  As such, we =
continued to ship my patch in Xcode's git and MacPorts' git until the =
underlying bug was actually fixed by someone else in 2014 =
(ddc2a6281595fd24ea01497c496f88c40a59562f + =
655ee9ea3e6c0af57d320e84723ec3bf656cdbf7).  I kept the test in our test =
suite to ensure we didn't regress.  Here's the final post from that =
thread after the fix in 2014:

--Apple-Mail=_DA921391-BE1A-4291-91CB-D8348792C197
Content-Disposition: attachment;
	filename="Re: [PATCH git] setup: Do not strip trailing _ from paths.eml"
Content-Type: message/rfc822;
	x-mac-hide-extension=yes;
	x-unix-mode=0666;
	name="Re: [PATCH git] setup: Do not strip trailing _ from paths.eml"
Content-Transfer-Encoding: 7bit

From: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_5EEC33B4-8A87-41A2-9C62-ABA420AC41A0";
	protocol="application/pkcs7-signature";
	micalg=sha1
Message-Id: <36630E0E-3B48-4C15-A1EB-FD2917A697A7@apple.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1985.6\))
X-Smtp-Server: phonehome.apple.com:jeremyhu
Subject: Re: [PATCH git] setup: Do not strip trailing / from paths
Date: Mon, 22 Sep 2014 14:46:40 -0700
X-Universally-Unique-Identifier: 6563D6AA-7D96-4F90-9074-0694B34C1A76
References: <80D13461-9FBE-4228-8927-C1D36B3ACDE4@apple.com> <B697F375-DCDA-401E-A45B-0E80550F0054@apple.com> <7vzkh7fmmp.fsf@alter.siamese.dyndns.org> <6DE7C010-AF6B-4C22-9771-A4F94D59609D@apple.com> <5616AB22-EF27-4989-8394-65F5CE691AD6@apple.com>
To: martinerikwerner@gmail.com,
 pclouds@gmail.com,
 gitster@pobox.com,
 Junio C Hamano <gitster@pobox.com>,
 carenas@sajinet.com.pe
In-Reply-To: <5616AB22-EF27-4989-8394-65F5CE691AD6@apple.com>


--Apple-Mail=_5EEC33B4-8A87-41A2-9C62-ABA420AC41A0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

FWIW, it seems that this bug was addressed by =
ddc2a6281595fd24ea01497c496f88c40a59562f

Thanks Martin, now we're no longer carrying around an extra patch for =
our build of git ;)

--Jeremy

> On Oct 17, 2011, at 14:55, Jeremy Huddleston <jeremyhu@apple.com> =
wrote:
>=20
> ping.  Did you get my response below with extra details?  I just got a =
duplicate bug report, so it apparently effects people...
>=20
> Please let me know if I can be of further assistance.
>=20
> On Oct 11, 2011, at 2:17 PM, Jeremy Huddleston wrote:
>=20
>> Thanks for your response Junio.  The text of the original bug report =
is below.
>>=20
>> I created a git bisect test script which bisected the problem and =
found out that the difference was that the trailing / was removed by =
your code change.  git treats paths with a trailing / differently.  I =
don't know *why* it treats them differently, but it does.
>>=20
>> There's nothing "special" about JustDoItGit.tar.bz2 except that it =
contains a .git dir and has a file layout that works with the bisect =
script I wrote.  You can test this yourself by:
>>=20
>> mkdir -p ~/tmp/PR-10238070
>> cd ~/tmp/PR-10238070
>> tar xjf JustDoItGit.tar.bz2
>> cd ~/git-checkout
>> /path/to/test_10238070.sh
>>=20
>> Here's the original report:
>>=20
>> I've tracked the cause of '<rdar://problem/10160992> ##snipped =
title##' down to a regression in git.
>>=20
>> Unzip the attached JustDoItGit.zip project and replace the path in =
the following commands to the unzipped location on your system:
>>=20
>> #delete git in /usr/bin/git
>> sudo rm -r /usr/bin/git
>> #link it to /usr/local/bin/git since that's where ditto will place =
the new bits
>> sudo ln -s /usr/local/bin/git /usr/bin/git
>>=20
>> # first, install git 1.7.3.2 to verify that the bug does not =
reproduce
>> sudo ditto ~rc/Software/Slate/Roots/Git/Git-14~19.root/ /
>> sudo rm -r /Users/<you>/MyGitRepo.gitdir
>> git --git-dir=3D/Users/<you>/MyGitRepo.gitdir init --bare --quiet
>> git --git-dir=3D/Users/<you>/MyGitRepo.gitdir --work-tree=3D/ add -- =
/Users/<you>/Desktop/JustDoItGit/ =
/Users/<you>/Desktop/JustDoItGit/JustDoItGit/JustDoItGitAppDelegate.h =
/Users/<you>/Desktop/JustDoItGit/JustDoItGitTests
>> git --git-dir=3D/Users/<you>/MyGitRepo.gitdir --work-tree=3D/ commit =
-m "Hello."
>>=20
>> The expected result of the commit is something like "18 files =
changed, 7364 insertions". If that's what you get, great, now keep =
going.
>>=20
>> sudo rm -r /Users/<you>/MyGitRepo.gitdir
>> # install the slate version of git, 1.7.5.4
>> sudo ditto ~rc/Software/Slate/Roots/Git/Git-19.root~2/ /
>> sudo rm -r /Users/<you>/MyGitRepo.gitdir
>> git --git-dir=3D/Users/<you>/MyGitRepo.gitdir init --bare --quiet
>> git --git-dir=3D/Users/<you>/MyGitRepo.gitdir --work-tree=3D/ add -- =
/Users/<you>/Desktop/JustDoItGit/ =
/Users/<you>/Desktop/JustDoItGit/JustDoItGit/JustDoItGitAppDelegate.h =
/Users/<you>/Desktop/JustDoItGit/JustDoItGitTests
>> git --git-dir=3D/Users/<you>/MyGitRepo.gitdir --work-tree=3D/ commit =
-m "Hello."
>>=20
>> The expected result is what's above, something like "18 files =
changed, 7364 insertions". But the actual result is that only the root =
folder "/Users/<you>/Desktop/JustDoItGit is added
>>=20
>> This is a problem because it subsequently causes =
<rdar://problem/10160992> ##snipped title##
>>=20
>> =85 and therefore breaks Xcode's snapshots feature.
>>=20
>> <JustDoItGit.tar.bz2><test_10238070.sh>
>>=20
>> On Oct 11, 2011, at 10:45, Junio C Hamano wrote:
>>=20
>>> Jeremy Huddleston <jeremyhu@apple.com> writes:
>>>=20
>>>> real_path will strip the trailing / from provided paths.  This =
fixes
>>>> a regression introduced in 18e051a3981f38db08521bb61ccf7e4571335353
>>>=20
>>> What is the breakage? The above does not explain why stripping the =
'/' is
>>> a wrong thing, and which caller that used to work is broken by that
>>> behaviour.
>>>=20
>>> A new test block in some of the t/t[0-9]*.sh script to demonstrate =
the
>>> breakage and fix to explain and justify your fix better, please?
>>>=20
>>>>=20
>>>> Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
>>>> ---
>>>>=20
>>>> Here's an updated version that should be a bit more portable and =
warning-free.
>>>>=20
>>>> setup.c |   10 +++++++++-
>>>> 1 files changed, 9 insertions(+), 1 deletions(-)
>>>>=20
>>>> diff --git a/setup.c b/setup.c
>>>> index 61c22e6..e3a8ae3 100644
>>>> --- a/setup.c
>>>> +++ b/setup.c
>>>> @@ -10,8 +10,16 @@ char *prefix_path(const char *prefix, int len, =
const char *path)
>>>> 	char *sanitized;
>>>> 	if (is_absolute_path(orig)) {
>>>> 		const char *temp =3D real_path(path);
>>>> -		sanitized =3D xmalloc(len + strlen(temp) + 1);
>>>> +		sanitized =3D xmalloc(len + strlen(temp) + 2);
>>>> 		strcpy(sanitized, temp);
>>>> +
>>>> +		temp =3D strrchr(path, '\0');
>>>> +		temp--;
>>>> +		if (*temp =3D=3D '/') {
>>>> +			char *s =3D strrchr(sanitized, '\0');
>>>> +			s[0] =3D '/';
>>>> +			s[1] =3D '\0';
>>>> +		}
>>>> 	} else {
>>>> 		sanitized =3D xmalloc(len + strlen(path) + 1);
>>>> 		if (len)
>>>=20
>>=20
>=20


--Apple-Mail=_5EEC33B4-8A87-41A2-9C62-ABA420AC41A0
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIMYDCCBiQw
ggUMoAMCAQICAwjX0jANBgkqhkiG9w0BAQsFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcx
ODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENB
MB4XDTE0MDIwMjA3NDkxNFoXDTE1MDIwMjIyMzIyMVowQDEbMBkGA1UEAwwSamVyZW15aHVAYXBw
bGUuY29tMSEwHwYJKoZIhvcNAQkBFhJqZXJlbXlodUBhcHBsZS5jb20wggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCs/FRWSmiSFp31NL8sK5WUBkjRon8LF/fN6GMOGfc22/hjr0nHRuyf
jgAS7PcS+3d2Lctzxo0XafFe9KqNKlyigOLoWt+3OznLKPrMhfOyO3TeYAZw8qV6GkVW7aE3IEUa
n3EDD/fp878tDkRnJLR3JliT910CNjB7kkJZNrVhVG4Blm/WfR0sjwHCmxwBCwTrUIWmItgjfiBV
YTS8EtsO9fsstxUEUWw/BfrKteloDdZKChDgsU3d7e7VXoxrPPgs1vZkzimIzBC/d8I0LFFG3cfh
g6A2jXd7B1Nw7RQMFJYnlM65Aw3w/AOVILAY275anOX9uV/ipdNU+H/978wPAgMBAAGjggLYMIIC
1DAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
HQYDVR0OBBYEFMcuWXwlJvxAGpIm3uh2Vbg0rl/7MB8GA1UdIwQYMBaAFFNy7ZKc4NrLAVx8fpY1
TvLUuFGCMB0GA1UdEQQWMBSBEmplcmVteWh1QGFwcGxlLmNvbTCCAUwGA1UdIASCAUMwggE/MIIB
OwYLKwYBBAGBtTcBAgMwggEqMC4GCCsGAQUFBwIBFiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9w
b2xpY3kucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhv
cml0eTADAgEBGoG+VGhpcyBjZXJ0aWZpY2F0ZSB3YXMgaXNzdWVkIGFjY29yZGluZyB0byB0aGUg
Q2xhc3MgMSBWYWxpZGF0aW9uIHJlcXVpcmVtZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9saWN5
LCByZWxpYW5jZSBvbmx5IGZvciB0aGUgaW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNlIG9m
IHRoZSByZWx5aW5nIHBhcnR5IG9ibGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8v
Y3JsLnN0YXJ0c3NsLmNvbS9jcnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsGAQUF
BzABhi1odHRwOi8vb2NzcC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYIKwYB
BQUHMAKGNmh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50LmNh
LmNydDAjBgNVHRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQELBQAD
ggEBADouKlHJdkf8gg3eUEfdWNFuvgVH2mNunCzbCqaKg7CddZa0fiNslqExM2MLxAmlAYsRE3yy
8XLEnk6MjVYST8eRA2CnHHb6GUbf02GGwdpzEXQ0F9s9+2dBMsWshsFUrpcGiDDgsnkQnX8RbWvl
c9ffpOt06p+LjoAmEbKoTOI4aopu6tyk82Kcv7CjQ58/XBGO5Z80QDm//lEjhFFK8Ab0ayZAQBLF
wDubnz9ZTBLactBCbkauNU29c8hexW3JPgca6JpK4jK53xK1mnF1yCgCvFNJ3V0EaSqFCzX8iGZx
uewQDYAuenhU5sxHglEtP7hPJTNLyf9z72xQcrZ3Ci8wggY0MIIEHKADAgECAgEfMA0GCSqGSIb3
DQEBCwUAMH0xCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJT
ZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0
aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0wNzEwMjQyMTAxNTVaFw0xNzEwMjQyMTAxNTVaMIGMMQsw
CQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0
YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5
IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDH
CYPMzi3YGrEppC4Tq5a+ijKDjKaIQZZVR63UbxIP6uq/I0fhCu+cQhoUfE6ERKKnu8zPf1Jwuk0t
svVCk6U9b+0UjM0dLep3ZdE1gblK/1FwYT5Pipsu2yOMluLqwvsuz9/9f1+1PKHG/FaR/wpbfuIq
u54qzHDYeqiUfsYzoVflR80DAC7hmJ+SmZnNTWyUGHJbBpA8Q89lGxahNvuryGaC/o2/ceD2uYDX
9U8Eg5DpIpGQdcbQeGarV04WgAUjjXX5r/2dabmtxWMZwhZna//jdiSyrrSMTGKkDiXm6/3/4ebf
eZuCYKzN2P8O2F/Xe2AC/Y7zeEsnR7FOp+uXAgMBAAGjggGtMIIBqTAPBgNVHRMBAf8EBTADAQH/
MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUU3Ltkpzg2ssBXHx+ljVO8tS4UYIwHwYDVR0jBBgw
FoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwZgYIKwYBBQUHAQEEWjBYMCcGCCsGAQUFBzABhhtodHRw
Oi8vb2NzcC5zdGFydHNzbC5jb20vY2EwLQYIKwYBBQUHMAKGIWh0dHA6Ly93d3cuc3RhcnRzc2wu
Y29tL3Nmc2NhLmNydDBbBgNVHR8EVDBSMCegJaAjhiFodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9z
ZnNjYS5jcmwwJ6AloCOGIWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL3Nmc2NhLmNybDCBgAYDVR0g
BHkwdzB1BgsrBgEEAYG1NwECATBmMC4GCCsGAQUFBwIBFiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNv
bS9wb2xpY3kucGRmMDQGCCsGAQUFBwIBFihodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9pbnRlcm1l
ZGlhdGUucGRmMA0GCSqGSIb3DQEBCwUAA4ICAQCOgcqzJYsauaYgW9ZtyUQ0XyDV0CCOTk/E1qnm
c/M7Hvb7e31GR2j1SxXlmJY/AfQQNrh4Rn8mbT7cn9J2LZxTyoO8Ykl1/2qRNemxX2HbR5Gt6rqT
IIGadfjmZrQHUTv00Yo+Qtm1dqPpCH/udy31mr9rcOqSAsXyTvR645ex22KN/pd7pfWFQeUlShvF
i5jApKZu7YtWeCzmBdGOQBt3fAKmEt/+WlFkDf2UDeATK7l0iRhWBWAQ8bu40wWwVvZdpuLv7PNH
vo5CfT/Vw13jrHJQrHQLWOBdgv5Dh++o+n8IgASi8eOeAZEzLbpLbPzy7c6yMt+6FdFE4spJnBQl
0pnNYEJPsc9ubxrPw9+lXvC/tgPie4nVGD/NwNcEuCS4G+EOyRc5f5aizviAzPgBh/XLo6H4Oz45
dh3cg6txTp+3gM9mTzfsxs3rOfxPKytUJ07JPbSLIu0ESD3QAU54QvCJjmjY1ZAfSRlCdgQF8FSw
eQ6vUhHZxoslnUu2vX2/k38vA9sLjgPZnrVdIVJazzBwpibWUWxWQIzpUKyoTDOYRN9UGpdhxejp
H1YbRNJ76oI+nS7d/O9csUmIdd3NDgRepGT0fUoIo9xmYQMBDbBEiNOuVoNAUUqArVgekcQE88CM
iBoA/xpvLj6fnL/TrUqw0cDYxqYTfjEPNaFYeTGCA28wggNrAgEBMIGUMIGMMQswCQYDVQQGEwJJ
TDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlm
aWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVk
aWF0ZSBDbGllbnQgQ0ECAwjX0jAJBgUrDgMCGgUAoIIBrzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0xNDA5MjIyMTQ2NDFaMCMGCSqGSIb3DQEJBDEWBBTV/l5RMROl
BmwQMI+JbJBma4bY8DCBpQYJKwYBBAGCNxAEMYGXMIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UE
ChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2ln
bmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGll
bnQgQ0ECAwjX0jCBpwYLKoZIhvcNAQkQAgsxgZeggZQwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQK
Ew1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVu
dCBDQQIDCNfSMA0GCSqGSIb3DQEBAQUABIIBAFKDKMZw3Ax9Xnq5++xsJebMXmnSSwEp9jY/t6lM
rfmmT3IQJyNlIiizX+B+TgwsGuc463AxN+hZIA75OAYa3gV6UdkITmzRwIezT/EubmEJzCmCbcd5
feB7qeiHb3KMmVr2V2KzuHMDLxWErOGupSSTrmk+aDBt5NhDAUev1mdvU1jZTnm8tr4korSGwCMe
bh1D+QTknWzE0pJV8ACT+I3GnSF+vdVrdNrXX0p23yepMndCQHdUxx+2LkmzbWtUbe+tCnbNLwQh
d31gWGflzNy2H/CRbmzdOnS8uwpW6abV8f2N5qGKWQuVRbhuMKuSx7zgdveNBIzjdWfBhIGQCC8A
AAAAAAA=
--Apple-Mail=_5EEC33B4-8A87-41A2-9C62-ABA420AC41A0--

--Apple-Mail=_DA921391-BE1A-4291-91CB-D8348792C197
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii




Once I rebase on top of 2.18, I'll send out the full set of changes to =
git@vger as a starting point for discussion again.  I imagine many are =
not acceptable in current form but might be a starting point for =
additional discussion (eg: adding options for vendor-specific version =
rather than the hard coded "Apple Git-##" string).

Thanks,
Jeremy



--Apple-Mail=_DA921391-BE1A-4291-91CB-D8348792C197--
