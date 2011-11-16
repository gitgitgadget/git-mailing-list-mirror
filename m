From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/3] avoiding unintended consequences of git_path() usage
Date: Wed, 16 Nov 2011 14:21:46 +0530
Message-ID: <CALkWK0kPM1S9ELTWL1SiGjFN1e3NK2V-q4ixqM77aUMuDPxdqg@mail.gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com> <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org> <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net> <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com> <20111116075955.GB13706@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 09:52:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQbE6-0000WD-Fs
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 09:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab1KPIwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 03:52:09 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:53238 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab1KPIwI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 03:52:08 -0500
Received: by wwe3 with SMTP id 3so881518wwe.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 00:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Oo+Ws4fFfc9HJWsXLqgJ7FqS/+jUlg8NqJkfPxL950E=;
        b=Ecm/Zzb1rsdPPGrwANSz0S++FhcaB85LWGz6+nypaT3hW6FGOZ/f4pdwalIS7e+Nly
         3TsmRcmuL+pFuFOPjGBEZ+eR/ydeYurtAtbjJ0RPzJKvXEMSrM9QFZfTeKn0hwnOUNaJ
         1sHJfVCnLrI4qPa3YK4JscPmTXdX0yr/NFxK0=
Received: by 10.216.188.145 with SMTP id a17mr4994350wen.24.1321433527283;
 Wed, 16 Nov 2011 00:52:07 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Wed, 16 Nov 2011 00:51:46 -0800 (PST)
In-Reply-To: <20111116075955.GB13706@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185529>

Hi Jonathan,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>> Junio C Hamano wrote:
>
>>> Or perhaps http://thread.gmane.org/gmane.comp.version-control.git/1=
84963/focus=3D185436
>>
>> I noticed that sha1_to_hex() also operates like this. =C2=A0The
>> resolve_ref() function is really important, but using the same
>> technique for these tiny functions is probably an overkill
>
> I don't follow. =C2=A0Do you mean that not being confusing is overkil=
l,
> because the function is small that no one will bother to look up the
> right semantics? =C2=A0Wait, that sentence didn't come out the way I
> wanted. ;-)

I meant overkill in terms of the work required and code churn.
Ofcourse, I'd have been more than happy to see it being implemented-
and you've actually done it now! :) Nguy=E1=BB=85n has a more fancy sol=
ution,
though I'm quite happy with this as it is.

=46inally, for all the times I've fumbled in git_path() usage:
Liked-by: Ramkumar Ramachandra <artagnon@gmail.com>

Thanks for working on this.

-- Ram
