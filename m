From: "Ifejinelo Onyiah" <nelo.onyiah@googlemail.com>
Subject: Re: Errors building git-1.5.6 from source on Mac OS X 10.4.11
Date: Fri, 27 Jun 2008 09:43:05 +0100
Message-ID: <2eb980790806270143i5caec64fs498d9ca08acb0a1c@mail.gmail.com>
References: <2eb980790806250620t73ae0ff7heedb65780a66ad00@mail.gmail.com>
	 <20080625175311.GB4039@steel.home>
	 <2eb980790806260148p7713a546k641d96a956e9b0fa@mail.gmail.com>
	 <81b0412b0806261142r37f84187qf5ff043e1913b4fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 10:44:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC9Z3-00089h-VV
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 10:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759378AbYF0InU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 04:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759360AbYF0InT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 04:43:19 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:16285 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757443AbYF0InR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 04:43:17 -0400
Received: by yw-out-2324.google.com with SMTP id 9so167520ywe.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FXniNtca6XHw1pqcTOoHxeHYrDLNZsSxJG23aDZxU30=;
        b=M3z/sMm698OWehrQxsK/h10sl5k37MAaPTqAvQKtpUx+ySi3r61x0ghU3ixFn4JIw8
         4B9VTDzrDxahjNzLyRzyDBgtF1PIkWNIxq5ReNJ87hLLRK9E32ut+vLB4WR7y/NLUO5B
         J6KgRv3mtYrW+p2MDdsHBcMgKHIyR6GflmQps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=g0YiLEUlQyzo0j5HzYb0D5Ek1oGun5k8KjGpLmU+75W3NU3RmbFLNDYDt9iyieKrV5
         0ZeXZKzhESzbQjoS3mD9ucn2DyO8RhIZSEAhMPfabz4EoKvZXWdiq1rQ9EeqyUmSv9QK
         hFvbW42HpybBW6fjNy48v5Sdhyw+ZyAfcCKww=
Received: by 10.151.15.9 with SMTP id s9mr554714ybi.158.1214556185155;
        Fri, 27 Jun 2008 01:43:05 -0700 (PDT)
Received: by 10.151.7.15 with HTTP; Fri, 27 Jun 2008 01:43:05 -0700 (PDT)
In-Reply-To: <81b0412b0806261142r37f84187qf5ff043e1913b4fb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86535>

2008/6/26 Alex Riesen <raa.lkml@gmail.com>:
> 2008/6/26 Ifejinelo Onyiah <nelo.onyiah@googlemail.com>:
>> 2008/6/25 Alex Riesen <raa.lkml@gmail.com>:
>>> Ifejinelo Onyiah, Wed, Jun 25, 2008 15:20:39 +0200:
>>>>
>>>> They all run fine but when I issue the make test command, it dies at
>>>> the following:
>>>>
>>>> % make test
>>>>
>>>> ... TRUNCATED OUTPUT ...
>>>>
>>>> *** t2004-checkout-cache-temp.sh ***
>>>> * FAIL 1: preparation
>>>>
>>>
>>> If you don't mind helping the investigation a bit, could you please go
>>> into the t/ directory and run
>>>
>>>    bash -x t2004-checkout-cache-temp.sh -d -v -i
>>>
>>> and post the output here?
>>
>> I ran that command and it seemed to run with no problems. I have
>> provided the output in 2 attached text files. I hope that is ok.
>
> could you try the command _without_ "bash -x"?
> Like this:
>
>    cd t
>    ./t2004-checkout-cache-temp.sh -d -v -i
>

I've just done that and here's the output:

