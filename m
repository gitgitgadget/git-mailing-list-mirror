From: Dylan Reid <dgreid@gmail.com>
Subject: Re: [PATCH] blame: can specify shas of commits to ignore on command 
	line
Date: Wed, 5 May 2010 01:28:08 -0400
Message-ID: <l2wfd211a421005042228rd6386ff9k9bc54c5862209785@mail.gmail.com>
References: <1272939687-17686-1-git-send-email-dgreid@gmail.com>
	 <4BE0918C.9090204@lsrfire.ath.cx>
	 <j2sfd211a421005041446ub9c2247ai484c2473df856b31@mail.gmail.com>
	 <7vtyqnl19w.fsf@alter.siamese.dyndns.org>
	 <z2lfd211a421005041608n1e302cbbt1bb628e9b51b3e3@mail.gmail.com>
	 <7vfx27kjr6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 05 07:28:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9X9d-0005Tt-2v
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 07:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379Ab0EEF2L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 01:28:11 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57370 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197Ab0EEF2J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 May 2010 01:28:09 -0400
Received: by pva18 with SMTP id 18so290519pva.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 22:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ivNeB/FrxgJRs5QYoU03cFshFIZTbr0FeXQqVzgo0yc=;
        b=w51gKat5z9xCsO7TJN7Xh7irq+6/YJ+sZFq+wklq7GBWoEZqFrzz/Y8o65xa3AFEmX
         wu40Ahvn2SaubNGa1oBafRntiGlP2/fYG83pNe2vleCYiYheS6Zc2QitFwb3OXmrnTfS
         T+FEv0LRcwKc2UkpBSYDteRES56OVf7DC/Nzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kzC+/wpAPFZj0i6+roZUt5bG8kstjx3k8TufCZEz6tMtcnPWB8MWqNb74d892DVp4e
         MWa+0wRLiKkAphKNKL3uWgyHaIAOVo/XAO2SeVQzNsrqJQ4dId+EQhnqzUFx2F8aY6sk
         ooHtd1IXZZxYbP357QszyRVnScWZYft3w15ds=
Received: by 10.142.151.9 with SMTP id y9mr8465203wfd.123.1273037288845; Tue, 
	04 May 2010 22:28:08 -0700 (PDT)
Received: by 10.142.80.7 with HTTP; Tue, 4 May 2010 22:28:08 -0700 (PDT)
In-Reply-To: <7vfx27kjr6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146374>

I've noticed that trying to come up with a solution tonight.  I'll
look at it some more tomorrow.  If you can't tell the difference
between added and changed then there would be no easy way to mark a
line as ignored either.

If the changes get split fine enough could you tell that blame_ent
doesn't exist in a parent commit?

Thanks,

Dylan

On Wed, May 5, 2010 at 1:19 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Dylan Reid <dgreid@gmail.com> writes:
>
>>> I am already confused. =A0If the command must return C when you say=
 "ignore
>>> C" and C introduced a line you are interested in, then what is the =
point
>>> of specifying commits to be ignored?
>>>
>>
>> I was thinking that it would ignore changed lines, not added lines. =
=A0Make sense?
>
> Not really. =A0I don't think you can distinguish "changed lines" and =
"added
> lines" reliably.
>
