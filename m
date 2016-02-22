From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Mon, 22 Feb 2016 17:20:35 +0700
Message-ID: <CACsJy8BKko=esR5Q3dsq=Z-pdX1EtocJr25tH4Fn+E-pOns=_Q@mail.gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
 <vpq37so26oz.fsf@anie.imag.fr> <CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
 <CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
 <CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com>
 <vpq8u2er7ae.fsf@anie.imag.fr> <CA+DCAeQWeUodaBtHOdzGB3RTZTQ672ZUSV-=eh-nA+8Bvn4gxw@mail.gmail.com>
 <vpq1t85rj44.fsf@anie.imag.fr> <CA+DCAeQGPqZvvn5RSA0UweM4sQLat-2OPo4BdEDyvUbq+eLi=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	karthik nayak <Karthik.188@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:21:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXnc8-0004XS-Qa
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 11:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbcBVKVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 05:21:07 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:32991 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbcBVKVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 05:21:06 -0500
Received: by mail-lf0-f44.google.com with SMTP id m1so91307566lfg.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 02:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ktrsNf+s+bAPvKzBTwze0Zy9/g7LG2auLDse3+lhyuc=;
        b=V6/ogXLpczDK28BZpoetEJWxQ0lHUCevGasDKFOiB4t/B702/R1ZcG1l6nwZBuKMFt
         YFO4OtCfBVneP042qN6CPIla0HsW6HUDiKIqWbw0DsxX8lk9zYUC6MN2+0NAUAbxQzbA
         WIDZ14FRN3reArw2I++EMQr8/Drts077FIqLp748PLKVfFErAt4kFaYNuP9joPF5dAx7
         oDLWKl5iDCbtb/yxqHn3JGpcHoSGx58SQUuY7tJ0HekOgBjkQ5sPPy/ub81enSeg3wAr
         mWnnskkr/EUxV8RoHON1VS/lE4G5ZYlH+T5inG/bLnhhMrY4l/UKsquFDuLnvsG0uQeH
         YArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ktrsNf+s+bAPvKzBTwze0Zy9/g7LG2auLDse3+lhyuc=;
        b=Fa3fLWAfXItBwbTh52Cs3yaQIxbW6WkWnlyzdduPpzLAh49kSfAZpfJ44ZwLHvQEoL
         EG+qHtUwaenVgCl0HT74fl2DNjfOAcHhNVDMjfCHifo/Df8/sgG9n6+l7ZcnMvpIROi/
         T87tiRXBSpTHS+TT4XUSg17IV4ZGcTZtqxzQxBJVRXAOEs46aKLbAVJp9ZyAGs8QX10i
         nRb9EIbHZ3pVCEvweP1jh2uoNZhGQhrg4usMHSQtH2f+ukgectP3wD6whsqk2rAs+EJQ
         ZK17pL2inhee6CjCmvCGTTuoHBuAn0/I4i9HYfPaUZ0xqIjuF+R4tKfabc4a4SMdtW5f
         oR9Q==
X-Gm-Message-State: AG10YOSYUh79pk1/aQ01Uj2UDsDUI63AoMpyAaRaoBbXH8ViGnHMxyuZHoavPu6ggOJRqrSm/LhzTM/pUV++0A==
X-Received: by 10.25.161.131 with SMTP id k125mr6650916lfe.83.1456136464658;
 Mon, 22 Feb 2016 02:21:04 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 22 Feb 2016 02:20:35 -0800 (PST)
In-Reply-To: <CA+DCAeQGPqZvvn5RSA0UweM4sQLat-2OPo4BdEDyvUbq+eLi=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286902>

On Mon, Feb 22, 2016 at 5:12 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> On Mon, Feb 22, 2016 at 12:22 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> The simplest way to get back on track for you is probably to start over
>> with a fresh clone, or (warning: destructive operations): use git clean
>> to remove untracked files.
>
> Hello Matthieu,
>
> I followed your advise and cloned a fresh copy of git source code.
> After compiling it and running the test with " prove --timer --jobs 15
> ./t[0-9]*.sh" command, I received tests failure. All these tests are
> regarding HTTP protocol being invoked like
> t5539-fetch-http-shallow.sh.

You may have an http server installed but not suitable for these
tests. Try running one test file alone with -v -i, e.g.
./t5539-fetch-http-shallow.sh -v -i and post the output.

> I'm behind a proxy server which blocks all ports except 80 and 443.
> Also my .gitconfig file is properly configured for proxy. Can these
> tests failure be triggered because of proxy server?

No. HTTP server will be run locally on your machine and serve all the tests.
-- 
Duy
