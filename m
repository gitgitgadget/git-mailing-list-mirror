From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Determining commit reachability
Date: Mon, 6 Sep 2010 20:53:46 +0000
Message-ID: <AANLkTim4kxpQj_UFOBcwCaVmBFCHun4T9t3O9Zvq3w49@mail.gmail.com>
References: <4C83FEC3.3040101@gmail.com>
	<7viq2jv05c.fsf@alter.siamese.dyndns.org>
	<AANLkTinDfCkkY_D6F7VepvuNAN1g1hC9UgnqRUjZn88y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 22:53:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsihN-0003Wf-2W
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429Ab0IFUxt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 16:53:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38821 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0IFUxr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 16:53:47 -0400
Received: by iwn5 with SMTP id 5so4581262iwn.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ViiKJDCTI28EOa5EuRs5OK9RccmXMT9BurBEyJp9t5c=;
        b=LzhlXmCFrB/HEQVKa2OgwYD0+573qhQeNftO68nhn6LGdqirff7evadGOpS0p+gaBm
         cGqrn8JSZ9ODLQQPtgsjLBE8Qu9i+4lbjrFOgTAMT4H0RIj89nZ78y6NXJdxVXLd1wT/
         5kqsNMjloh6YozrcK9ECP1lsNrv8QiVE8kbc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DR4NSPRcuDb9GgyfcT3L5yqFEYXTQOJnwazDFjkVNpcyT54om0Ezh+07lrJtEXRuR+
         D676QPI0h8d1xB9aN+s3napQw/aKgsmmXp5QECAVfCVmRMykpovuRvmccZMlB4EZFjtF
         WyuGsm4WdB8Q+Yot42yat1BxpeOk+edaTjuME=
Received: by 10.231.153.76 with SMTP id j12mr6795778ibw.66.1283806426641; Mon,
 06 Sep 2010 13:53:46 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 6 Sep 2010 13:53:46 -0700 (PDT)
In-Reply-To: <AANLkTinDfCkkY_D6F7VepvuNAN1g1hC9UgnqRUjZn88y@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155621>

On Mon, Sep 6, 2010 at 20:45, Sverre Rabbelier <srabbelier@gmail.com> w=
rote:
> Heya,
>
> On Mon, Sep 6, 2010 at 01:47, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> Depends on the definition of "best", but I often find myself typing
>>
>> =C2=A0 =C2=A0git branch --with C
>
> In case anyone else is wondering, '--with' is a hidden alias for '--c=
ontains'.

Maybe it should be documented?
