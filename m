From: robert mena <robert.mena@gmail.com>
Subject: Re: Unable to remove a file
Date: Tue, 4 Oct 2011 07:36:05 -0400
Message-ID: <CAAZ43xZo8cyE_ASz1Hc4yYoUjmH1OnVogOj6mtqFzmAUSBptFw@mail.gmail.com>
References: <CAAZ43xa2upWQ2LWJRVcOPew3kF0W7gSz9UgQ=g0gnMHKQB3Y4A@mail.gmail.com>
	<m262k6jc2c.fsf@igel.home>
	<CAAZ43xa43YjO7Vqw87cYnXhJWvsZT_ocPpLuJ81jCPc8KKRczw@mail.gmail.com>
	<4E8ABC85.7090705@in.waw.pl>
	<CAEBDL5U4gU9C0De42Sgqv1ODLwQBuOdYdhfTBCMUziCZrhK9dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski=2DSzmek?= 
	<zbyszek@in.waw.pl>, Andreas Schwab <schwab@linux-m68k.org>,
	git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 13:36:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB3IE-0000SY-9B
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 13:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107Ab1JDLgI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 07:36:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57844 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764Ab1JDLgH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 07:36:07 -0400
Received: by ywb5 with SMTP id 5so361577ywb.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QzgSeuMfUtqcV4O9GzVIF1EmjOqB9I8XI7/NMZBH8KU=;
        b=NKWa8zv6JdFnKRi5XuTdKH6LnXsrJG4fuq/TJYuJVK4a7R7Zj8HReDa2z7ybrr0BeX
         dqKLXLRyqXbasiIbxDgtUzDAkh/9BQPEvPywg8+LpEnyAYUWs0zLlKOPBkeJr0yXpP0l
         +4rN501rwbqgl6Lo+TgOH3XI+soZ6x628Pbek=
Received: by 10.223.36.68 with SMTP id s4mr1589001fad.92.1317728165724; Tue,
 04 Oct 2011 04:36:05 -0700 (PDT)
Received: by 10.223.104.66 with HTTP; Tue, 4 Oct 2011 04:36:05 -0700 (PDT)
In-Reply-To: <CAEBDL5U4gU9C0De42Sgqv1ODLwQBuOdYdhfTBCMUziCZrhK9dA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182763>

Hi John,

I understand that.   For the other that have cloned the repository in
the past (no one has committed anything locally) is there any special
procedure to be performed or a simply git fetch/pull will make their
local repositories in sync?

2011/10/4 John Szakmeister <john@szakmeister.net>:
> 2011/10/4 Zbigniew J=EAdrzejewski-Szmek <zbyszek@in.waw.pl>:
> [snip]
>>> git filter-branch --index-filter 'git rm -q --ignore-unmatch --cach=
ed
>>> scripts/\\' HEAD
>>> Rewrite 5ac83187fa298add60cf81fd1d54b194da7ae783 (57/57)
>>> Ref 'refs/heads/master' was rewritten
>>> git push
>>> =A0! [rejected] =A0 =A0 =A0 =A0master -> =A0master (non-fast-forwar=
d)
>>> error: failed to push some refs to 'git@myserver:repository'
>>>
>>> Should I do anything special?
>>
>> git push -f
>
> I assume you understand that you're rewriting history Robert, and tha=
t
> has some consequences? =A0You're master branch is now divergent, sinc=
e
> the commit ids changed.
>
> -John
>
