From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] Documentation/remote-helpers: Add invocation section
Date: Wed, 31 Mar 2010 01:45:30 +0530
Message-ID: <f3271551003301315i4bee002dm572e179819dbb1cd@mail.gmail.com>
References: <f3271551003300947u4c7c2a83q13aaf786140bfa37@mail.gmail.com> 
	<20100330183748.GA10647@progeny.tock> <f3271551003301217h44c99d5bye4a614840661b05c@mail.gmail.com> 
	<20100330201007.GA26121@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Mar 30 22:15:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwhqv-0002vO-8W
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 22:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab0C3UPv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 16:15:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60198 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab0C3UPv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 16:15:51 -0400
Received: by gwaa18 with SMTP id a18so4902270gwa.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BbN1EYpWdLm5SLzZuJnfM5rCaugIIDZvlPoJP81aonw=;
        b=CGxys3qrLxa2IEhfq3W6Zc4Ggf5k/eKYnhuksK87RR7N5/K5EEWVDkdFy5SQft6e/R
         6Ak/ajAY9WwOjxHvlerjaxdgwknP/LgmQ29DWZ8HpwbEMAzewGvLuYEqBGyvKb/qSlp6
         IZp2WMHX2wfnTOD2ZYX1CbzIJ5dumnp4qmmus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dgnU4c1NJmG3/cz+HzVABJtlOFh0o2rTK2XogkvT8WCv24vlFmttiHjEm4PGFjZ+1t
         8IJ+Hrco34kSSYgmC967qxSe2X6asydj87G8Gef5MWIKO9lafCEpHwUiYK2YrA42rOHB
         lryoL7ngx3WIBFs30fvXSDohxRGjZCh0EqLMk=
Received: by 10.90.69.14 with HTTP; Tue, 30 Mar 2010 13:15:30 -0700 (PDT)
In-Reply-To: <20100330201007.GA26121@LK-Perkele-V2.elisa-laajakaista.fi>
Received: by 10.91.18.1 with SMTP id v1mr5214044agi.95.1269980150129; Tue, 30 
	Mar 2010 13:15:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143599>

Hi,

On Wed, Mar 31, 2010 at 1:20 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> A hypothetical =91git remote-svn=92 would not need to examine its fir=
st
> argument at all, unless it wants to use it to name a store of additio=
nal
> per-remote data. =A0From its perspective, the second argument is not =
to
> disambiguate. =A0Instead, the second argument is all that matters.

Right. I'll try to reword this last part.

On Wed, Mar 31, 2010 at 1:40 AM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> 'tls://srp-Ilari@[1067a6e3af81b5ea76d615280eee2bc3dd2e8079@tcp/ipv6~f=
e80::20e:a6ff:fe6f:2288%2]:7684/gitolite-admin'

On Wed, Mar 31, 2010 at 1:29 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> What I meant by "arbitrary string" is that it doesn=92t have to have =
the
> form schema://path, it=92s not restricted to a particular character s=
et,
> it doesn=92t have to avoid conflicting with meaningful URLs defined b=
y
> other helpers, and so on. =A0So it=92s a resource locator but not ver=
y
> uniform.

Well, we're trying to document all these "urls" in urls.txt [1]. I
should perhaps use the term "URL recognized by Git" and include a link
to the urls page in the documentation?

[1] http://thread.gmane.org/gmane.comp.version-control.git/143499
