From: "Dennis" <dennisfm@friendlymatch.com>
Subject: Re: Setting up Git Server over SSH
Date: Tue, 16 Nov 2010 21:25:43 -0500
Message-ID: <FA103D605D674AA388413F9C31489E47@denny>
References: <B99C7057496B47E48E5ABED7DE6BA51A@denny><AANLkTimF2N-rYFYjOMm5kRRqRueLnmzJGpUoaCK3jsAC@mail.gmail.com><E698106BE2EB405A93D2C3304AF79529@denny> <AANLkTimTcnTLLsiLAQZn2EiswB_NAfwru6PX1Vw-kFUW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn Pearce" <spearce@spearce.org>, <git@vger.kernel.org>
To: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 03:26:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIXip-0008Ny-DC
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 03:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870Ab0KQC0A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Nov 2010 21:26:00 -0500
Received: from fmailhost06.isp.att.net ([204.127.217.106]:39073 "EHLO
	fmailhost06.isp.att.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571Ab0KQC0A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 21:26:00 -0500
DKIM-Signature: v=1; q=dns/txt; d=ameritech.net; s=dkim01;
      i=dennismv@ameritech.net; a=rsa-sha256; c=relaxed/relaxed;
      t=1289960759; h=Content-Transfer-Encoding:Content-Type:
     MIME-Version:Date:Subject:References:Cc:To:From:Message-ID; bh=
     Xp6DitUbB+RDmh4M7qWqnQUextWS2DL6rZyydRTrZAc=; b=k5ird509HS/z6Ez8o4u
     ZZdCTLdXdNLGJjbJ2dm8exscUZjx+99iLqwd+DnxdEKfynXbV8zZCoHXGca/5aNuutQ
     ==
Received: from denny (d118-75-134-244.clv.wideopenwest.com[75.118.244.134])
          by isp.att.net (frfwmhc06) with SMTP
          id <20101117022550H0600lqe6he>; Wed, 17 Nov 2010 02:25:51 +0000
X-Originating-IP: [75.118.244.134]
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161594>

I reinstalled git package with putty and it worked okay this time.
It did print this line though before normal output:
stdin: is not a tty
remote: Counting objects: 1194, done.
=2E..

I tweaked bash setting and it did not seem to do anything.  But then I =
am on=20
Windows XP, so not sure if it will work the same way or if I edited the=
=20
right file.

Dennis


----- Original Message -----=20
=46rom: "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason" <avarab@gmail.com>
To: "Dennis" <dennisfm@friendlymatch.com>
Cc: "Shawn Pearce" <spearce@spearce.org>; <git@vger.kernel.org>
Sent: Tuesday, November 16, 2010 5:46 AM
Subject: Re: Setting up Git Server over SSH


> On Mon, Nov 15, 2010 at 20:14, Dennis <dennisfm@friendlymatch.com> wr=
ote:
>> I used OpenSSH instead of Putty
>> and that fixed things up.
>
> Does using Putty with this at the top of your .bashrc fix it too:
>
>    if [[ $- !=3D *i* ]] ; then
>        # Shell is non-interactive.  Be done now!
>        return
>    fi
>
> ?=20
