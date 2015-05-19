From: Stefan Beller <sbeller@google.com>
Subject: Re: test suite failure t5570, 8 with v2.4.1-168-g1ea28e1
Date: Tue, 19 May 2015 10:34:09 -0700
Message-ID: <CAGZ79kbYUNjD79T+1LqgLNf=_ym-keq57FoQhby_aqn_sPFYSg@mail.gmail.com>
References: <CAGZ79kY61ZJHHG4jj2hZSzXZ58fh9R9b8hOijaCTGxTu8dtN=w@mail.gmail.com>
	<20150519172254.GA27174@peff.net>
	<CAGZ79kbV8noD6v8mdc7vM4cONV_cvuLLt_ay14YSoFjQ3v4N0w@mail.gmail.com>
	<CAGZ79kaNWDB2qg2-x-+2ccV1hC7Y0K8TQVPQNkjMotggwsRRzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 19 19:34:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YulPJ-0008ME-5q
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 19:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbbESReO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 13:34:14 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35647 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbbESReJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 13:34:09 -0400
Received: by iesa3 with SMTP id a3so19591760ies.2
        for <git@vger.kernel.org>; Tue, 19 May 2015 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WQMNEecZQ8nmInzW2pAOGTYubEbkS/sBmfZr0nYZqTk=;
        b=EWWcSamunpChRIEqIKOzk2xsZjMmE1WYgPjLjBrICN8EP28+VC313f0IGOoifKzVA1
         tEuzFQtdm9ny/qLImJothyHEYTIL8LVAKll6YdFfk/zIavj6UBytpnhNq0mD5GsGISX0
         6RPOdnyHNuf5/Jge54KreBqi6IuA/zlRw9Kyh3IrgxWGkvu0Ii0PTYvb1rDDhj2XMmqd
         I5BWiX0GtqRgEGMeFFJ8xRlxQhZhmWhf60RMZqyrj0FzMtDMflq/x5nktsaUR4FPkOQ6
         P+818oBDPfBtDDpXdTdlRTjUze5MKrN2dcgOw4DN8mzZY75+/uNVSQnSb5nHupoI6XYc
         8D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WQMNEecZQ8nmInzW2pAOGTYubEbkS/sBmfZr0nYZqTk=;
        b=cRvUemGwdmkdbXOBl1lbIhdKVQmFQQAWFFlirWM+ZiwkGLiqjnAtAPrAPIcMjjCFBy
         idX2Rmdo19FHwpsZrnKZEYNcBYs2VY6zWucBK0GK+1aSXXSYWzHvEPOBbq12A2Btx+iD
         sAyIMupKDatAHZNHAec9oVM4kFZE47nb4PFk8ryQdR4G8TJy9jaeaY3r4hyPvdEoVQZ7
         YYXzAllF5gn/3flj1oLdfTHPOrwY3DGIZyEZKSnZc/c0wDkoJFVeogASmi00uEJdzeuC
         Vb2o2kRpr9M2m7ThzQgJdgKSQYrUTi24Y/A2kt6B4y4MmlNF46hr9RLfz2JP9DA4GUQL
         N82g==
X-Gm-Message-State: ALoCoQkYWo5pmuz9kiDkOjFdc6MQb8lBcleGJWODoGnFMtavkMfDaYtDXW69WJhwAQhZfRtWcWfT
X-Received: by 10.42.240.82 with SMTP id kz18mr28896814icb.92.1432056849109;
 Tue, 19 May 2015 10:34:09 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Tue, 19 May 2015 10:34:09 -0700 (PDT)
In-Reply-To: <CAGZ79kaNWDB2qg2-x-+2ccV1hC7Y0K8TQVPQNkjMotggwsRRzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269379>

On Tue, May 19, 2015 at 10:31 AM, Stefan Beller <sbeller@google.com> wrote:
> $ git bisect bad
> 383c3427afa3201eb05e931825c5c2f20616b58b is the first bad commit
> commit 383c3427afa3201eb05e931825c5c2f20616b58b
> Author: Eric Sunshine <sunshine@sunshineco.com>
> Date:   Mon May 4 03:25:14 2015 -0400
>
>     t1007: add hash-object --literally tests
>
>     git-hash-object learned a --literally option in 5ba9a93
>     (hash-object: add --literally option, 2014-09-11). Check that
>     --literally allows object creation with a bogus type, with two
>     type strings whose length is reasonably short and very long.
>
>     Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

When looking at the commit I don't think I found the right one.
So I went back to HEAD^ (being v2.1.0-243-g0c3db67), which
also tests bad now. Is there a way to force git bisect to change
good to bad?
