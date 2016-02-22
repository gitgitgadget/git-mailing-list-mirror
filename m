From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Mon, 22 Feb 2016 17:58:15 +0530
Message-ID: <CA+DCAeTYwfKy_S-5uy=BKNP5J3sa2+wMrpZEQZAikROmvOy1vw@mail.gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
	<vpq37so26oz.fsf@anie.imag.fr>
	<CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
	<CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
	<CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com>
	<vpq8u2er7ae.fsf@anie.imag.fr>
	<CA+DCAeQWeUodaBtHOdzGB3RTZTQ672ZUSV-=eh-nA+8Bvn4gxw@mail.gmail.com>
	<vpq1t85rj44.fsf@anie.imag.fr>
	<CA+DCAeQGPqZvvn5RSA0UweM4sQLat-2OPo4BdEDyvUbq+eLi=w@mail.gmail.com>
	<CACsJy8BKko=esR5Q3dsq=Z-pdX1EtocJr25tH4Fn+E-pOns=_Q@mail.gmail.com>
	<CA+DCAeQADoW-r5ppDNXVBj0=16FXKi=3pedAzhRuCD9uDJz_YQ@mail.gmail.com>
	<CACsJy8B7m7PWY-RJ2pb3fAP6ZKz167Xzbby9Lo44gfDX9w7NPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 22 13:28:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXpbA-0000la-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 13:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbcBVM2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 07:28:17 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35406 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbcBVM2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 07:28:16 -0500
Received: by mail-qg0-f51.google.com with SMTP id y89so109142482qge.2
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 04:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yLY/2+jeleT1Sp2rC8MfOHGj4SnuUqJaXQIDX7Mrn6o=;
        b=NBAS0/hji35SI+5so6ZNdQdgWkd7cTLp6Bn/gxvMgqmS3cQuGguTuFmK/772aEgf9h
         QrlMst79dVq4X9/tUz/FPpvlVimyy3XLVdu0U1plmaBMRoFio63yHd+dGwJwY8sL0ez0
         66dVFahHnvUxIOlsBGbc0mNxXoLmGa0a6knW2Ehg20cGDH9O6CPYVksnKzov+xAsSUFv
         6SPXCVa2+kSYKeAe9A7F251hFLK7TtSvNXrNLfEO9MKEJqIze4TAAwiC6inZWqJ6nS1r
         I/SXsXI8FMfNs2dEca0TzfT9UuLkOYl4zQxEfHqwljiTbDClYpGilNTHfwATiXnPHLHD
         3y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yLY/2+jeleT1Sp2rC8MfOHGj4SnuUqJaXQIDX7Mrn6o=;
        b=AadYtWRJ8cBZcwY/mj3OigYVDEIbVaxdIAl/3v5YmwHbq2sgLaIKkQa+np/xq372hS
         loHGyTL7aKKtJqO7AZrHrC+Q8d1P4CHGeIMlE808Lw0HYp/xeUzJXiGP7jNCaQczTvua
         hiBPw1/AWPOUOs3Xvqx+piLcVwMjRM3bn7BENnQdIMdynKGK1WN1kRH2V46X8MkfEu75
         8Kg99CVzJ/PyJ7OkJAs4Fk0z9m9Pa3ZX461cfapdUe0PO9WkFqNO9NEnLpLfgxcPdpuq
         3OUsZ/RejaydJSyJ3QpoDs7gAYeIc8s6Kqzrd3SD70CZtQ35lZRMTxUFBrFBeVBHIkCG
         kGSw==
X-Gm-Message-State: AG10YOS0jgkozD4L1r3QpRRfbdJ05e9WtjmO47YoV8DxquAwu1VLZjqrzOTKuShQ26r3qDicp+WQjg3BEcswcg==
X-Received: by 10.140.157.7 with SMTP id d7mr35663434qhd.17.1456144095781;
 Mon, 22 Feb 2016 04:28:15 -0800 (PST)
Received: by 10.55.154.205 with HTTP; Mon, 22 Feb 2016 04:28:15 -0800 (PST)
In-Reply-To: <CACsJy8B7m7PWY-RJ2pb3fAP6ZKz167Xzbby9Lo44gfDX9w7NPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286926>

On Mon, Feb 22, 2016 at 4:51 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> OK server is up but very likely misconfigured. If you have experience
> with http server before (I think this is apache), then you can dig in
> t/lib-httpd.sh, study how the server is configured and try to fix it.

Thanks Duy. :)  All tests passed. I configured apache server to listen
to the ports tests were trying to access.

Thanks Lars. I tested on Traivs-CI, worked fine. :)

Mehul Jain
