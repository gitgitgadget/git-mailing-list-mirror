From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Bug! Git merge also fails with a wrong error message
Date: Fri, 13 Jan 2012 11:34:29 -0800 (PST)
Message-ID: <m3mx9re6t0.fsf@localhost.localdomain>
References: <loom.20120112T193624-86@post.gmane.org>
	<loom.20120113T181805-423@post.gmane.org>
	<20120113175617.GE2850@centaur.lab.cmartin.tk>
	<4F107F16.30009@unclassified.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?b?Q2FybG9zIE1hcnTDrW4gTg==?= =?utf-8?b?aWV0bw==?= 
	<cmn@elego.de>, git@vger.kernel.org
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Fri Jan 13 20:34:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlmtY-0002CJ-Tr
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 20:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab2AMTec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 14:34:32 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35464 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab2AMTeb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2012 14:34:31 -0500
Received: by eaal12 with SMTP id l12so299441eaa.19
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 11:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=bhtKtpAwrxxdJiV4pYGQcGRg0uf13ohFT5TI7/YOJhk=;
        b=pjCVXxzQhBxZ0nXIw/WVqYxJ7oTSzT7wz6k6g7yYbc7GZIgu25VeJZalgcCZwJrTez
         Brfa9s308E2rRPW9na4QohNhz6KzLlFHt3LZymKMfAZMmXxEAa/RCfkJLimmcZ1tZxAF
         RO6CoP0d6t8lOl/wKoY6rq9B4zyW/N7NXS7ww=
Received: by 10.213.34.2 with SMTP id j2mr282733ebd.21.1326483270101;
        Fri, 13 Jan 2012 11:34:30 -0800 (PST)
Received: from localhost.localdomain (abwn18.neoplus.adsl.tpnet.pl. [83.8.237.18])
        by mx.google.com with ESMTPS id y12sm33289373eeb.11.2012.01.13.11.34.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 Jan 2012 11:34:29 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q0DJXsUV003321;
	Fri, 13 Jan 2012 20:34:04 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q0DJXWUU003316;
	Fri, 13 Jan 2012 20:33:32 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4F107F16.30009@unclassified.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188533>

Yves Goergen <nospam.list@unclassified.de> writes:
> On 13.01.2012 18:56 CE(S)T, Carlos Mart=C3=ADn Nieto wrote:
=20
> > Gmane is a mailing list viewer and there /only/ is the real maling
> > list. The e-mail you provided for yourself looks bogus, but if it
> > isn't, you'll notice we communicate via e-mail.
>=20
> Well, I am very confused. Starting from git-scm.com, the only support
> site is a mailing list, and the hyperlink on that word sends me to Gm=
ane
> which says I am in a newsgroup called "gmane.comp.version-control.git=
".

Note however that the _text_ of the hyperlink is

  git@vger.kernel.org mailing list

> Since I don't have access to the news system, I need to use the Gmane
> website. I don't know exactly what it is.

GMane is an e-mail to news gateway, and a mailing list archive. It
exposes mailing list as a newsgroup, so it can be read and written to
via newsreader (via Usenet).

Perhaps better solution would be to use mailto:git@vger.kernel.org
link, and add a sentence about archives / alternative interfaces.

>                                  I know mailing lists, but that
> doesn't look like one at all. There's not even a subscription page or
> address.=20

git@vger.kernel.org is a public non-subscribe mailing list; you don't
need to subscribe to post requests there.  Note that it is a custom on
this mailing list to always include all participants in given
(sub)thread directly in Cc, so you should get responses to your emails
even if you are not subscribed.

[...]
> So am I now subscribed to that "git@vger.kernel.org" mailing list and=
 do
> my posts show up there? I have no idea what's going on, neither in my
> repository, nor in this mailing list. Confusing and non-transparent.

If you send email to git@vger.kernel.org, it would also appear on
GMane.

--=20
Jakub Narebski
