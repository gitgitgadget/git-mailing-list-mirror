From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: ./t3310 fixed, t3400 broken
Date: Thu, 31 Dec 2015 16:47:23 +0100
Message-ID: <56854E0B.9010205@web.de>
References: <5683DA04.6000007@web.de>
 <CAPig+cQZq-aDYv5G3eNivvqC0eCTfyPtA4gEuop0PWq2LFT=9Q@mail.gmail.com>
 <56851E2E.4050403@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 31 16:48:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEfSR-0007vo-7u
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 16:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbbLaPrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2015 10:47:41 -0500
Received: from mout.web.de ([212.227.15.4]:57756 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbbLaPrj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 10:47:39 -0500
Received: from [192.168.2.107] ([79.223.100.211]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LfzcB-1ZvK8X2dLP-00pcUe; Thu, 31 Dec 2015 16:47:30
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.0
In-Reply-To: <56851E2E.4050403@ramsayjones.plus.com>
X-Provags-ID: V03:K0:64i+7WJqTxyA6h+x/Ei+jH6q2wYbePcK03+4gfJILX6LISuZwEu
 frZuT60uQF1I5zPJPatIaQcL6GTWxvb5RUYaDZu2xfhFJVc7UV1GqMemSKDsabpEqTyScRv
 6lIGuOceez0VKjA8uJV/HKckxCSDppTd2fITEVNwyuW+tOuxfrtu8tqe9ge4NcANmOI8CvX
 K6R9cz5lYRlZQLeFoGriw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XYpSmzgXNZw=:dv3XD/P0SzI9sHi58aAT7b
 ryanj9C7LgmN7UnnshGsjQq+z39YvHSBXlJSTRd7VoQJzlHr24FqcrZ4xxpjTDmnksxaYmkTh
 rqOktpQCtGzkubQ4GCLWSF908Kgj25L+wGpNg6X0qIvRRGLRZifdFtYTa1v8FKMpe8svzBWE3
 liY5K5Ek5g44fEHDOazH2Gt5uMKqDwv9I/cRrOKAUZJbIvY9c3qtlWYYMjEB17QCNT6wWaWtO
 wpudbcRRcIp7pVXAaNW4HHBl3HHTc+x7NvjJ+bYWuBHmTvt0h9pe0NZ9bP/F3Gshro7M31bVD
 rARKa11Gkyl5MaHcGuCY1ctyNSPrU+7F9fIeNesHwxF/lY0Y3OmluJ/QVIzc8nBtwOzNVO33h
 YTmV25WT/ypom8NqjClwCh8F0ifckxN4vAf2mRZ0r5mkm+Lqyek1nvGW3sIueGCKAWhVcULxA
 MDicE3+gI3igMGjW3/3V61Pu6V5AW+czC8fFCWsW+EOYArgr/ouPFXtj/diTv7zFdBfry7JhF
 MUTXvldgJ1qf1ZbJWB4zppLpVXYQpA6OUlelNd9Uhxr+BJ5NDEMihx1vg9US1suZqR5+Y2kio
 e7sarwlY7OXGhI6CWF2RBDg5ERfSyktu+sdgBFuVZMhBT+s6tNuP/dwbcbgdVay5HJOnlaVOa
 uJi3XoBZMfxVq+bLp9JPmFlTWd95Cfg9jKv8+NTGFqreCT8FptTblERxHeImchw19tMuVsMbw
 VzsfVyqg03fCtn7fpNXbBCr1xeLDlrpQqGq0SVDc6H7zWQoCw0vh1hgHZEv9UmfrOCTqmWqz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283246>

> t3310-notes-merge-manual-resolve.sh
>failed during a short window (due to commit 2bd811ec) and
> has already been fixed in commit 3a74ea38 ("notes: allow merging
> from arbitrary references", 29-12-2015).

Yes, it's fixed. Sorry for the noise.


The next failure is t3400.
Is there a chance to squeeze in this diff ?

--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -259,11 +259,11 @@ test_expect_success 'rebase duplicated commit with
--keep-empty' '
        git reset --hard &&
        git checkout master &&

-       >x && git add x && git commit x -mx &&
-       echo x >x && git commit x -mx1 &&
+       >y && git add y && git commit y -my &&
+       echo y >y && git commit y -my1 &&

        git checkout -b duplicated HEAD~ &&
-       echo x >x && git commit x -mx2 &&
+       echo y >y && git commit y -my2 &&
        git rebase --keep-empty master
 '








> 
> ATB,
> Ramsay Jones
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
