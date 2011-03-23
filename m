From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Wed, 23 Mar 2011 11:32:18 +0100
Message-ID: <AANLkTikLHRkE6aapS00q=4=4FSzjY1XQQQp=pRu12yP3@mail.gmail.com>
References: <4D871972.7080008@elegosoft.com> <7vhbawno11.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1103212302000.1561@bonsai2> <7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
 <20110322085027.GF14520@neumann> <AANLkTi=zbsNxLSCcWQorZCnRFuDPujqYzW7B0xJx2FHp@mail.gmail.com>
 <20110322100903.GG14520@neumann> <AANLkTik8BaAJCnCRdDNTdu=nV1Q7cFLiwOuV_4wdXUE6@mail.gmail.com>
 <20110322202518.GA30604@neumann>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, lee.marlow@gmail.com,
	markus.heidelberg@web.de, spearce@spearce.org, bebarino@gmail.com,
	ted@tedpavlic.com, tlikonen@iki.fi, trast@student.ethz.ch
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2LMu-0000mJ-2h
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 11:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259Ab1CWKcp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 06:32:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59533 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242Ab1CWKco convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 06:32:44 -0400
Received: by fxm17 with SMTP id 17so7195569fxm.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 03:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vM4bCnhb9R6+cewQVG2TdlkbHFCLaulETSPLPGJEDXM=;
        b=sMVIC6Yavwli0ZUG9voyG3M0Gpilgvw2IbkEs8gHmQhwX4LD0mmMFJwWjIVnACDzam
         vfiZbuR32qnSaIp1HfaXbyiPIEakC9Z6OiIGNO4JeQbVSlE5V+SwyN3ct8ujrorRwYm7
         bGXoMKkMolLnnegiTgB9Z0bTW9kRsKMycAU2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=qBsE8vTGu7IsUUxK9lfBscUdtqJfSGw5SFxVsiXkfzQkoDydhrC4F9WHy5U+5aKSkB
         VCa8fh5Xn7j8VGuAe4CTT70A0VioMvTVV9LycVIh9N/d1nguOCwqcLB5UuAAaLbMjhaa
         f09ccN3/Fjy3YO0sa3l+jy/yzfUGBtFazxwNg=
Received: by 10.223.26.205 with SMTP id f13mr3016468fac.49.1300876361428; Wed,
 23 Mar 2011 03:32:41 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Wed, 23 Mar 2011 03:32:18 -0700 (PDT)
In-Reply-To: <20110322202518.GA30604@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169812>

2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
> On Tue, Mar 22, 2011 at 11:28:01AM +0100, Erik Faye-Lund wrote:
>> 2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
>> > The question is whether the slowness of a known slow platform woul=
d
>> > justify the regression on all platforms.
>> >
>>
>> Windows isn't slow. Get over this way of thinking, it's just wrong.
>> Windows has some different performance characteristics for some
>> operations than e.g Linux, but saying that it's slow is just wrong.
>> However, _Bash for Windows_ is quite slow, much due to Windows' lack
>> of fork(), which means that some very involved emulation needs to be
>> performed.
>
> I meant the above only in the context of git, based on my last -- it
> seems outdated -- experiences with msysgit about (more than?) a year
> ago, when I found such builtins like commit and checkout to be quite
> noticeably slow. =A0I'm glad to hear that things are changing for goo=
d.

Actually, the situation isn't all that good, but it's mostly
git-completion.bash's fault:

$ time __git_ps1 "%s"
build-vbcc
real    0m0.162s
user    0m0.045s
sys     0m0.000s

150+ ms just to assemble what branch you're on does very much makes
things feel laggy. This affects even when yo just press enter.

This is especially annoying when just doing the meat of it directly is
way cheaper:
$ time git branch --no-color
* master

real    0m0.036s
user    0m0.016s
sys     0m0.000s

git commit in itself isn't that bad either:
$ time git commit --allow-empty -m.
[master 8d8d75e] .

real    0m0.051s
user    0m0.000s
sys     0m0.015s

50 ms for something that actually does something isn't that bad. And
if it adds a non-empty commit, it's still OK:
$ echo "foo" > test.txt
$ git add test.txt
warning: LF will be replaced by CRLF in test.txt.
The file will have its original line endings in your working directory.
$ time git commit -m "bar"
[master 641c50e] bar
warning: LF will be replaced by CRLF in test.txt.
The file will have its original line endings in your working directory.
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 test.txt

real    0m0.065s
user    0m0.015s
sys     0m0.015s

>> But even so, at least 25% of the git user base is on Windows,
>> according to the latest Git User Survey. That makes this stuff matte=
r.
>
> The other point of view is that it will cause a regression without a
> compensating benefit for maybe more than 75% of the user base ;)
>

I don't think a minor regression like not getting bash-completion
automatically updated (something that only affects interactive use
after adding a new alias, and probably also could be fixed by adding a
/tmp/git-completion.dirty.shell-pid file or something) should justify
degrading performance for an as large portion of users as the Windows
users are.

(Warning: speculation ahead)
Also, I suspect the numbers of Windows developers are
underrepresented, for two reasons;
- I suspect that Windows developers are less likely to be subscribed
to the mailing lists where the Git User Survey are promoted.
- I suspect that most Windows users use EITHER Cygwin OR MinGW, but I
intentionally picked the largest of the Windows categories instead of
adding them up because the Git User Survey allowed people to answer
both MinGW and Cygwin.

User Survey people, if your read this: please have a separate
operating system question next year. It's very valuable information!
