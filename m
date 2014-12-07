From: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Subject: Re: How to repair a shallow clone (?)
Date: Sun, 07 Dec 2014 07:37:58 +0700
Message-ID: <5483A166.4010109@gmail.com>
References: <5482F55F.1060008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 01:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxPvu-0006k1-H9
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 01:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbaLGAiE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2014 19:38:04 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:43713 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbaLGAiD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 19:38:03 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so2965689pab.12
        for <git@vger.kernel.org>; Sat, 06 Dec 2014 16:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mHs6Pn3nPdxSp5KYmpaV6vd07rRnn0YkqfWLqeS2IhU=;
        b=sb7cOKF29tea8bneInGcpZz5b0cPi1zx2MuEidad6EA0I5oxQHB37LCBRt7na58/xB
         6Av+19t7Ds3K9aKYkjbNsFL2mzFxLTE/Engx+d0J597LL7xRXX2WEKpakfyrnIUmv6Pt
         2a9dbPP6dW+njCMXt8FmJU53RsQKpTRbucw5tGvwt5KtuEGLVJYwG+M8MFkLhvjwIeZr
         YXXYWvpBpbns6g1Yv/Hlu9/Nd6EVX5+vhDRK3K31E2Udn75zxrU/Jncgj/SXd/YlsQ55
         +By0d2s874G53FH3zz/TBzRFCtcmVqv7fK3jzwcC80X/RnOElqlZpDC4UGEdXggFqrBJ
         buTw==
X-Received: by 10.68.190.229 with SMTP id gt5mr47664151pbc.119.1417912682524;
        Sat, 06 Dec 2014 16:38:02 -0800 (PST)
Received: from vnwildman.myftp.org ([113.168.10.223])
        by mx.google.com with ESMTPSA id fe5sm21967183pdb.77.2014.12.06.16.38.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Dec 2014 16:38:02 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <5482F55F.1060008@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260967>

On 06/12/2014 19:23, Torsten B=C3=B6gershausen wrote:
> I think I started to clone the repo in a shallow way
> (SparkleShare asked if I want to clone the complete history,
> and I probably answered "no" )
>
> Is there a way to repair this situation ?
> (Except doing a complete re-clone ?)
>
I think git don't accept push from shallow repo. I've ever encounter
this problem. I UNshallow it, then every thing will work:

$ git fetch --unshallow origin

This command will convert a shallow repository to a complete one.
See git-fetch(1) and git-clone(1).

I hope it helpful!
Thanks,

--=20
Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
