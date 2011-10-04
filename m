From: John Szakmeister <john@szakmeister.net>
Subject: Re: Unable to remove a file
Date: Tue, 4 Oct 2011 06:24:38 -0400
Message-ID: <CAEBDL5U4gU9C0De42Sgqv1ODLwQBuOdYdhfTBCMUziCZrhK9dA@mail.gmail.com>
References: <CAAZ43xa2upWQ2LWJRVcOPew3kF0W7gSz9UgQ=g0gnMHKQB3Y4A@mail.gmail.com>
	<m262k6jc2c.fsf@igel.home>
	<CAAZ43xa43YjO7Vqw87cYnXhJWvsZT_ocPpLuJ81jCPc8KKRczw@mail.gmail.com>
	<4E8ABC85.7090705@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: robert mena <robert.mena@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Oct 04 12:24:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB2B3-0001Dk-0U
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 12:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810Ab1JDKYk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 06:24:40 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59400 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab1JDKYj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 06:24:39 -0400
Received: by vcbfk10 with SMTP id fk10so197737vcb.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7tR8+eYVsNz/79hl89Qm8VeSJgCGD7H3w/FM/Wxu6ME=;
        b=DFyRPewCxJyNlXk+ACqYKK414C9bL3RPLgJDEzrE0LcZ16Fx7NmT/x+oAwx3o743Vm
         qA8iy8yqImF83Nmb0jIcQPO16WwJ11yt0H00QGUZ6kRr0jSzLWwDesgIMzq6oD2OK1AD
         TjRlznLfkdUoJZGiO76Mz0QnXLFZLLnCfGZZg=
Received: by 10.52.108.68 with SMTP id hi4mr847946vdb.385.1317723878497; Tue,
 04 Oct 2011 03:24:38 -0700 (PDT)
Received: by 10.220.181.2 with HTTP; Tue, 4 Oct 2011 03:24:38 -0700 (PDT)
In-Reply-To: <4E8ABC85.7090705@in.waw.pl>
X-Google-Sender-Auth: ThEIrL5wvpsXldfF1KEC8bMOkEc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182753>

2011/10/4 Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>:
[snip]
>> git filter-branch --index-filter 'git rm -q --ignore-unmatch --cache=
d
>> scripts/\\' HEAD
>> Rewrite 5ac83187fa298add60cf81fd1d54b194da7ae783 (57/57)
>> Ref 'refs/heads/master' was rewritten
>> git push
>> =C2=A0! [rejected] =C2=A0 =C2=A0 =C2=A0 =C2=A0master -> =C2=A0master=
 (non-fast-forward)
>> error: failed to push some refs to 'git@myserver:repository'
>>
>> Should I do anything special?
>
> git push -f

I assume you understand that you're rewriting history Robert, and that
has some consequences?  You're master branch is now divergent, since
the commit ids changed.

-John
