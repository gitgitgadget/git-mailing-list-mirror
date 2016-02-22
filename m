From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Mon, 22 Feb 2016 11:21:33 +0100
Message-ID: <5B6C5271-FC9E-409E-9410-CE699499901D@gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com> <vpq37so26oz.fsf@anie.imag.fr> <CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com> <CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com> <CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com> <vpq8u2er7ae.fsf@anie.imag.fr> <CA+DCAeQWeUodaBtHOdzGB3RTZTQ672ZUSV-=eh-nA+8Bvn4gxw@mail.gmail.com> <vpq1t85rj44.fsf@anie.imag.fr> <CA+DCAeQGPqZvvn5RSA0UweM4sQLat-2OPo4BdEDyvUbq+eLi=w@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Users <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	karthik nayak <Karthik.188@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:21:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXnca-0004vJ-Th
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 11:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbcBVKVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 05:21:37 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33272 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977AbcBVKVg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 05:21:36 -0500
Received: by mail-wm0-f53.google.com with SMTP id g62so150008685wme.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 02:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LbOQkdR3TufCQ9L3D1zz8sRVIpFrcI42dQsn18Gssco=;
        b=fMkrByWBHWRAqXMgvdSdpXG3D42YveCGQ7CwmkdpgQtyGkRZxo3msxd7lIPpdxyRrm
         w1ixQebP4i8JmWeEEIqBHSq6FEXwQHywnVJfegELb7mjwWmDJHEemkQ2NaA4WG0s4Ju0
         CKvQxF8bvhKFz+eMDyEKEHxAIg6HhXLDMc3Sx0MyUTT8mo6kFHCXsvVVMrUMNgSz/JsI
         Tces5e6xXds6dRFQY+NfYcMbLaNOFbJpE5wq7Dm1GItG9vZAHtezWUWZTvSoGWdkc8zK
         HCrsRYCX/TZQ+iiOYBgGDngYctCTS2EyoHxzf/ts+1zEn0Vai9LrwZtYWgfNE9R33GBR
         9zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LbOQkdR3TufCQ9L3D1zz8sRVIpFrcI42dQsn18Gssco=;
        b=X9Z9GyHcCZ0RXPZ9wIeJM2nJQqgjy4JVcg7lHJHWpjj7bHXVs4dD3aWMBj8pJceb9A
         aQcckQK+V2yeySLY3SjriY00a251e1L6WngwAskTfjkT+bcVML+TV7u7p7uJUOhQ8sGR
         t7CKJMRik2V6zFGWjCe+SKFUp6KZqSlGrVexq/69+9GaPvDiDnmG7+59mnbWp7sWhGXf
         5n2g8mW2lYVlUOgJYJr+WEHa/U3O0P8os3ZAAbEQBh6U56Fo5Ab1aSkyk5x7ceulKV0K
         /BpD0CmwijlnZ6DP+j+fpQna0CokZcIYYVMtEyfZLU9sTEyrZZakvyRR6B14+aN4RiyH
         h0Yg==
X-Gm-Message-State: AG10YOSs/DwAt5z1YZciDxPpJz3Kv8WO2A50zGyZKWf2WkoCg1dur8XVMsRNMuSJ67xNCA==
X-Received: by 10.28.158.8 with SMTP id h8mr11644795wme.6.1456136495400;
        Mon, 22 Feb 2016 02:21:35 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id v22sm20372795wmv.12.2016.02.22.02.21.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Feb 2016 02:21:34 -0800 (PST)
In-Reply-To: <CA+DCAeQGPqZvvn5RSA0UweM4sQLat-2OPo4BdEDyvUbq+eLi=w@mail.gmail.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286903>


> On 22 Feb 2016, at 11:12, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> 
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
> 
> I'm behind a proxy server which blocks all ports except 80 and 443.
> Also my .gitconfig file is properly configured for proxy. Can these
> tests failure be triggered because of proxy server?
> 

Hi Mehul,

please try this:
https://github.com/git/git.github.io/commit/9754cb22aeacf37fe341c5b3fde88f2a79e0ea24

Cheers,
Lars