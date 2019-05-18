Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97EE41F461
	for <e@80x24.org>; Sat, 18 May 2019 12:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfERM6m (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 08:58:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:50755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbfERM6m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 08:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558184321;
        bh=Z40vdy7V8DZDQLi55vcoCEVPyhFMBks0hjPy/gT1UG0=;
        h=X-UI-Sender-Class:From:Cc:Subject:Date;
        b=dcfzVRk3zQpQ6rh4C+TLN0MJxRZnaH7sxFFRBmpGUxFcMVFPcnFnqK35zMSdY9i2y
         TOdwD9UJxSTr2UrneXvB2WCPpsR2wIrWzpmLmWrO61cwoaYKuG0c3k4aFefFxbS1Hf
         2eW2nNcgS+7ItjFmbVgb3zmPcw6hVN1R7qERfoRY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.134.142.3] ([80.134.142.3]) by web-mail.gmx.net
 (3c-app-gmx-bs48.server.lan [172.19.170.101]) (via HTTP); Sat, 18 May 2019
 14:58:40 +0200
MIME-Version: 1.0
Message-ID: <trinity-4a160867-2036-4f8a-8363-7bf2e021d840-1558184320864@3c-app-gmx-bs48>
From:   "Ax Da" <discussion@gmx.net>
Cc:     git@vger.kernel.org
Subject: Re: Git config "ignorecase = true" has issues
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 18 May 2019 14:58:40 +0200
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:l66qADv55+As8MG5cPP8cZ9/GwBGqLAaT8Exs9QDzAj8PBoj+tas5YX/EanjM1ihomUB6
 lmEpmxqQaW62jlu73RiVuzA2Py9SrgeLQauJK2nxGcApqgA8OR2RclHXKDuBmaMrMvGwrd9C0ulR
 1p9u71c6ZsZaYqgLfefepDFWXVi+Hy5JmwA5/L0zvqyutWtrxoC6TJddJK94/QovPjrOGFA2rDT0
 gZoOMN6qS4B6p+DvVIYfEeJVD4/+UYWY5rYYoL6cecLIOf/PNNMBgIlymbD65t/lBzNlTuJPDydE
 yk=
X-UI-Out-Filterresults: notjunk:1;V03:K0:44c4XBD8EeI=:2lVjJ9mPZ2JFTv9YE2fFlp
 WntliFWh7dhoAwWvI4fsel8rrf2/osEUAc7Nn9uUggqSQqD+Y2xDsaUkOB+mlPMWmWiJCXO6y
 a2C8gcyiS0GL2wTyGA5oAh/RvQM5SHCJf3NwqpxNMdEoQLxWHrg0M8KFaqzPE4iNDFSkXXyko
 ZjktNlclW3wQv8G9nERd4JnnTcT/HGYKGLqNe/ppyv94SKQLwaBt5PFmP3fMFBNlYYmEi+kmc
 d7cqT1rPLI/srRlLNqZ748hjgV1Mj6U+wLFtdFIVuDXwMRPLC+ZmSDKZbMiD/81XDqifoNi+V
 bH+j2k4diWd01P8s7lCd/f0n362m2vjRfckanNOWVWk4mhPxpsqyTNNnaJjeivO7Q/RiROQst
 xoKzZBZtKCRZER3kgNtTuosiTQSzAGKe6UcjsLVSJioVGn7XItbKiRj++YPuK6+Pupq6hJgqk
 6J4h1UDuX35PxjnY5YYzpSlMtu/JSNRrAK0QTKTdTpz+Hrav4VhDgjFQ7PKoxR/Tq9DbOjF9c
 AMOOtTtBCKWBqJTLoTOFgzdbXKvDMkh6aZF7WZGNmF0Vu1kkG1WNMTBU5I9Nv81iKBD/g0zA+
 j6C6rhGKdch4A7Tj213GhAT81s8VwvBpBMHTnNhROJaOqNWxDHY2RdAA==
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anyone who likes to fix this issue?
-----------------------------------


