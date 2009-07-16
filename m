From: Ondrej Certik <ondrej@certik.cz>
Subject: Re: mailmap distinguishing names
Date: Thu, 16 Jul 2009 12:41:16 -0600
Message-ID: <85b5c3130907161141y59d6888dhe9d0c483fd477e8@mail.gmail.com>
References: <85b5c3130907151522x1009a796tced7726d9be4ca7d@mail.gmail.com>
	 <20090716085532.GA8843@landau.phys.spbu.ru>
	 <85b5c3130907161009k64029bd3t23155040728d9d9@mail.gmail.com>
	 <20090716174313.GA10298@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Thu Jul 16 20:41:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRVtU-0008PA-Mi
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 20:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbZGPSlS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 14:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932941AbZGPSlR
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 14:41:17 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:58652 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932891AbZGPSlR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 14:41:17 -0400
Received: by yxe14 with SMTP id 14so523094yxe.33
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 11:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=53kigPKQnvLx9fkmHsoFZ+2Hox9TOfAaYJTxOtat2SI=;
        b=YL7m731jeLmdh6BW6eiJO32X2EZz7xhIO4/vWXxjUPWBa6lMOOGzOtyMTBVM2NWDKF
         KWPCLQ8YlH5RNRxiMmz1Y7/+xnVP0DrdTs6yZdhXgCkH54NAFra4aEQyAk92OioW1XQ5
         8nkJaph+Vd8qk9jARbU4BFr36dWY7Y17rQbHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=fiuzyobdDc8F0vpcBTF7UHCeW2AAXYfk1/ifYO/1fAw/2J+ZLa/pI3frWQjUX6hqeT
         9ruQNpJUtMbKXdZnFIHw6JV/BY1VdVNO0bv9QAU2L7pF9dQmmPU4CkbgmgujcIeVaB1h
         vlRYqgTdIdYBXOthYFBGhtDzNPlrxruUz+bUQ=
Received: by 10.90.82.8 with SMTP id f8mr79780agb.10.1247769676212; Thu, 16 
	Jul 2009 11:41:16 -0700 (PDT)
In-Reply-To: <20090716174313.GA10298@landau.phys.spbu.ru>
X-Google-Sender-Auth: b01d39af499bbd8f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123415>

On Thu, Jul 16, 2009 at 11:43 AM, Kirill
Smelkov<kirr@landau.phys.spbu.ru> wrote:
> On Thu, Jul 16, 2009 at 11:09:06AM -0600, Ondrej Certik wrote:
>> Hi Kirill!
>>
>> >
>> > You just do
>> >
>> > =C2=A0 =C2=A0Ondrej Certik <...@...> =C2=A0 ondrej.certik =C2=A0<d=
evnull@localhost>
>> >
>> >
>> > in .mailmap
>> >
>> > See Documentation/mailmap.txt for details
>>
>> Many thanks for help, that's exactly what I want.
>>
>> Only I think I am probably doing something stupid, because I can't g=
et
>> it to work (I use the latest git from git),
>> I put this into the root directory:
>>
>> $ cat .mailmap
>> Ondrej Certik <...@...> =C2=A0 ondrej.certik <devnull@localhost>
>>
>> (if have my real address instead of the ...@..), and:
>>
>> $ git shortlog -ns
>> =C2=A0 654 =C2=A0Ondrej Certik
>> =C2=A0 322 =C2=A0Kirill Smelkov
>> =C2=A0 268 =C2=A0ondrej.certik
>> [...]
>>
>> it still shows ondrej.certik. =C2=A0I will try to debug it why it do=
esn't
>> work, I think according to the documentation it should work.
>
> It does work with the following mailmap:
>
> =C2=A0 =C2=A0Ondrej Certik <ondrej@certik.cz> =C2=A0 =C2=A0ondrej.cer=
tik <devnull@localhost>
>
> before:
>
> $ git shortlog -s | grep -i certik
> =C2=A0 654 =C2=A0Ondrej Certik
> =C2=A0 268 =C2=A0ondrej.certik
>
>
> after:
>
> $ git shortlog -s | grep -i certik
> =C2=A0 922 =C2=A0Ondrej Certik


Now it works! Many thanks, I must have been doing something really stup=
id.

Ondrej
