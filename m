From: "Joel C. Salomon" <joelcsalomon@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Fri, 6 Aug 2010 11:29:23 -0400
Message-ID: <AANLkTik2fem_=vN1J52z+QqtCamxNhHAVeG1jxrbSCba@mail.gmail.com>
References: <i372v0$3np$1@dough.gmane.org>
	<AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>
	<4C599781.2020603@gmail.com>
	<4C5B2F2E.4050709@gmail.com>
	<AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com>
	<AANLkTikJP2d5_pA+RcQeToE+RGW0oBhcZyghLfqDoJ8E@mail.gmail.com>
	<AANLkTinXtjn7=9jRNmv4zhhPiy3NVOca0gY9dkYCUhY7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 17:29:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhOra-0002Ja-CB
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 17:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761445Ab0HFP33 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 11:29:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50171 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756578Ab0HFP3Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 11:29:25 -0400
Received: by bwz3 with SMTP id 3so52245bwz.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0sUDOjEujqo8lbXhEYwPy2UJdncWBmf+D6TLi0AkXOU=;
        b=a7EC9bfOFxiSoFVkh0cT0v5OYG4BcCcHxGiNzQG2PYz7xhjXubGq5iGakhIahp72Wt
         aFKw8PKttrNXkQQyxCst9en0nbU/kQjt1T6VOmdyazZvbL0OJ0SGuZjb7q2gi7V4slLP
         a68/u7adxlWSNSznPJxz46c1ZmiZnirGy354I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SBYTOoEcBoU4ISaghtDMmxwp5qRkGog+YSBT+PDXugx7a4ggJ/V26rdICouoSoIfrl
         0YcOdUtfeZOPtdk+XgNZMKBBIUKUWT6Emte5ANOTU9f6zusuyWOElHe8eXgBHUfCSFoF
         MotjvrzymS7QhiFWVUSiB7ExxEl3yd0uFlA2Q=
Received: by 10.204.59.136 with SMTP id l8mr215042bkh.84.1281108564009; Fri, 
	06 Aug 2010 08:29:24 -0700 (PDT)
Received: by 10.204.140.197 with HTTP; Fri, 6 Aug 2010 08:29:23 -0700 (PDT)
In-Reply-To: <AANLkTinXtjn7=9jRNmv4zhhPiy3NVOca0gY9dkYCUhY7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152790>

On Fri, Aug 6, 2010 at 11:19 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Aug 6, 2010 at 15:18, Joel C. Salomon <joelcsalomon@gmail.com=
> wrote:
>> Can you check what git-fsck has to say about the repos, on 32- &
>> 64-bit machines?
>
> 32bit says:
>
> =C2=A0 =C2=A0error in commit 826a4f7721fe1c3963a733ecbc5422f05925af5d=
: invalid
> author/committer line
>
> 64 bit doesn't give any warning at all.

Meanwhile, on Fri, Aug 6, 2010 at 11:08 AM, Sverre Rabbelier
<srabbelier@gmail.com> wrote:
> On Fri, Aug 6, 2010 at 03:18, Jakub Narebski <jnareb@gmail.com> wrote=
:
>> We can *store* it without problems, the problem is with
>> *interpretation* by porcelain (and some plumbing).
>
> That's what I mean though, if the porcelain notices it's trying to
> read in a date it can't interpret correctly it should warn the user o=
f
> this fact.

Seems the error can be checked for when you ask, but I'd rather not
have git complain every time I use constitution.git.

Aside: I generated the time stamps with
<http://github.com/schwern/y2038>,  which may be useful for
cross-platform y2038 fixes.

--Joel