Gesendet:=C2=A0Sonntag, 05=2E Mai 2019 um 12:11 Uhr
Von:=C2=A0"Ax Da" <discussion@gmx=2Enet>
An:=C2=A0unlisted-recipients:;
Cc:=C2=A0git@vger=2Ekernel=2Eorg
Betreff:=C2=A0Re: Git config "ignorecase =3D true" has issues
Thanks for replying=2E Do you know how the query you mentioned ("Do we hav=
e a file named "file=2Etxt" on disk?") is implemented in git?

I'd suggest to use the C++ Windows API function FindFirstFileW() and then =
manually compare the result with the queried file name, like:



bool fileExists(const WCHAR_T *fileName, bool ignoreCase)
{
=C2=A0 WIN32_FIND_DATAW fileData;
=C2=A0 bool fileExists =3D false;
int (*strCmp)(const wchar_t *string1, const wchar_t *string2, size_t count=
)
=3D ignoreCase ? _wcsnicmp : wcsncmp;
);

=C2=A0 if (FindFirstFileW(fileName, fileData) !=3D INVALID_HANDLE_VALUE)
=C2=A0 {
=C2=A0=C2=A0=C2=A0 if (!strCmp(fileName, fileData=2EcFileName, wcsnlen(fil=
eName, MAX_PATH) + 1)) fileExists =3D true;
=C2=A0
=C2=A0=C2=A0=C2=A0 FindClose(fileData);
=C2=A0 }
=C2=A0
=C2=A0 return fileExists;
}



--------------------------------------------------------------------------=
-

Gesendet:=C2=A0Mittwoch, 24=2E April 2019 um 21:11 Uhr
Von:=C2=A0"Torsten B=C3=B6gershausen" <tboegi@web=2Ede>
An:=C2=A0"Ax Da" <discussion@gmx=2Enet>
Cc:=C2=A0git@vger=2Ekernel=2Eorg
Betreff:=C2=A0Re: Git config "ignorecase =3D true" has issues
On Fri, Apr 19, 2019 at 09:28:32PM +0200, Ax Da wrote:
>
> We're working on Windows machines and have been experiencing issues with=
 the current implementation of Git with config setting "core=2Eignorecase =
=3D true" (which is the default on Windows machines and repositories create=
d on Windows machines):
>
> Renaming files in a repository by only changing their case (changing a c=
apital letter to its small equivalent and vice versa) is ignored by Git=2E =
Git retains the original case in the repository and all contributors will c=
ontinue to see the ole file name which leads to confusion and issues with O=
pen Source tools programmed to not ignore file name case=2E
>
> Currently there is no way to convey the new file name (only differing in=
 case) to Git when "core=2Eignorecase =3D true"=2E
>
> Hence, I propose to alter the behaviour of Git when "core=2Eignorecase =
=3D true": A repository's file name changes should be recognized as a RENAM=
E operation and be propagated to the repository even when the new file name=
 only differs from the old file name in case=2E

You can rename files like this:
git mv File=2Etxt file=2Etxt
git commit

and Git will record the changes=2E

The main problem is, that after the rename, and may be on another machine =
after a pull,
Git checks with the file system, if any updates in the working tree are ne=
eded=2E
In human speech, Git asks the file system:
Do we have a file named "file=2Etxt" on disk ?
And Windows answers: Yes we have=2E
Even if the file is named "File=2Etxt" and Git asks for "file=2Etxt"=2E

You can try it yourself=2E
Run
cat File=2Etxt
under the Git shell (bash)
or
type File=2Etxt
under cmd=2Eexe

That is how it is=2E

If you really need the updated name "file=2Etxt", you can delete all files=
 in the worktree
rm -rf *
followed by
git reset --hard

But in any case, run
git status
before and make sure that your working tree is clean=2E

>
> Thanks,
> Axel Dahmen
