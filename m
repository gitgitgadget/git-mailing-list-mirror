From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] blame.c: Properly initialize strbuf after calling, textconv_object()
Date: Fri, 28 Oct 2011 19:17:31 +0200
Message-ID: <CAHGBnuNpwZCpQxZQNRZ-pYpLMHMi1O4d0hsR9MKM3=7Hw5A=zw@mail.gmail.com>
References: <4EAACA1C.6020302@gmail.com>
	<7vlis5t8bf.fsf@alter.siamese.dyndns.org>
	<CAHGBnuPUGfOe1D_OZ0ga4s8EiS_=GZeBG7WLmyOHt7vNg+w3Fw@mail.gmail.com>
	<7vhb2tt6ag.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 19:17:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJq3l-0006iw-L4
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 19:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472Ab1J1RRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 13:17:32 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47909 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab1J1RRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 13:17:32 -0400
Received: by vcge1 with SMTP id e1so3572526vcg.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mPhPOauDz2QbgWilVuRaL4vSZbndApdkEUFZ0HM1u0Q=;
        b=qKwun5TOMiNVM1jMImFCRUEAbU9K9kjuV/KG7yu+MTEaismZ1l0HktERJG1EMJM3/B
         9eFquGqcqFceiX4Cs5Eo63WZtxffAEdT2I0jnvHdGXCdIlPGDFpuE62diiCHljJOv/uE
         CzzT4FV4jjFkSo7bfpRRra4iyJws2OS9MpioI=
Received: by 10.220.9.2 with SMTP id j2mr540840vcj.155.1319822251492; Fri, 28
 Oct 2011 10:17:31 -0700 (PDT)
Received: by 10.220.175.202 with HTTP; Fri, 28 Oct 2011 10:17:31 -0700 (PDT)
In-Reply-To: <7vhb2tt6ag.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184418>

On Fri, Oct 28, 2011 at 18:44, Junio C Hamano <gitster@pobox.com> wrote:

>>> Thanks; do you have no addition to the test suite to demonstrate the
>>> breakage?
>>
>> Not yet. I'll try to come up with something.
>
> Let's do this.

Thanks, but that does not seem to work for me. The test breaks both
without and with my patch. I'll look into it.

-- 
Sebastian Schuberth
