From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Fwd: diff not finding difference
Date: Fri, 25 Sep 2015 12:11:33 +0200
Organization: gmx
Message-ID: <8abeb16d123a602ee11dab3f93dab51e@dscho.org>
References: <CAKepmajSPgGK-DqR3Bxf2Xqxj2Gz0MazRNxM6wsVcSiBQsoE4Q@mail.gmail.com>
 <CAKepmajegSMO91YZOe+P_BH2kzzR=RMqCE94XRQSfZzOVYKt6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git-mailing-list <git@vger.kernel.org>
To: Jack Adrian Zappa <adrianh.bsc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 12:11:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfPyg-0003p4-8J
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 12:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbbIYKLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 06:11:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:62265 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbbIYKLg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 06:11:36 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MVNDK-1aBwOe00ti-00Ym99; Fri, 25 Sep 2015 12:11:34
 +0200
In-Reply-To: <CAKepmajegSMO91YZOe+P_BH2kzzR=RMqCE94XRQSfZzOVYKt6A@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:P5gBYJm0Jllrx/XQbvbe6b24RvN1U3274NZXk0eLQd8vxraGnn4
 ymFZ6YMTKCbuZt5Zb3vua4H5sMzBwxHPE5l910dwt3H/A7DTm37chZYtAGquOjn0YYtU2tw
 XJPhF4zC26qcAVxDOh+R01rzTua0/c0ti+oZkMNJiqhtoNOUm17acWSKwtCZGFQpx5UArRf
 S3aliQwIHn3D4FafPSKmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0dezhgqkkiM=:7M3iHFmRIzS0o2TSnSYdVy
 M7fw7sHguhHOmoz4zZW/AKKfJ7JRLwncgxKcbLlcUbS+gPuHJJGBHOZU4CgyYM9LT5/gue/Tr
 wP/cyo/oOb3pSGFcSyK3c+7jdpYeDvjbNFQKhX6D4HTwTbgBOW5mRti/5JFL7rUJgIZywf6Yo
 jIl8alwCCP7JfN8jaxiU+k76UUg91GqEMqzBP8jHvFlT+MtQT7Dzb0lKsUbFdlDX6jx3DvP43
 W4kJuPMn7DMKSq7UtyM5RnEqtWqcfMpP2/oSalrSbr5zO5fD8vAcHptaBZe94TwZR0jxkl1Qs
 uEG2YJJdXeypKN3lDVFScIb59c51X2/WX/DP4XGgnX1oNQQHUyc1JRfZ+TnqOjH2LB50iMNsd
 bhyuOlKOXI9FEGPcM7OQLNlFIitmrZv4C3QfrLAzkgaFTJQXAID0PmX35OLE4eoIX9oJxY3p0
 0COaA+rv9dXebMWZ4un8dssPuz4tzYW1MUYHq5LEJeslGwEbak5RV0zkldLs7hruTql2M/Jvi
 LJPATec/1G6nI+O4kqzfF8ihXJhGJsNBsu/FBmE3st4kIS0EecWkg4yN1JVksexjALQnkzcel
 PN75uRzv4xd6CUO5JIc/APWgOJyiPzd7cSj2l69LEPITZHmZ0weGkiMbOI+OM3FCdbfllRqxa
 zTB0yGF9ZldVpH4sD91BTJl93NzkNHGvK1KR7DI272KvLVmO2CSw3qk4xv90rnh/hSRKJE2X5
 5IBa2b2Y22+DUevZT2Zt1/7mzk0/UtuFImMMQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278656>

Hi Jack Adrian,

On 2015-09-24 23:09, Jack Adrian Zappa wrote:
> This is a weird one:
> 
> [file-1 begin]
> 
> abcd efg hijklmnop
> 
> [file-1 end]
> 
> [file-2 begin]
> 
> blah blah blah
> /////////////////////////////////////////////////////////////////////////////////
> abdc boo ya!
> 
> [file-2 end]
> 
> Do a diff between these and it won't find any difference.
> 
> Same with the following two lines, each in a different file:
> sabc fed ghi jkl
> abc def ghi jkl
> 
> I first noticed this on the command line git and then in VS2013.  The
> original problem was like my first example.  The files were much
> longer, but all that git would see is the addition of the line of
> ////..., but not the removal of the original line.
> 
> I've tried some other simple file changes with similar results.
> Something seems to be definitely broken in git diff. :(

You might want to show your exact command-line invocation, i.e. the full information. I suspect that you missed the fact that `git diff a b` does not compare the file a to the file b, but instead it compares both a and b to what is recorded in the index. With one quirk: if the files a and b are not even recorded in the index, `git diff` will output nothing.

Now, the really confusing part for you was probably that your `file-2` *was* recorded in the index (maybe you made a backup copy with the extra file extension `.bak` or some such, and then called `git diff my-file.bak my-file` where `my-file` *actually is tracked by Git* but `my-file.bak` is not).

But `git diff` has so nice features that I wanted to use it myself to compare files or directories. That is why I introduced the `--no-index` option, years ago. And so I suspect that you called

    git diff file-1 file-2

when you actually wanted to call

    git diff --no-index file-1 file-2

Here is my shell session to verify that `git diff` works as designed:

```
me@work $ cat >file-1

abcd efg hijklmnop

me@work $ cat >file-2

blah blah blah
/////////////////////////////////////////////////////////////////////////////////
abdc boo ya!

me@work $ git diff --no-index file-1 file-2
diff --git a/file-1 b/file-2
index 80ea2bc..f7fd7eb 100644
--- a/file-1
+++ b/file-2
@@ -1,3 +1,5 @@

-abcd efg hijklmnop
+blah blah blah
+/////////////////////////////////////////////////////////////////////////////////
+abdc boo ya!

me@work $
```

Please note that I ended the file contents for both `cat` calls [*1*] with a `Ctrl+D` which you cannot see in the pasted lines.

Ciao,
Johannes

Footnote *1*: Can you believe that I wanted to make that pun for at least ten years now?
