From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Mon, 22 Feb 2016 15:42:11 +0530
Message-ID: <CA+DCAeQGPqZvvn5RSA0UweM4sQLat-2OPo4BdEDyvUbq+eLi=w@mail.gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
	<vpq37so26oz.fsf@anie.imag.fr>
	<CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
	<CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
	<CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com>
	<vpq8u2er7ae.fsf@anie.imag.fr>
	<CA+DCAeQWeUodaBtHOdzGB3RTZTQ672ZUSV-=eh-nA+8Bvn4gxw@mail.gmail.com>
	<vpq1t85rj44.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	karthik nayak <Karthik.188@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:12:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXnTa-00053g-5a
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 11:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbcBVKMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 05:12:13 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33934 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbcBVKMM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 05:12:12 -0500
Received: by mail-qg0-f42.google.com with SMTP id b67so107235226qgb.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 02:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Quumxj8u3Zm+FenMhp5L++L7fz07LKFQjsycp3beugk=;
        b=uVdGrNFXmbIdFc/U37MzEQUZ4bPge0y1jeub4qH+1TnSvF55prsYkJlHNyA8tihir6
         jPGK+Ft6/unOlaxXPitKhUZvOQg07YqXa1HhbcJc1fcVIWICkgBBNRTRD3zdHmaRNme9
         sBTh6wzwF4Baz39h5Mnevm5DQfgACAlzFoDuJ/gBAw92DMn0SrcCpIHOqNody1oHx9NP
         sUdyRqKT7eKdVYCZ5XUcr75wZ07bnENOON6pLxkqZz89spH/MmPRVcNaf8nNEUXt1Lc4
         LfzSwEvDrKAjUePQBP5dIt6M6ThVkJ1vpuQv7niM96QUyjHm7e4YadK6JsrcYJ/5rvSG
         H6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Quumxj8u3Zm+FenMhp5L++L7fz07LKFQjsycp3beugk=;
        b=YIoKZ6Qf00BxQAzg4N18rEt9n0oGwP6ygkzAEkOd1alzHuS5P6C7ZjAvOa0X3llS7c
         Nqe0+WqUqvoLkwrP1VU5oU9wt9KT+Z9x8cjk1A5yqEOKAWV/XHhtw717MRaOwO4DoAYF
         bg38ApEA7A7LuQ7BmFaxuzTbrgJ7ZmYrD3LaiuVL8tbdGKjbNgb6aO+PZ2D0Po7b2cRr
         jlpNu4Z9V7KVhhNxdqrc635EOJ9cLhgzkfnKMxiQc+sRB4gZ1Ovd7Nca/WY98KegDgN2
         pAhG8q2kEc8mdhIGYo/pkRJuDaNnKEavqtyn4b6nbuYuqr2xa83VG0ELLwsYAsWGCcfP
         1ZTw==
X-Gm-Message-State: AG10YOSoMdG8YiUo/Eeg841kpd3VjfanBvjQglNXkl0peqfhCFR+maHJ9P6MtZgodc9/M+BMuYZ1tE2Qsk/LIQ==
X-Received: by 10.140.157.7 with SMTP id d7mr34960397qhd.17.1456135931307;
 Mon, 22 Feb 2016 02:12:11 -0800 (PST)
Received: by 10.55.154.205 with HTTP; Mon, 22 Feb 2016 02:12:11 -0800 (PST)
In-Reply-To: <vpq1t85rj44.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286901>

On Mon, Feb 22, 2016 at 12:22 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> The simplest way to get back on track for you is probably to start over
> with a fresh clone, or (warning: destructive operations): use git clean
> to remove untracked files.

Hello Matthieu,

I followed your advise and cloned a fresh copy of git source code.
After compiling it and running the test with " prove --timer --jobs 15
./t[0-9]*.sh" command, I received tests failure. All these tests are
regarding HTTP protocol being invoked like
t5539-fetch-http-shallow.sh.

I'm behind a proxy server which blocks all ports except 80 and 443.
Also my .gitconfig file is properly configured for proxy. Can these
tests failure be triggered because of proxy server?

Thanks,
Mehul Jain
