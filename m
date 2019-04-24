Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EA901F453
	for <e@80x24.org>; Wed, 24 Apr 2019 19:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfDXTLc (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 15:11:32 -0400
Received: from mout.web.de ([212.227.15.14]:49879 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbfDXTLb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 15:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1556133089;
        bh=zRB9CAhkXt4QFjXYG/jUUY4OZN6upJe8uPO/jR5lqcg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jqfyNC/ZJPRKe+RnNYmf5Ah9InCgMlgfljq/pdHmAPrT9Q8o7dGpxH0krA+auNhrI
         Ofvu62mKw2EVtnqrUtGp9NuaUPtMOAbT7uFewqSdybGxxlPa92mRasplVThtU7FFIP
         xwh4GYP3IrMiJhWBoEr9kj2twrcPDBWrZLd8c8zI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgIMg-1h7sIh2vZ8-00NkQP; Wed, 24
 Apr 2019 21:11:29 +0200
Date:   Wed, 24 Apr 2019 21:11:29 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ax Da <discussion@gmx.net>
Cc:     git@vger.kernel.org
Subject: Re: Git config "ignorecase = true" has issues
Message-ID: <20190424191128.5emedinbbfmghs75@tb-raspi4>
References: <trinity-3f1323ca-ca26-46c1-8757-b30bb495bd3a-1555702112240@3c-app-gmx-bs44>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-3f1323ca-ca26-46c1-8757-b30bb495bd3a-1555702112240@3c-app-gmx-bs44>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:okZHhXdX14HtYA3hCyDS/0Gk9YF+BgrCSpxlw6m3Hv8oskGiEQq
 C6ldkJaF4d3r6JW5bl2iwfGNepeL7mn2THNxQUgz+7bfZXWfTSUWgo8bUGtEerZBZy7jRNz
 brUPYtQIxIbVWkzLWkzebHVBWkuaHhk0WsjuXFKhI0FMcD6jrJaQxzRwOLQ2KY7IITVqh29
 tF2J5ErHL3/2/dxo+xJ1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DjAISl+SQGA=:Wt6JWTCUkCqZ5xw4MkZwak
 HdwKeF3EmqTt8eaOD2/yB4TabLrwgUrT4CXO8whLasX+g1LMerC6XnZa4LUg/50ELbXfT2xHx
 4NokQN+FzS/V5n7gQ47wq9PLYfvdLY2eERCIk5z6GUQApMi1AhI+7+w6f+SN8DQygRbRZqaOC
 mhkGvw9OEe92x818+Mux7wRNE8mrxJ1eOqMQ4M+FFX8kueFy8wFqKMu0bPXb5tOjPaJPeCn0S
 qUnoBGB0SE4QX5j2xAMcppLEDNYoU57D9aqdAx6vaHiAsS4yb+j9Rkpg0XdNny/T59b+971bD
 8IPdRihQIUAqtup1VJ6AnAKHMqzqVtHcB+2HEuvEdbjm+yBMnDwAexbJdr7RQ/d0+4fRXqg5/
 ToJGZHH1wmlz/4xR3c3oyCRTEgYzDRRTYlgg6orRD6M611aO1JBWIwXTpJ72feXhnDzhPdDxD
 ZrYb4etdAogLHOTQxiQvTCTWPEEyjsoYZJ7WTFDD+w35tRkppecVfoIbYELtNM8a2+qPSnD8e
 9LHvwkYa1immzdXAk67hToUMV2NoUy/kNLvM2xjILwoinzCGARdAV2GVoXM5ziSPkeIFQlpE/
 FOFZafPcFz3D4VGV2c0jRyYW/hd1bSB3mxgb3mHOBoL5hdjyWGhdnmXeBDEs8LBJ+n2nOI3D7
 Bxn53+pV4eelQmMMxt3IcosFCdBi06K4gj/0UQTqLH8UU6nm6r2ms3Xj3dvdahLlHTOGOO/CJ
 pwDz/ATR5JOQ8kFE6LEoCyvP34shBM8XtmtOsCRUyHrvdR32iUdBZLBTBok0ydvQCYWaWaQN2
 +RRUZrrXgd8G5FdYTqWu4mhL9MQNWPdnepU2cTEl7Y1/idFWhHV+DC6O3Ts0Jk7VNVOfKl/ZM
 /aIdAdzU6VD8G/yM3yPrWhhgb69m75DvABtpq3yZKeW04qkbb5vzDqN8yiZ1q9
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 19, 2019 at 09:28:32PM +0200, Ax Da wrote:
>
> We're working on Windows machines and have been experiencing issues with=
 the current implementation of Git with config setting "core.ignorecase =
=3D true" (which is the default on Windows machines and repositories creat=
ed on Windows machines):
>
> Renaming files in a repository by only changing their case (changing a c=
apital letter to its small equivalent and vice versa) is ignored by Git. G=
it retains the original case in the repository and all contributors will c=
ontinue to see the ole file name which leads to confusion and issues with =
Open Source tools programmed to not ignore file name case.
>
> Currently there is no way to convey the new file name (only differing in=
 case) to Git when "core.ignorecase =3D true".
>
> Hence, I propose to alter the behaviour of Git when "core.ignorecase =3D=
 true": A repository's file name changes should be recognized as a RENAME =
operation and be propagated to the repository even when the new file name =
only differs from the old file name in case.

You can rename files like this:
git mv File.txt file.txt
git commit

and Git will record the changes.

The main problem is, that after the rename, and may be on another machine =
after a pull,
Git checks with the file system, if any updates in the working tree are ne=
eded.
In human speech, Git asks the file system:
Do we have a file named "file.txt" on disk ?
And Windows answers: Yes we have.
Even if the file is named "File.txt" and Git asks for "file.txt".

You can try it yourself.
Run
cat File.txt
under the Git shell (bash)
or
type File.txt
under cmd.exe

That is how it is.

If you really need the updated name "file.txt", you can delete all files i=
n the worktree
rm -rf *
followed by
git reset --hard

But in any case, run
git status
before and make sure that your working tree is clean.

>
> Thanks,
> Axel Dahmen
