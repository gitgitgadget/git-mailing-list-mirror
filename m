From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] ls-remote: print URL when no repo is specified
Date: Sat, 15 May 2010 11:20:02 -0500
Message-ID: <20100515162002.GA2592@progeny.tock>
References: <1273416140-5044-1-git-send-email-rctay89@gmail.com>
 <1273598423-3156-1-git-send-email-rctay89@gmail.com>
 <7veihh8y8b.fsf@alter.siamese.dyndns.org>
 <AANLkTinxm8hwX53LE9_7rDPoKs9UnGAyFFfVcoh-WGxE@mail.gmail.com>
 <20100514161743.GA1957@progeny.tock>
 <AANLkTimTKiGxpVelj9rVV_BV-f8NiKlQHpov38ojlfFq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 15 18:20:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODK62-0007UV-W9
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 18:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222Ab0EOQUH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 May 2010 12:20:07 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34707 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab0EOQUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 12:20:06 -0400
Received: by gyg13 with SMTP id 13so1518477gyg.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 09:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XNtDXx8HUjuUYzT95PCEElAqsbe2wRiQXOWHxFBHqis=;
        b=QN3q9dQS0F4PdkbzLnYj711u49RulEW3HVwq3ZDI0u8ai5fUY/d15CgGyky2TpbNWh
         DSwkNXkMUOiX2ZRLGg5flqoLB/1LpQxSRj7+/UcooPbg40UKN2b7Opi/Op0RSwJUhiN/
         +4wLHZKXoRqaCghk2UFRGXbEKzUKCGnkrQurc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jp/mAlq6ADOdRAaLpTVHRITLWPytW1Y/Gu4Awqm0KmP5vX7Fjao/kTdoIFQQpG6z9q
         m8qHBfSgTvsKeFTViA3ugcCx8Wg5N5qQyimJGQRM7US4dxwJiiM/K0rslqGPmk3Nn2ur
         r8cKb8uLSYn+KcpZZbNiX1mVWUnk27vyjVB/A=
Received: by 10.150.47.15 with SMTP id u15mr3983287ybu.220.1273940404767;
        Sat, 15 May 2010 09:20:04 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2280421yxe.12.2010.05.15.09.20.02
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 09:20:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimTKiGxpVelj9rVV_BV-f8NiKlQHpov38ojlfFq@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147156>

Tay Ray Chuan wrote:
> On Sat, May 15, 2010 at 12:17 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:

>> I think I see what you are saying, and for scripts, that really woul=
d
>> be the most useful thing. =C2=A0Then the script could use something =
like
>>
>> =C2=A0if test -z "$remote"
>> =C2=A0then
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0remote=3D$(git branch --get-remote --curr=
ent)
>> =C2=A0fi
>> =C2=A0git ls-remote "$remote"
>
> Just curious - when did git-branch learn "--get-remote"? Or "--curren=
t"?

It didn=E2=80=99t.  I was just saying that it should (or we should prov=
ide some
commands to that effect).  What do you think?

Maybe later today...
Jonathan
