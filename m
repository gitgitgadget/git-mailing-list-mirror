From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: git blame breaking on repository with CRLF files
Date: Sun, 9 Aug 2015 22:19:58 +0200
Message-ID: <55C7B5EE.7060908@web.de>
References: <B0BFE3BB9B3E8C4A890D53FA460552D3737328B0@DEWDFEMB16B.global.corp.sap>
 <55C59A9B.9000808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	"Benkstein, Frank" <frank.benkstein@sap.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 09 22:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOX4m-0007P0-UX
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 22:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbbHIUUI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Aug 2015 16:20:08 -0400
Received: from mout.web.de ([212.227.15.4]:59038 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789AbbHIUUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 16:20:07 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LsQ9o-1Yidit1r8i-0123Kj; Sun, 09 Aug 2015 22:20:03
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.1.0
In-Reply-To: <55C59A9B.9000808@web.de>
X-Provags-ID: V03:K0:iqLef0uCOcPAPPbrdG54ryAP6hgleSrzD12fcUwGUYdBW3WQGmF
 gen83ZlPd+9teSj0HJEP4tks4B0kj36H9JTpVWG11PIBDE0zx2nJM/+3gEUAum8bjeCvd7p
 gXZ2vzAYt79HntBUNLYhn0MCXpWaWNFo4mzoDtpHKVPopR3WYYCHBlQYD2nf8+oBJVxrg/R
 ntmK2nhkT6Hh1veAkBtJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x3bafhzpWE4=:oQaCds1JmtFl0NRkCmpLSk
 SXTp2S7iAGcKA9XZQrxLfbDzZekTaMy4igeH4AkkL3ojAlT98QPAUm56DcVv4gx6oa2c/ctrK
 0k+UoK5o1w/jdjD5u5l47OjoM9AMQq7Bv6R8wFRf8QHa8kYIlGQc0kS+IZledrf0gOjgQO5kH
 bZVabZWifLFTTTQhP7KPDHu7luam5xftJHMzoQDGuiJGdBqXkVVdC9s6B3nwHEgUiP+W7zW1D
 xmcp7P4lV7c528z0w/Sv1/yb47jvVnY5rU/eYCdihV7QbXy2PcJGuBs8s8T6WX15zdH55Z1B7
 +L09ZRoTQDzp6nGVarOyzZxEywS4sNLpNtshfK02YNo3uxatJNhrQIxQFtVMfC4HnJQgOFCrl
 134Wz8Wh6+nt2lR92qImXjwraUFnEjDI5QsrNwK4e8XNCuCo2N9zdDS8qgXW5A9pF+9MlEdlN
 t2FjkjzfJ0ckmWt/9KOzl9puU8Gt0LsFo5YPmf3+RMpt+fa0LyyaN6FQzv8qEmYEv3Cd8Rarv
 jSka/OOmXUTZ+mu2Ef6QiCnwn1FZtWcNEJ7i8fEyxX3PKHp6DZbT4eE7xIUddycuSm/uoBohM
 jdPh19zx33bg7WIxLsoLn4jdULZ9tHx4afT6LcOrtu/s8E1YSUWrQzh3Rtdo+2H4FPdnyqLEu
 YnSdvTFd6LOPj23uGg0EmSpI8M7u02P4tie8EDw9fEZBaw/7b2E5rmUp5qLSq9ngPV3Y8glxK
 8eB9bkL3CRdvvw+PronIvWWJ0t1EwXW+YNY/0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275556>

On 2015-08-08 07.58, Torsten B=C3=B6gershausen wrote:
> On 2015-08-07 18.32, Benkstein, Frank wrote:
>> Hello,
>>
>> I am working working on Linux and am examining code in a git reposit=
ory I do
>> not know much about.  I am only looking at files, not changing anyth=
ing.  On
>> some files in the repository I get "00000000 (Not Committed Yet" for=
 all lines
>> when running "git blame".  I checked with "git status", "git reset",=
 "git
>> clean" that the files are indeed in the repository and unmodified.  =
I noticed
>> that this only happens with git v2.5.0.  With git v2.4.0 it looks co=
rrect, i.e.
>> the output has proper commit ids, Author names and dates..  With "gi=
t bisect" I
>> tracked this down to the following commit:
>>
>>  commit 4bf256d67a85bed1e175ecc2706322eafe4489ca (HEAD, refs/bisect/=
bad)
>>  Author: Torsten B=C3=B6gershausen <tboegi@web.de>
>>  Date:   Sun May 3 18:38:01 2015 +0200
>>
>>      blame: CRLF in the working tree and LF in the repo
>>
>> Digging further, it seems that most files in the repository are chec=
ked in with
>> CRLF line endings.  In my working tree these are checked out as LF
> Do I understand it right that you have files in the repo with CRLF ?
> And these files are checked out with LF in the working tree ?
> Are the files marked with .gitattributes ?
> Or does the file have mixed line endings ?
>=20
> (Unless I missed something: Git never strips CRLF into LF at checkout=
,
> so I wonder how you ended up in this situation)
>=20
> Is there a way to reproduce it?
>=20
Actually I could reproduce the following:
CRLF in repo, CRLF in working tree, core.autocrlf=3D true.

This is an old limitation (or call it bug), which has been there for a =
long
time, (I tested with Git v1.7.0 from 2010).

Thanks for the report, we will see if anybody is able to fix it.
I can probably contribute some test cases.

>> seems to be the exact opposite situation of what the commit is tryin=
g to
>> address.  When I set "core.autocrlf" to "false" I also get the corre=
ct behavior
>> of "git blame" - this is a workaround as long as I do not have to ac=
tually
>> modify anything.
>>
>> Best regards,
>> Frank.
