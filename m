Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF2BC1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 15:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755003AbcHSPSb (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 11:18:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:56190 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754014AbcHSPSb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 11:18:31 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MGEv5-1bLcrA0S3D-00FCKw; Fri, 19 Aug 2016 17:18:15
 +0200
Date:   Fri, 19 Aug 2016 17:18:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Wong <e@80x24.org>, Stefan Beller <sbeller@google.com>,
        meta@public-inbox.org, git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <xmqqzio94uw8.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608191717490.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160818204902.GA1670@starla> <xmqqzio94uw8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:N/8GThjLe0+CmPbbbuKKd+U93GC2ttJxqiURaFh2jPawgX4GaXu
 9p3bkdYtNTyme34gLAlHvNk15XhMlY+XL+LCx1B76OhTJw0Jjvym5Yt2jhjjB5UmVQZb+OO
 DUPyqPdQgmF54fUfTKsZt7AZQqHw74WgTVxSQBS/2w8cyAnMlxukNBAogNCqGSdRnrLegfw
 wXdXAjGgOrq4DCxJBz4/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:reqbBwp2RJw=:tynGLLKi2C/CA9p92GYrgX
 nUegeYWzLQHqvzHLJOjugNGiWmnH00TnLVl2HV4zSd7EnrAY4vcnJaoco5f1cD+i4ZcqdKuyR
 aSqCUF0gyOLjIaVV4KYoKAgMSlk/P5y/lSX93Mcv3Nmxcr9qLYjjEJ5RSUMfqh06r9s2yENtP
 Av1xGo61p/HgpxZurIjsV09EK9xgrTAl8unoBV9nMzjdPzBKufr3DGJR1Ub2yWXrney6IU2ld
 C/uis/5qMWQ4Wnkga0erMrINx5yXCTvBknHyseHZWlCINZIiPJRnrJdkFsOEP/+F2bJKOsYYR
 EXthfc2qAD9/M0rzRCFJohejT+3Je1oUdeMP5BFxAa9oxGPO4fPQtCQ1aDvGBJ+21weeThhpF
 WdMgMcr/pHJUPlsZ3KRI0C4+ZQlXrr0IVZFHYWyuykAn0gz3krlM89I3pXjPeMBH+8Khex/7U
 VUFwtK8eRCzNPcpbHeoNqmLDChmsN/FR361OPqbmLGL6kUttiGnTc9m0FawjrKKtCE2yywcVN
 6jZ+IfUZSsTjFRTtexYvilZCCETImUqaUkku3PwXm+iCtZc6h5DXdxeeQywhkzpQgujWLoQ3F
 763tymf2ZJamTvB+fPd0HBq9AEE4iZ+2KaiCvh4zGdKmjKRv3vgIb6wC/gL7kCaklZFcsupkz
 zst30v/eCtFudNY/JiOoINY6aEYM6GHELkpQVhbXtFTI/wWu+dY5Z8PmJcuNmpoEzSzHqvGT1
 93KI3nEGbqZmGH8B9J57EK5KAk95z6WTOAMIT1zoM7IuVXuWwnhOJKGFis2L18K0M99nQYWYK
 vxABD8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 18 Aug 2016, Junio C Hamano wrote:

> Eric Wong <e@80x24.org> writes:
> 
> > unsubscribe: meta+unsubscribe@public-inbox.org
> 
> Did you mean this, really?

FWIW I do not see this line in my original mail from Eric.

Ciao,
Dscho
