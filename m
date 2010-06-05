From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #01; Wed, 2)
Date: Sun, 6 Jun 2010 01:57:24 +0200
Message-ID: <AANLkTimKwCDlW_uaCusZcmV2IttqORlUwSqkVnD3no6q@mail.gmail.com>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org> <20100604211811.GA7471@progeny.tock> 
	<7v39x1z72z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 01:57:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL3FO-0003tT-Iy
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 01:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933826Ab0FEX5p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 19:57:45 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47515 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933819Ab0FEX5p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 19:57:45 -0400
Received: by gwb15 with SMTP id 15so552578gwb.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 16:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MrqFCikvH+4TQfMEwDSPQDsgoP+Vguq3AHV47W6v29c=;
        b=BDmbjx+45j1H8cbDnYRYON2In2i4kVfdqqPg+0Zc/9YwgPZIwrX5JFaWxda+8tEiE/
         gGe16/O0x9FTER7jlDFszmwZqKKn7F6tVkyeU7DbxY8JPfh/7+9Z+Fj0JGjTUamaQ7ae
         BR0+Ns7fbavDpRdQIgygBB5td9CxgumaZ9Z3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=T9nak7N38+Z1KHJkH0vH/97NTMRFFOPBqU0DFvMx4zlYwZl/WX234su84nR0JmsTD8
         eGh3Xu1HkdyUS9M+W+HXhACGrudrv6bolmI29kjrR9PLOk3ThCJhb2/x1oLPGuox4tW6
         2Y1grqULuzuYbdnaIA9mHaVnhi1QrMQJxTELE=
Received: by 10.151.18.38 with SMTP id v38mr12170875ybi.420.1275782264072; 
	Sat, 05 Jun 2010 16:57:44 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Sat, 5 Jun 2010 16:57:24 -0700 (PDT)
In-Reply-To: <7v39x1z72z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148504>

Heya,

On Sat, Jun 5, 2010 at 20:07, Junio C Hamano <gitster@pobox.com> wrote:
>> That patch (d1b1a919) breaks merge-one-file when run outside the tes=
t
>> suite as far as I can tell.
>
> Thanks for catching. =C2=A0I wonder if something like this would be b=
etter in
> that it wouldn't break people who do not use custom "DIFF" while it w=
ould
> help people who do at the same time...
>
> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 =C2=A02 ++
> =C2=A0git-merge-one-file.sh | =C2=A0 =C2=A02 +-

No addition to the test suite to catch this in the future?


--=20
Cheers,

Sverre Rabbelier
