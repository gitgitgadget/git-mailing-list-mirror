From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: reflog/show question
Date: Wed, 30 Apr 2008 09:42:35 +0930
Message-ID: <93c3eada0804291712u19c1047bl6d44df4ca025bb4d@mail.gmail.com>
References: <93c3eada0804271859p1b4d8b52i811bdc5e42672822@mail.gmail.com>
	 <20080428092410.GD16153@sigill.intra.peff.net>
	 <93c3eada0804281847q267611aeke51b482cfbe100d6@mail.gmail.com>
	 <20080429201214.GB20509@sigill.intra.peff.net>
	 <93c3eada0804291506n7432b348p2b726926b5fc8f80@mail.gmail.com>
	 <20080429230715.GB22598@sigill.intra.peff.net>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11503_7258516.1209514355923"
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 02:13:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqzwu-00030I-Ga
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 02:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbYD3AMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 20:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755407AbYD3AMj
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 20:12:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:64244 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbYD3AMi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 20:12:38 -0400
Received: by fg-out-1718.google.com with SMTP id l27so201655fgb.17
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=GXOLzSbhEwRTsTj34Msr4y5XbvPrrSXcsX6F7gyF+cw=;
        b=wyss9q4AU5ZKO6Ayb6asDp0asJ9z/edBn/KrFOmJNstbba0xCwhd9lHgXwdk8LXy25z0ZuIjSa1nE0rtDb/DXoUB1osutjK2VxV0xTJTa/cmMDrx0Rcgtolkf+8nH1Iiopry0inqbWo75mDFS0e61hg0iMc0mMREPDsFUUm89L8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=FDi71BWKEtI3F78sqHuFpmAig8yVmVULGYMspPq5Mch5AJSybtyJnfhv5TawUCH4dqNQTxDnuFAXnIkkc+ld5Vt7lMZsnOpSS+5r3/DQof/iZkb1TTrME9I+UgPXTuupforgpNejwAhwGxitlbkR9qVJuze7nvGMTPBcv/+MI5A=
Received: by 10.82.189.9 with SMTP id m9mr6323buf.24.1209514355923;
        Tue, 29 Apr 2008 17:12:35 -0700 (PDT)
Received: by 10.82.105.8 with HTTP; Tue, 29 Apr 2008 17:12:35 -0700 (PDT)
In-Reply-To: <20080429230715.GB22598@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80772>

------=_Part_11503_7258516.1209514355923
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, Apr 30, 2008 at 8:37 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 30, 2008 at 07:36:23AM +0930, Geoff Russell wrote:
>
>  > > Hmm. Are you sure that the commit you got from HEAD@{"3 minutes ago"}
>  > >  actually _has_ the file data/node/node.data? If it doesn't, then you get
>  >
>
> > Later today (touch wood) I'll prepare as small a test case as
>  > possible, then send
>  > a tar.gz of the .git directory. Okay?
>
>  That would be great, thanks.

Attached is tar.gz of working directory (.) - so unpack in a new directory.

       git show HEAD@{"N seconds ago"}:data/node/.gitignore

works fine for values of N back to creationof file

But:

       git show HEAD@{"N seconds ago"}:data/node/node.newds1

doesn't work for any values of N.

During my attempts to create this example, I managed created a
directory which where
the show command failed for both files, but when I changed the commit
message, the
show worked for .gitignore but not the node file. Hence my suspicion
of that the slashes
in the path are being interpreted as requesting a commit message match ...?

I hope you can track it down, I will install the latest version of git
later on today to
confirm the behaviour is still happening.

Thanks,
Geoff Russell

>
>  -Peff
>



-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069

------=_Part_11503_7258516.1209514355923
Content-Type: application/x-gzip; name=gitdemo.tar.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ffn59ksi0
Content-Disposition: attachment; filename=gitdemo.tar.gz

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
GPo5ev1fGfj/v8oajDnD/9Mo9z/yxW//qfJXpZ986u731i499S/5z/9C+PTPP72lbP/Fm5mPf/u/
/vGZ5sevLH/5nf+4+YVX11//xjN//VsPv5f9Wln72f/+pa/uv/07f299zvyJH33sFfaXl15xf+Xt
L1/6yq+9eVZ5fXP+6//5mXf+9iNvXPnnH8zd/uO333zqf75l/ZQaft760vf/7YeXX/nuNxfufeeZ
135xrfI3O5X115//6FubjVd/WPjCS7+d+cTHnr36Y4e/8btvfav1zlvWJ37zu9/8cfXX//eNr5/z
Pvozv/pPd96qrXz/R99p/fm/vvmNh3/4en3vT776f39w9wf//vt/5FXNn3725ptf+r1P/8Pf3Xv6
z87YL77xy09auO+DMuj/9fdI/G/M8r9TKcP6XzJYeanZLBuaUa9Wqs3FZnmJMtAfNRb/v71zgYuq
2OP4AZRky2eZml3drEiUx5k5b5MiRZOXoqCU7znnzMH1Aou7S4KPEi21xCsW4iOtq6UfrZRCjSy7
V01LEAOVq5VdxUjTygdopfm496yCV3dvFyg4y9X5fj6w7MJnZnb+/H8785+Z/ygQs6LCMRKoTx21
6T/tmv8PAgBI/h9DSPeKKiocNIQeS1F+73qd8XRzCAbj6v9q09B/gSP3vxmCu/2BQCNOQKIoMDQn
y4qABCCpSMKcwgkSp/ISL0CtPnXUqv+sy/0fkBZ4ov+GUKP/UC3dtye/R4+Cvd94g3ZxNubstCRq
gnxHsqcbSGhUXP2fbRr6zwtE/w3B3f60PtjnNMwyCg/18T+WeQ4IgBcFxMucoiCWEZ23s9WD2vRf
l3tX/ed5QPTfCNK9egZExgylN9BjadaZin1w6a6YwICi6OD9UZ+XRO2KTkxPvXJn4tnWWw8Ht+rT
9TnrwQfPnV00y+fDvTllG7bvXfqyPDPR3nX3IUflkvUTC459WLW686zXzjUbFJ4wMjZnTPbw+JcX
Ry6tWlEmZ0+O7HjoJfsLeeOE2YfihooTj+57Y8F7i0/8Sj1zbtBsT3fDbYuL/9NiE9F/AIj+G4G7
/RURAkHSNI3GNI1UgCDmGY1hWEbCUIIAKVAGDTr+h5BxG/+T/T/GkO61cneUaRvdhoo9IO34sXnE
kkEj2gx2VGyb+5P3vhM5vkt8984fPabSNLo8tCigX2ZkwaMBxVsGPnjgWTUxIP7zXqdmCBv9YuYu
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
CAQCgUAg/H/xb5DnjcQAQAEA
------=_Part_11503_7258516.1209514355923--
