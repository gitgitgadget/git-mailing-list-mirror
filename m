From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Mon, 22 Feb 2016 18:21:22 +0700
Message-ID: <CACsJy8B7m7PWY-RJ2pb3fAP6ZKz167Xzbby9Lo44gfDX9w7NPg@mail.gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
 <vpq37so26oz.fsf@anie.imag.fr> <CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
 <CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
 <CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com>
 <vpq8u2er7ae.fsf@anie.imag.fr> <CA+DCAeQWeUodaBtHOdzGB3RTZTQ672ZUSV-=eh-nA+8Bvn4gxw@mail.gmail.com>
 <vpq1t85rj44.fsf@anie.imag.fr> <CA+DCAeQGPqZvvn5RSA0UweM4sQLat-2OPo4BdEDyvUbq+eLi=w@mail.gmail.com>
 <CACsJy8BKko=esR5Q3dsq=Z-pdX1EtocJr25tH4Fn+E-pOns=_Q@mail.gmail.com> <CA+DCAeQADoW-r5ppDNXVBj0=16FXKi=3pedAzhRuCD9uDJz_YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	karthik nayak <Karthik.188@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 12:21:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXoYv-0006Yo-Tb
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 12:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbcBVLVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 06:21:54 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34554 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbcBVLVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 06:21:53 -0500
Received: by mail-lb0-f176.google.com with SMTP id of3so79926530lbc.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 03:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MLV2t8ZaTkCZhB17EX45u/coRPdbtdVe1/azsiG2KGw=;
        b=XY8YTX9G1LFyTzqtaoEltBs+VfCmNY5r0fOUwtUwjVegHRC9PojwoeYc/jKUK4qKvg
         denFnVFONKVUMmOX4pFC0RoC6xf69/CQjfvMTfMFTYptwa4IyLcY1Owf3BwlKclgDHLh
         VT6h3QQnL4Pt09D+vOAV54HHA0jcGi8zxUGRN/JJFMha2dRinlWxRRRo8pB0ogkV3QNO
         1vOIpyRvTAzNpdCuaXiK14+7BOI08lWnoj2SUJQ9MMlZ+7qx7PghCmuBSsitQ1Ase29j
         J7ZVua9OkZbDf0pmm9dYDZSdgOX3aboyoXtZE09zU7DaKyN8zRj2lESP4WutzHwLxGp9
         /3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=MLV2t8ZaTkCZhB17EX45u/coRPdbtdVe1/azsiG2KGw=;
        b=K4z7ldA2M5wl0al4EMZMI9FJA8JzGbNgg+TjmFwuU69OFOBtKuT6f6zuMmTkcMlsNW
         Gy+GvQRYOlCSwwR/MvHIiBhI38whFuTgYs5X16S35WY3f4STiEVmA4uekUlt06rtBSqD
         /jz4vLs4JZqSZWO8xdTV3y5hL6E1hkkhrH2QBOqe94rZD7V11h5BnjrdAHsDfLstZMpv
         q/PgrvMmJHmO0gErXujtU6VJzG0bHl5ST2lA0mTS/FSsI5b7zB/okglATdd9ye3FpNiF
         BH1A4Yq5si2xHdm9o6nWhtTclPsL466IN5abhN/CYQmQidaZqkdMIcEyOO9wLx6jza4T
         QfVg==
X-Gm-Message-State: AG10YOSlKE/So8xjoBuCbNoUqEY7oVD8f5vNSAXyChFLQHzte3KtAAGFj0xyOJSPFkL4vxNO9fYFnUF8D+rZOA==
X-Received: by 10.112.209.99 with SMTP id ml3mr9648951lbc.26.1456140111774;
 Mon, 22 Feb 2016 03:21:51 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 22 Feb 2016 03:21:22 -0800 (PST)
In-Reply-To: <CA+DCAeQADoW-r5ppDNXVBj0=16FXKi=3pedAzhRuCD9uDJz_YQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286908>

On Mon, Feb 22, 2016 at 5:30 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> On Mon, Feb 22, 2016 at 3:50 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> You may have an http server installed but not suitable for these
>> tests. Try running one test file alone with -v -i, e.g.
>> ./t5539-fetch-http-shallow.sh -v -i and post the output.
>
> Here's the output :-
>
> expecting success:
>     git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
>     git clone $HTTPD_URL/smart/repo.git clone &&
>     (
>     cd clone &&
>     git fsck &&
>     git log --format=%s origin/master >actual &&
>     cat <<EOF >expect &&
> 7
> 6
> 5
> 4
> 3
> EOF
>     test_cmp expect actual
>     )
>
> Cloning into bare repository '/home/mj/git/t/trash
> directory.t5539-fetch-http-shallow/httpd/www/repo.git'...
> remote: Counting objects: 15, done.
> remote: Compressing objects: 100% (5/5), done.
> remote: Total 15 (delta 0), reused 15 (delta 0)
> Receiving objects: 100% (15/15), done.
> Checking connectivity... done.
> Cloning into 'clone'...
> fatal: unable to access 'http://127.0.0.1:5539/smart/repo.git/': The
> requested URL returned error: 403

OK server is up but very likely misconfigured. If you have experience
with http server before (I think this is apache), then you can dig in
t/lib-httpd.sh, study how the server is configured and try to fix it.

Alternatively, you can smiply skip http tests by setting environment
variable GIT_TEST_HTTPD to false before running the tests.
-- 
Duy