io1@mib19412i[00m:~/Desktop/git-1.5.6/t$ ./t2004-checkout-cache-temp.sh -d -v -i
* expecting success:
mkdir asubdir &&
echo tree1path0 >path0 &&
echo tree1path1 >path1 &&
echo tree1path3 >path3 &&
echo tree1path4 >path4 &&
echo tree1asubdir/path5 >asubdir/path5 &&
git update-index --add path0 path1 path3 path4 asubdir/path5 &&
t1=$(git write-tree) &&
rm -f path* .merge_* out .git/index &&
echo tree2path0 >path0 &&
echo tree2path1 >path1 &&
echo tree2path2 >path2 &&
echo tree2path4 >path4 &&
git update-index --add path0 path1 path2 path4 &&
t2=$(git write-tree) &&
rm -f path* .merge_* out .git/index &&
echo tree2path0 >path0 &&
echo tree3path1 >path1 &&
echo tree3path2 >path2 &&
echo tree3path3 >path3 &&
git update-index --add path0 path1 path2 path3 &&
t3=$(git write-tree)
*   ok 1: preparation

* expecting success:
rm -f path* .merge_* out .git/index &&
git read-tree $t1 &&
git checkout-index --temp -- path1 >out &&
test $(wc -l <out) = 1 &&
test $(cut "-d  " -f2 out) = path1 &&
p=$(cut "-d     " -f1 out) &&
test -f $p &&
test $(cat $p) = tree1path1
*   ok 2: checkout one stage 0 to temporary file

* expecting success:
rm -f path* .merge_* out .git/index &&
git read-tree $t1 &&
git checkout-index -a --temp >out &&
test $(wc -l <out) = 5 &&
for f in path0 path1 path3 path4 asubdir/path5
do
       test $(grep $f out | cut "-d    " -f2) = $f &&
       p=$(grep $f out | cut "-d       " -f1) &&
       test -f $p &&
       test $(cat $p) = tree1$f
done
*   ok 3: checkout all stage 0 to temporary files

* expecting success:
rm -f path* .merge_* out .git/index &&
git read-tree -m $t1 $t2 $t3
*   ok 4: prepare 3-way merge

* expecting success:
rm -f path* .merge_* out &&
git checkout-index --stage=2 --temp -- path1 >out &&
test $(wc -l <out) = 1 &&
test $(cut "-d  " -f2 out) = path1 &&
p=$(cut "-d     " -f1 out) &&
test -f $p &&
test $(cat $p) = tree2path1
*   ok 5: checkout one stage 2 to temporary file

* expecting success:
rm -f path* .merge_* out &&
git checkout-index --all --stage=2 --temp >out &&
test $(wc -l <out) = 3 &&
for f in path1 path2 path4
do
       test $(grep $f out | cut "-d    " -f2) = $f &&
       p=$(grep $f out | cut "-d       " -f1) &&
       test -f $p &&
       test $(cat $p) = tree2$f
done
*   ok 6: checkout all stage 2 to temporary files

* expecting success:
rm -f path* .merge_* out &&
git checkout-index --stage=all --temp -- path0 >out &&
test $(wc -l <out) = 0
git-checkout-index: path0 does not exist at stage 4
*   ok 7: checkout all stages/one file to nothing

* expecting success:
rm -f path* .merge_* out &&
git checkout-index --stage=all --temp -- path1 >out &&
test $(wc -l <out) = 1 &&
test $(cut "-d  " -f2 out) = path1 &&
cut "-d " -f1 out | (read s1 s2 s3 &&
test -f $s1 &&
test -f $s2 &&
test -f $s3 &&
test $(cat $s1) = tree1path1 &&
test $(cat $s2) = tree2path1 &&
test $(cat $s3) = tree3path1)
*   ok 8: checkout all stages/one file to temporary files

* expecting success:
rm -f path* .merge_* out &&
git checkout-index --stage=all --temp -- path2 >out &&
test $(wc -l <out) = 1 &&
test $(cut "-d  " -f2 out) = path2 &&
cut "-d " -f1 out | (read s1 s2 s3 &&
test $s1 = . &&
test -f $s2 &&
test -f $s3 &&
test $(cat $s2) = tree2path2 &&
test $(cat $s3) = tree3path2)
*   ok 9: checkout some stages/one file to temporary files

* expecting success:
rm -f path* .merge_* out &&
git checkout-index -a --stage=all --temp >out &&
test $(wc -l <out) = 5
*   ok 10: checkout all stages/all files to temporary files

* expecting success:
test x$(grep path0 out | cut "-d        " -f2) = x
*   ok 11: -- path0: no entry

* expecting success:
test $(grep path1 out | cut "-d " -f2) = path1 &&
grep path1 out | cut "-d        " -f1 | (read s1 s2 s3 &&
test -f $s1 &&
test -f $s2 &&
test -f $s3 &&
test $(cat $s1) = tree1path1 &&
test $(cat $s2) = tree2path1 &&
test $(cat $s3) = tree3path1)
*   ok 12: -- path1: all 3 stages

* expecting success:
test $(grep path2 out | cut "-d " -f2) = path2 &&
grep path2 out | cut "-d        " -f1 | (read s1 s2 s3 &&
test $s1 = . &&
test -f $s2 &&
test -f $s3 &&
test $(cat $s2) = tree2path2 &&
test $(cat $s3) = tree3path2)
*   ok 13: -- path2: no stage 1, have stage 2 and 3

* expecting success:
test $(grep path3 out | cut "-d " -f2) = path3 &&
grep path3 out | cut "-d        " -f1 | (read s1 s2 s3 &&
test -f $s1 &&
test $s2 = . &&
test -f $s3 &&
test $(cat $s1) = tree1path3 &&
test $(cat $s3) = tree3path3)
*   ok 14: -- path3: no stage 2, have stage 1 and 3

* expecting success:
test $(grep path4 out | cut "-d " -f2) = path4 &&
grep path4 out | cut "-d        " -f1 | (read s1 s2 s3 &&
test -f $s1 &&
test -f $s2 &&
test $s3 = . &&
test $(cat $s1) = tree1path4 &&
test $(cat $s2) = tree2path4)
*   ok 15: -- path4: no stage 3, have stage 1 and 3

* expecting success:
test $(grep asubdir/path5 out | cut "-d " -f2) = asubdir/path5 &&
grep asubdir/path5 out | cut "-d        " -f1 | (read s1 s2 s3 &&
test -f $s1 &&
test $s2 = . &&
test $s3 = . &&
test $(cat $s1) = tree1asubdir/path5)
*   ok 16: -- asubdir/path5: no stage 2 and 3 have stage 1

* expecting success:
(cd asubdir &&
git checkout-index -a --stage=all >out &&
test $(wc -l <out) = 1 &&
test $(grep path5 out | cut "-d        " -f2) = path5 &&
grep path5 out | cut "-d       " -f1 | (read s1 s2 s3 &&
test -f ../$s1 &&
test $s2 = . &&
test $s3 = . &&
test $(cat ../$s1) = tree1asubdir/path5)
)
*   ok 17: checkout --temp within subdir

* expecting success:
rm -f path* .merge_* out .git/index &&
ln -s b a &&
git update-index --add a &&
t4=$(git write-tree) &&
rm -f .git/index &&
git read-tree $t4 &&
git checkout-index --temp -a >out &&
test $(wc -l <out) = 1 &&
test $(cut "-d  " -f2 out) = a &&
p=$(cut "-d     " -f1 out) &&
test -f $p &&
test $(cat $p) = b
*   ok 18: checkout --temp symlink

* passed all 18 test(s)
io1@mib19412i[00m:~/Desktop/git-1.5.6/t$
