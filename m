From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Restoring timestamps (Re: Branches & directories)
Date: Mon, 22 Aug 2011 15:33:03 -0700
Message-ID: <CAE1pOi1+nnpnHAuhYsXcfFNUroW0JcDQKLu6D7YNrUwJg0tXPw@mail.gmail.com>
References: <CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com>
	<CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com>
	<CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
	<CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
	<CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
	<CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
	<CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
	<CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
	<CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
	<20110822210141.GA3880@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 00:33:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvd3P-00087g-Fz
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 00:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100Ab1HVWdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Aug 2011 18:33:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59423 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007Ab1HVWdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2011 18:33:04 -0400
Received: by gya6 with SMTP id 6so3924963gya.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1jxRla5lQVOw9A4unYFzaR+OdBS6UTzHSURRs4M/ga0=;
        b=DuDmtDNcQuROBm3BCOUPN0YUnzVvApfKTK1FIUtUNiDYnoHs+bDH1MtIJEKPwEvdIH
         5k8d7gtg9eJMuDqMZ4ml0tqBN7YxDVdS8aH7jxxK3+MSt6gzc/jdpzftBvIMR06SND2B
         NpRDyMk/WytGI+9+NUzqxqO0M45tNgjH4H9jM=
Received: by 10.236.145.1 with SMTP id o1mr18754911yhj.119.1314052383569; Mon,
 22 Aug 2011 15:33:03 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Mon, 22 Aug 2011 15:33:03 -0700 (PDT)
In-Reply-To: <20110822210141.GA3880@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179898>

On 22 August 2011 14:01, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hilco Wijbenga wrote:
>> On 22 August 2011 12:31, Kyle Moffett <kyle@moffetthome.net> wrote:
>
>>> (1) The GIT data-structures simply have no place for file timestamp=
s, and
>>> "git stash" is simply a special way of dumping files into a tempora=
ry commit.
>>
>> That's what I thought. The "intentionally" threw me off. It's not
>> intentional, it's just a side effect.
>
> For what it's worth: no, it's intentional. =C2=A0See, for example:
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/1564/foc=
us=3D1680
> =C2=A0https://git.wiki.kernel.org/index.php/GitFaq#Why_isn.27t_Git_pr=
eserving_modification_time_on_files.3F

After I had sent the above I realized it was worded a bit too strong.

> That said, something being intentional does not necessarily mean it i=
s
> always _right_. =C2=A0So, for example, patches to allow a commit to s=
tore
> some timestamps, with documentation explaining when this is
> appropriate, would probably be welcome. =C2=A0Maybe a good place to s=
tore
> such information would be a dotfile alongside the file (so old,
> unaware git versions could extract the same information without fuss)=
=2E

You mean an extra dotfile per file in the commit?

> Even if this feature were implemented just for "git stash", personall=
y
> I would turn it off so "make" could continue to behave as I expect it
> to. =C2=A0But in principle, I don't mind the idea of it existing. :)

Given that apparently the majority of Git users don't want/need this,
it should probably be off by default. So you would not even need to
turn it off. :-)

In fact, I would not want it on by default either. It's really only
useful when switching branches when I want to keep the exact state of
the branch.
