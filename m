From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Add test-string-list.c
Date: Tue, 7 Sep 2010 09:04:45 -0300
Message-ID: <AANLkTi=1B6GaWZ0d6uiHWWjP7EvQLsaO0ZQDgWuBofDN@mail.gmail.com>
References: <4f798daaf4631e00927b455b77919d5bb8fade03.1283653854.git.tfransosi@gmail.com>
	<20100905050254.GA6134@burratino>
	<AANLkTi=J_0XaVYUt8Umu3uW15W86wbWv-xCMuVGA7cUE@mail.gmail.com>
	<20100907000703.GB32717@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 14:04:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oswuy-0007JU-TP
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 14:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512Ab0IGMEs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 08:04:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40710 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756463Ab0IGMEr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 08:04:47 -0400
Received: by bwz11 with SMTP id 11so3995091bwz.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 05:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a9vlo+3F52biyE6v18/3ZStKctCEvqA3T8tP+ELTm8c=;
        b=Dy/sfjPZMZyL7fnyIfzdkz5ovsasiVB/sqVUmkZdTlYYTxgqwtNGvWbES3hfDrOBiT
         jCnSjZez18D1DKVPWJaL/l1xnvFw+//pb/BIYKnMYDSZfNkiusnsHe7xF/n4tC8iChBZ
         /0NTGc3pMqOdndXlqe4wD3Gv3YVDDLbWlDXLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dB3lw0h1csEFHDdXD9HRJnP/JbGopOZF1ZNUTyIbAFnjmn8VFmDL3H+lTKMvQTkBru
         fG6LQVP2ZAH5YJUIh+yarVvkqCMy2gdmthkNF5ZLkKQzHvwTkxD+jbGk5i8x3E8dk3ub
         3xXG8Z6SCNJQNJfaW83nKK2vuCgp2nojKwjNk=
Received: by 10.204.82.136 with SMTP id b8mr4289505bkl.38.1283861085734; Tue,
 07 Sep 2010 05:04:45 -0700 (PDT)
Received: by 10.204.3.208 with HTTP; Tue, 7 Sep 2010 05:04:45 -0700 (PDT)
In-Reply-To: <20100907000703.GB32717@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155699>

On Mon, Sep 6, 2010 at 9:07 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Hi Thiago,
>
> Thiago Farina wrote:
>> On Sun, Sep 5, 2010 at 2:02 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:>
>
>>> To make sure this example remains valid, wouldn't you want to inclu=
de
>>> a caller in the t/ directory so it can be automatically run? =C2=A0=
(See
>>> t/README.)
>>
>> I read it, but I'm not sure how to do this. Maybe you could point me
>> to an example?
>
> t0070-fundamental.sh might be a good place to add it.
>
Thanks, added it to there.

>> It can be expanded later by anyone to test many other things though.
>
> I suppose. =C2=A0Edge cases for arguments, sorting, and _DUP versus _=
NODUP
> semantics would be the main thing I would be interested in testing.

Reworked into small functions to test string_list functions separated
(using assert to check if the return value of the function is what is
expected).

Please, take another look.
