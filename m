From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] git-checkout.txt: improve detached HEAD documentation
Date: Tue, 22 Feb 2011 10:19:03 -0500
Message-ID: <AANLkTimG885yeidetLTNyDUiuNmEMhfZcNkvXSNbOHD=@mail.gmail.com>
References: <7v7hcy9vrk.fsf@alter.siamese.dyndns.org> <1298179310-46207-1-git-send-email-jaysoffian@gmail.com>
 <7vd3mkfw8w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 16:19:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pru1c-0007CC-95
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 16:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382Ab1BVPTf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 10:19:35 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65236 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab1BVPTe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 10:19:34 -0500
Received: by iwn34 with SMTP id 34so650178iwn.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 07:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=xp97thNWr6wmKvRz5E5oqLVXlQb74DynblVCEFKrnTk=;
        b=HsXUoGpkurVl9tJM3mH9ee3piwjPZcakM8WYYb5EraTa0LmGd16rmpyLvrBFO1XjK/
         nmylZGiLdK7eIOFAcTS0xdPMg8e5DwQiKxBaSQG2fv4Qv6m335N078+qH6rCL///pDqU
         WVIyFZoMWcz5/dR9SG8k0QGVm9ycdv6LNvjkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kbwRH0mx4kkD0rI3DJE0rPe4g1yQghBud5erDCm+8qt4c6Q4pLvMoM5lzMsI8hMJT8
         K598AZde6On1V2QKgJEqNtUUB7a9g0WTJQRk7oKja9NrTyztwCLwnIXUegNFNrjjtC40
         99yVp+FI1f3pmkJnr/3Xn3bFbNmSC6RY/6CyA=
Received: by 10.231.14.8 with SMTP id e8mr2127374iba.117.1298387974106; Tue,
 22 Feb 2011 07:19:34 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Tue, 22 Feb 2011 07:19:03 -0800 (PST)
In-Reply-To: <7vd3mkfw8w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167552>

On Tue, Feb 22, 2011 at 12:56 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> +It is sometimes useful to be able to checkout a commit that is not =
at
>> +the tip of any named branch, or even to create a new commit that is=
 not
>> +referenced by a named branch. Let's look at what happens when we
>> +checkout commit 'b' (here we show three ways this may be done):
>>
>> +------------
>> +$ git checkout v2.0 =C2=A0# or
>> +$ git checkout b =C2=A0 =C2=A0 # or
>> +$ git checkout master^^
>
> I'd drop the second one, as "b" is not something the end user would t=
ype
> from the command line (you could say "b's commit ID" but the string '=
b' is
> not it, unless it is a tag or something, in which case the first one =
that
> uses 'v2.0' already illustrates it)

Ah, in my mind, b _is_ the commit-ID. In your mind, b is the commit.
=46air enough, drop it.

> and adjust "three" accordingly. Other than that, I think this version=
 is
> a vast improvement over what we have.

Would you mind amending what you've got so I don't have to resend?

Thanks,

j.
