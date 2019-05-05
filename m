Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02FB01F45F
	for <e@80x24.org>; Sun,  5 May 2019 10:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfEEKLr (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 06:11:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:50227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfEEKLr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 06:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557051105;
        bh=kRMXtU36h/98Bjs5HzEdivtn+rGa9EMGayAl39CdYto=;
        h=X-UI-Sender-Class:From:Cc:Subject:Date;
        b=iEC8ZDdTwxi80Hy8iEZxDjFM3acslGXplQg7uA9ubzC5nUg7BM+wE3P0gsbByRfBF
         skUd2NSGQpWsLIC0Q4gBSoq6cPJUGGOO8bmwhN8lWw7YV6T1gJRNiidPioIqqv38ie
         QjYorLRb5UWwukK5AAvf9PoeADeznTbySmIWyWis=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.134.142.3] ([80.134.142.3]) by web-mail.gmx.net
 (3c-app-gmx-bs61.server.lan [172.19.170.145]) (via HTTP); Sun, 5 May 2019
 12:11:45 +0200
MIME-Version: 1.0
Message-ID: <trinity-e0813b57-caed-41b4-bbed-a28e96060168-1557051105034@3c-app-gmx-bs61>
From:   "Ax Da" <discussion@gmx.net>
Cc:     git@vger.kernel.org
Subject: Re: Git config "ignorecase = true" has issues
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 5 May 2019 12:11:45 +0200
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:+G4QqTIfmRvULpkhpDDv4NdJz/Gixl1znjodCQGyXFC+VGXxhJ//OALa6brWrvPlcNCuV
 7ynaADQFkpK3c7FpVtEeSee90fSElzKzO0VF5dTPcRoselURFbqhSn9xsn9hQD2mSjiUmna6mqmt
 XXlHUHH5SEj2polJT2GdG3USYNv2ImlCBh2DEjxQP1xTsdB0rvj+QLA8AwDxg4ikuiL74rGx1VBb
 9RZiSWJIqPGhwCyLHdRaOOAtvfRIyglGuQAgZoJ81IVvgbZXJuJNIDJB/KPTapeE5Za5OHjd7t9z
 X8=
X-UI-Out-Filterresults: notjunk:1;V03:K0:RSv8OAhYy54=:BKjQnDCFHHB/+Ag4AhaTE1
 bZC4EV3aNdi1wN6Xpggt+j2FzUHhTMkLAZi3HDywjY0748aoUgUp2K/Eubs4R5RGdcrKYV5EX
 dLMYfViJ+wAcW+7BVRD9Iaorduz1a3QBPeYXoup6WpqrG+/v1tza5t96/V5VxhJQ2r7VXAahk
 k8JVBui+8akSHKa/c2az6fZfBdFg1LBynEkpXrjxXzKR9GPL2kvUg6yDA1WMqWzZl7/YhYHut
 Eh+INh2AQajFxGnztwgNaqzuJ91xxiXD/iu6ewtSCNOSZuF37JoMM/aMactiGSHnAXFikajjw
 F39sIMQEuqqxX0QEa82V8dXqQFN0uwDG12l9WCEwwZTXJVJOs9MXN9xrruciMVNFeFHM9BHGE
 6nnMjRK4bhImIyaihAO4QBdE3HOYyihUILGfEvQgp+NVTxMHcaj5Ekl904RwUUaaN2sQcbYad
 eozAiE2W/f6zpCiUzjr8Pv8qocxxvW2KMuZUWFNWOxUKzEkIKFHTJxyeU0GAykLj8UVFiJula
 fV9UPokC0aUIhi3AIMex06Kftz/VPbl+2PMIGzTY32E9stkRgvscpA47WiBfN0kyp9yVWSkir
 ubMdTsYZSHSKp49J9ZHf3ZElks2xMtMBmPllDCFR+sEWd9vgyso7IH6A==
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for replying=2E Do you know how the query you mentioned ("Do we have=
 a file named "file=2Etxt" on disk?") is implemented in git?

I'd suggest to use the C++ Windows API function FindFirstFileW() and then =
manually compare the result with the queried file name, like:



bool fileExists(const WCHAR_T *fileName, bool ignoreCase)
{
=C2=A0 WIN32_FIND_DATAW fileData;
=C2=A0 bool fileExists =3D false;
  int (*strCmp)(const wchar_t *string1, const wchar_t *string2, size_t cou=
nt)
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
