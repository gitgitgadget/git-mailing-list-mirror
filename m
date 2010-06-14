From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/6] Add memory pool library
Date: Mon, 14 Jun 2010 16:25:40 +0200
Message-ID: <AANLkTimtya1Ph5YjlFVAVpE2p4XOHvuaFAmsS4C0J5LH@mail.gmail.com>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com> 
	<1276175389-6185-2-git-send-email-artagnon@gmail.com> <20100612064250.GB2549@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 16:31:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOAh6-0004WA-Vt
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 16:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368Ab0FNObP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 10:31:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59708 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab0FNObO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 10:31:14 -0400
Received: by gye5 with SMTP id 5so2422012gye.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QzpZAygkDMqq1QXJp75P3sJObNQHjL2cO4y2Zav68uA=;
        b=aEq1q3x0Z28BvxX6mahoMUgqJvzORYPS02dOnJfofasbFCeYuF9GJQWfbX307pkzk+
         Anqvnd6pBC4736kFmiTOA1n3RVGwFjcTaaFxa/9TwIGlR8Q7OMkOHBUnd0xebEMxjQ1w
         Nb1fX07ht5YtBeL1J7ml94FJmziKf1kOZ91HM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Eo+nzBnOUQkHvQhQNEbSB/54h05Byx1QKF+msP0X0SB5pUfRfz82a1hStUFgDGAJ22
         EJdeGyGlFpe44h0++RBWKb1Qt9JBKQf+RD9TqfO9MBg0hieYcdxaHjk3rcFUcYK0jABQ
         sNVS3DFGtPpfpwMmBZR4ATFQaoLNFs9hmBF2w=
Received: by 10.224.86.14 with SMTP id q14mr482637qal.89.1276525560323; Mon, 
	14 Jun 2010 07:26:00 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 14 Jun 2010 07:25:40 -0700 (PDT)
In-Reply-To: <20100612064250.GB2549@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149094>

Hi Jonathan,

Jonathan Nieder wrote:
> =C2=A0#ifdef __GNUC__
> =C2=A0#define MAYBE_UNUSED __attribute__((__unused__))
> =C2=A0#else
> =C2=A0#define MAYBE_UNUSED
> =C2=A0#endif

You'd suggested this earlier, but I was looking more for something
that we could use to mark some specific functions as unused instead of
marking everything as unused in the generation macro. Anyway, I have a
patch ready, and svn-fe compiles fine with -Wall -Werror.

> Could that work here?
>
> The =E2=80=9Cunused=E2=80=9D attribute was added in gcc 2.7.

Junio? Is this a good solution, or should we think of something else?
What about other compilers?

-- Ram
