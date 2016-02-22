From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Mon, 22 Feb 2016 11:30:31 +0100
Message-ID: <9D5C632B-0F4C-482A-9A05-056B3F878B79@gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com> <vpq37so26oz.fsf@anie.imag.fr> <CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com> <CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com> <CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com> <vpq8u2er7ae.fsf@anie.imag.fr> <CA+DCAeQWeUodaBtHOdzGB3RTZTQ672ZUSV-=eh-nA+8Bvn4gxw@mail.gmail.com> <vpq1t85rj44.fsf@anie.imag.fr> <CA+DCAeQGPqZvvn5RSA0UweM4sQLat-2OPo4BdEDyvUbq+eLi=w@mail.gmail.com> <5B6C5271-FC9E-409E-9410-CE699499901D@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Users <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	karthik nayak <Karthik.188@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:30:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXnlI-0004UK-K2
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 11:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbcBVKaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 05:30:35 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35954 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbcBVKae convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 05:30:34 -0500
Received: by mail-wm0-f49.google.com with SMTP id g62so165073419wme.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 02:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RqMqSYvqbNK9yCI9EpYaC5BD4ZwgenaXRImfhyC9T64=;
        b=EoFHEFl2+HAgIzcouNZtU+kmvaKLCt76/0ZnazlxZhFcui6+mHsKJyRpS3KbM7kH5i
         BHRioJUVHrRpEK+0L8ia+5BBC1wZrRnTzds9U+5wIN7u5uoNK5QJXE1+1Bp3pA23odc4
         6gBxEZwpZ2VEZb8dhN8CLuy++BpLj8lUXpLvqbqfa7fe79QAI4zPAubAAbBxnqnvlrrq
         6q28S6ON1CEO8nWJdX+JEgfxBoRXt+Fkl1xhrpONGeMBrfGP/jvNetueDWOP1/sewgv/
         7tloiyZTWOG6KZARHfta/QTYLAwxT3RX38CNrPny/OOM7SZ4f1C83fWbh9NPQ2LDZs99
         7vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=RqMqSYvqbNK9yCI9EpYaC5BD4ZwgenaXRImfhyC9T64=;
        b=WkhdPBFg/v0J7I03xmCOsgLrxhka3V9hoNYjkbQMlQxKM9vzL3xQwIGyvFxvdrbAKB
         1dOEvEKVlxptGxGmn5xd1wjjChwLLfduT3SVGjpD1qaw0CSUGK5mzj/8PGbNbO2zez7Y
         8PWLGnvCt77rgB7JC64A807d9i74HSkd7ZJswRcnzpWtiJvSoBPnqT8epDecwmMoqDNV
         O8HDXzqonIyhDrC34yKu2cqir6EzDlKWk4k6+mj/69E408N5BXt+T0kBpUDg9rjv9/ts
         M+X2A3gZhTtGvHUT9tZB7GAexb7PkJI14MFcm/vy+j7zAtAbkYZS9EISvYJnYXC7Qq9m
         kJGA==
X-Gm-Message-State: AG10YORVGtU7TkFsOSJ06kwisTaw0Ppmh7FCMlbmN1C712P+fViAdoCIrIIv2qxjH6YczQ==
X-Received: by 10.194.115.132 with SMTP id jo4mr8041141wjb.156.1456137033142;
        Mon, 22 Feb 2016 02:30:33 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id ka4sm23967527wjc.47.2016.02.22.02.30.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Feb 2016 02:30:32 -0800 (PST)
In-Reply-To: <5B6C5271-FC9E-409E-9410-CE699499901D@gmail.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286906>


> On 22 Feb 2016, at 11:21, Lars Schneider <larsxschneider@gmail.com> wrote:
> 
> 
>> On 22 Feb 2016, at 11:12, Mehul Jain <mehul.jain2029@gmail.com> wrote:
>> 
>> On Mon, Feb 22, 2016 at 12:22 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> The simplest way to get back on track for you is probably to start over
>>> with a fresh clone, or (warning: destructive operations): use git clean
>>> to remove untracked files.
>> 
>> Hello Matthieu,
>> 
>> I followed your advise and cloned a fresh copy of git source code.
>> After compiling it and running the test with " prove --timer --jobs 15
>> ./t[0-9]*.sh" command, I received tests failure. All these tests are
>> regarding HTTP protocol being invoked like
>> t5539-fetch-http-shallow.sh.
>> 
>> I'm behind a proxy server which blocks all ports except 80 and 443.
>> Also my .gitconfig file is properly configured for proxy. Can these
>> tests failure be triggered because of proxy server?
>> 
> 
> Hi Mehul,
> 
> please try this:
> https://github.com/git/git.github.io/commit/9754cb22aeacf37fe341c5b3fde88f2a79e0ea24
> 
Oops.. I am sorry. I should have read your email more closely. t5539 is not yet executed on Travis-CI...
But it wouldn't be too hard to add ;-)

Cheers,
Lars