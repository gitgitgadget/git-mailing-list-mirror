From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Trouble merging renamed but identical files - CONFLICT (rename/rename)
Date: Sun, 29 Jun 2014 11:31:06 -0400
Message-ID: <CABURp0okCDbwLOL3Osj2WtfQ_Qj3v=1FrAV28gJjPy1yzQU7Vg@mail.gmail.com>
References: <CABURp0rFCxxpiQhRYXmN5eBnKhyyOeuFSTj0V1tGZJSNea5iEA@mail.gmail.com>
 <66A60DA77398CD439FA676CEF593977D52477A@exchange.1.internal.pdinc.us> <CEAC9BE9F83B4CD0AFD73BBAC8A54232@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Sun Jun 29 17:31:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1H4m-0002Ry-4A
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 17:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbaF2Pb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 11:31:28 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:64151 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbaF2Pb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 11:31:27 -0400
Received: by mail-vc0-f170.google.com with SMTP id hy10so6640202vcb.29
        for <git@vger.kernel.org>; Sun, 29 Jun 2014 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3wNE1udcYBmRSA91rcKxXGztWzkgMlIzRgzAniWBMgc=;
        b=eCnJ5fWN0P3ZX6G8YHWqkEj0JRqejJJApDrqK+Mxcq3DXeZnCmWORxaoGWSnZCNvz6
         J7wp1I941/j8PFcWICbQeNQRo4ofN6hRPOandGs6tqDTvFaf9WHtpobzrIRygJkOaCud
         7FqU//P4Y2sQtExKosh1ks11XW4ddzldTyntpMpq2yDMzRBFMt/UnZnRwNj5bNoarcxn
         Y6oTN68YVVU7ESg1v7PYIKsDcwS5y0HbUt50m93W0DzeiN5xwOFACufXYYhmI6bGdboV
         AnR9SQyheGADQGec7Q8ELDONwi/Sokto4PZZK3cmugrhjMWmNPjjWty60CiFfXdUoGYl
         ZysQ==
X-Received: by 10.52.96.8 with SMTP id do8mr27344262vdb.4.1404055886997; Sun,
 29 Jun 2014 08:31:26 -0700 (PDT)
Received: by 10.58.67.168 with HTTP; Sun, 29 Jun 2014 08:31:06 -0700 (PDT)
In-Reply-To: <CEAC9BE9F83B4CD0AFD73BBAC8A54232@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252644>

On Fri, Jun 27, 2014 at 8:42 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
> Sorry for the http://pastebin.com/1R68v6jt (changes the merge to
> 1ca13ed2271d60ba93d40bcc8db17ced8545f172, and manually reconciles the merge),
> but it was too long to be readable in the email.
>
> git blame HEAD -- src/Main/Forms/CipherShed.fbp | cut -c 1-8 | sort -u
>
> Gives:
> ac812aa3
> b50a2fb1
>
> git blame b60070f4d0879e277f44d174a163bbb292325fea --
> src/Main/Forms/TrueCrypt.fbp | cut -c 1-8 | sort -u
>
> Gives:
> 07b2176f
> 0eb8b4fa
> 12c94add
> a17c95a3
> a757b4d4
> cac6cd14
> d0a9dfa8
> d94128a9
> e6b1437a
> f1bb489c
>
> If I use cherry pick (vs merge), I can maintain the big history in b60070f, but
> loose the small history in 1ca13ed
>
>       [test]
>       /     \
>      /       \
> [b60070f] [1ca13ed]
>     |         |
>     |         |
> [65efd37]     |
>     |    \    |
>     |     \   |
> [d8da778] [39ebb06]
>
> How do I maintain all the history including the (line) changes in 1ca13ed?

I see the results, but my brain is not able to make sense of your goal
yet.  I'll try again later when I've had my coffee.
