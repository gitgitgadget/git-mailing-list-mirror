From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: How can I specify the "sendmail" program for git-send-email?
Date: Mon, 11 Jun 2012 10:23:21 +0200
Message-ID: <CABPQNSbwtP0hp8QYznwXjLAaoKVj_ZUWXQQCDG80Xb+TME1MWw@mail.gmail.com>
References: <20120611073232.GA5602@richard>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Richard Yang <weiyang@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 10:24:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdzv7-0007x5-PK
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 10:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab2FKIYI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 04:24:08 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:63676 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab2FKIYG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 04:24:06 -0400
Received: by gglu4 with SMTP id u4so2295818ggl.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 01:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=MsRiYPP8H8EjWhXtGCnepyZq8RQVOjMlo8NjF0h2GY4=;
        b=JWwUSAzksmwvRL+7phTv55AHkkHzM0DsVGhDqf/6GMegfnETYi0SP7AqVptKewZEGH
         TEeUPbKjQ42Oxx1jTto0kqcKoCQp3ZBGWxyDJv3n8grmpW4XKpw4Ls11Ar8retYBfJ33
         GGuo9TMRCgaYCIJ8Y/KDfO7LHoPmwGvHhC30VO2DRyqr3cu5Hgj28RtYp+jz+YeNIiOD
         DhGDpKbMZL13Xd8X80iIemLo+en5AtdG4Sljknb8lnmeTDZQeh6tmI7gODt83lt5YagN
         zMIoBOet2lplIZhctFK3rIclKJGBzE7Hcp7eC0gxVySU9qXA29qinChZ0vPggf1tNmFM
         2tUQ==
Received: by 10.50.156.234 with SMTP id wh10mr5753307igb.20.1339403042580;
 Mon, 11 Jun 2012 01:24:02 -0700 (PDT)
Received: by 10.231.108.201 with HTTP; Mon, 11 Jun 2012 01:23:21 -0700 (PDT)
In-Reply-To: <20120611073232.GA5602@richard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199631>

On Mon, Jun 11, 2012 at 9:32 AM, Richard Yang
<weiyang@linux.vnet.ibm.com> wrote:
> Hi, experts
>
> I read the git-send-email manual and find the --smtp-server option ca=
n
> specify the sendmail-like program to send mail.
>
> Then I use this option in command line
> --smtp-server=3D/usr/bin/msmtp
> This works.
>
> While I found it not very convenient to write the option on command l=
ine
> every time, then I wrote it in the .gitconfig file in my home directo=
ry.
>
> [sendmail]
> =A0 =A0 =A0 =A0smtpserver =3D /usr/bin/msmtp
> =A0 =A0 =A0 =A0smtppass =A0 =A0 =A0 =3D 123456
> =A0 =A0 =A0 =A0smtpuser =A0 =A0 =A0 =3D weiyang@linux.vnet.ibm.com
> =A0 =A0 =A0 =A0smtpserverport =3D 143

The configuration-section for git send-mail is actually spelled
"sendemail", and not "sendmail". Notice the additional 'e'.

http://git-scm.com/docs/git-send-email
