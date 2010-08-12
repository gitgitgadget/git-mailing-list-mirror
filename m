From: Jonathan Nieder <jrnieder@gmail.com>
Subject: jn/commit-no-change-wo-status (Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Wed, 11 Aug 2010 22:15:08 -0500
Message-ID: <20100812031508.GC19174@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <20100812014107.GA18937@burratino>
 <AANLkTi=5biMga0=nAVwQLNd1jEJXXtUJBqdhuyt-YoWv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bo Yang <struggleyb.nku@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 05:16:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjOHa-0006Pq-OH
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 05:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759076Ab0HLDQi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 23:16:38 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59806 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758254Ab0HLDQh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 23:16:37 -0400
Received: by yxg6 with SMTP id 6so252985yxg.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 20:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qvSyM6/ZR48ry2tE1pgysvpPOaPLcuRV3St1ZRHIsJE=;
        b=jxBX8F1553CjZ4l0GKZ6q1xjWhe1WYpukJqSVXtLag1S0YUqFpOek1MCgmm3X4Wper
         p3KhToCFjayz2WxftP+Utb1D3DDpe96NfMeruBo9POfkIYPdPVFU5bGz8cZ+bojKvM8e
         yxakz15YenI4cev9yJ7e0b3QYBLaPtez5Eqi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sPunAYJCXZZsA0xz7scMcm6CspE3AFqZ1xxxM5ufz3gOMvkC04HyN9ibhdQWZ5PEaS
         gsK5c3CQKyB/T2ZgWJvdXNnMHWjWuvmNhM3bTeyCiDk92zo3O+hpOzENhpBbW7NOgFdd
         qL66HrSwBr8QtuKhxUNgDI5siu4LqDeSdMR0Q=
Received: by 10.101.173.21 with SMTP id a21mr22770101anp.63.1281582996476;
        Wed, 11 Aug 2010 20:16:36 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id a12sm1281955and.36.2010.08.11.20.16.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 20:16:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=5biMga0=nAVwQLNd1jEJXXtUJBqdhuyt-YoWv@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153331>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> But I don't know, the "git commit" output doesn't confuse me so I'm
> not in the target audience.

=46or what it=E2=80=99s worth, I had three scenarios in mind:

Getting started
---------------

One way to learn a program is to just try things.  Some people take
this practice to an extreme and unforunately (1) would expect =E2=80=9C=
git
commit=E2=80=9D to do the same thing as =E2=80=9Ccvs commit=E2=80=9D an=
d (2) would not want to
read a manual or a long stream of text when it does not do so.

I hope we can streamline that process somehow, for example by
starting the output with the error message:

 $ git commit
 fatal: no changes added to commit
 hint: use 'git add' and 'git reset' to update what will be committed
 hint: you have 37 untracked files; use 'git status' to list them

24-line terminal
----------------

When I forget to stage changes, the previous output in the terminal=E2=80=
=99s
scrollback buffer may give a reminder of what those changes were.
The current =E2=80=9Cgit status=E2=80=9D output makes that information =
harder to find.

=46or the same reason, I basically never use git status without -s.
Before status --short existed, I used diff-files and ls-files -o.
Now I generally use =E2=80=9Cadd -u=E2=80=9D, =E2=80=9Cdiff --cached=E2=
=80=9D, and =E2=80=9Cadd/reset -p=E2=80=9D.

Need reminder of changes
------------------------

Some people forget where they are and would be confused if =E2=80=9Cgit
commit=E2=80=9D just failed without explaining why.  They need an indic=
ation
of what just happened and what they need to try to do to fix it up.

=46or such people, the existing output is fine.  With a successful
series, the new output would also be fine, and running =E2=80=9Cgit che=
ckout=E2=80=9D
or =E2=80=9Cgit status=E2=80=9D would seem the most natural thing in th=
e world rather
than an imposition.

Hope that helps.
Jonathan
