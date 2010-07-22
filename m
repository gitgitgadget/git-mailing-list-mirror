From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Running git on Windows command line
Date: Thu, 22 Jul 2010 23:04:34 +0200
Message-ID: <AANLkTil69VdTLldEcInFcYLwcStFnEEkoBCAWS1kd-S6@mail.gmail.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB939B8A@FL01EXMB01.trad.tradestation.com>
	<AANLkTimXZtlRKlAVuFH5TzzQ1z19ddYazIRKIgGALMpZ@mail.gmail.com>
	<1A9EA7E081C3FE46A0F446FFB66D10EB939D37@FL01EXMB01.trad.tradestation.com>
	<AANLkTin-RMEOfc7FlfnQfTgzxMfV-Vq6r5ahkP6P6_SJ@mail.gmail.com>
	<1A9EA7E081C3FE46A0F446FFB66D10EB939DAC@FL01EXMB01.trad.tradestation.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 23:04:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc2wb-0007tY-MZ
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 23:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352Ab0GVVEg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 17:04:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37717 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab0GVVEf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 17:04:35 -0400
Received: by wyf19 with SMTP id 19so994800wyf.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=lUmezM00fAEM+LO4bmn2zjyl1ucKbpwrDGwAIYmt1Po=;
        b=t1YYDkMhvQd1BodMCSVBxkv2b5nNNFz/x8WRV4IhxwrBjeWpNelI9aTTygFSj8k2lI
         +5/eG5mS07i8RnseNph1VZybqagIvMCM7hXa9wT5TzgkPfhzAHm7h6I48irZRVuMbaD0
         Mht6kFdUY6lc/jHuxZwKLA4c+xxOQ3W3bSphs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Ig7QV1waF3ksJTqzr1FAoUp1HamIQHnvQg0MW3DKaNcZn++MrThT2BKGPqYafIWaGp
         0TM+2O6xveUN15d3YmbCsJXGoTYYR2whFw4tBWLhLejjERJAb8HVuu+mdC42Rh1dfXiQ
         57QacwOnukt2bk1qhHobnuakxhedZgZErRFHw=
Received: by 10.216.181.213 with SMTP id l63mr2504604wem.24.1279832674286; 
	Thu, 22 Jul 2010 14:04:34 -0700 (PDT)
Received: by 10.216.70.67 with HTTP; Thu, 22 Jul 2010 14:04:34 -0700 (PDT)
In-Reply-To: <1A9EA7E081C3FE46A0F446FFB66D10EB939DAC@FL01EXMB01.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151484>

On Thu, Jul 22, 2010 at 10:55 PM, John Dlugosz
<JDlugosz@tradestation.com> wrote:
>> It sounds to me like you've installed indeed Git for Windows (which =
is
>> the end-user product from the msysGit-project); the msysGit installe=
rs
>> doesn't show a wizard with questions, it just installs a
>> self-contained development environment.
>>
>> You can tell the packages apart by the name:
>> * Git-something.exe and PortableGit-something.exe are installers for
>> Git for Windows.
>> * msysGit-netinstall-something.exe and
>> msysGit-fullinstall-something.exe are installers for msysGit, the
>> development environment used to develop Git for Windows.
>>
>> I hope this clears up a bit.
>>
>> --
>> Erik "kusma" Faye-Lund
>
> OK, "Git-1.7.0.2-preview20100309.exe" installed something that identi=
fies itself as "git version 1.7.0.2.msysgit.0"
>
> The web page is identified as "msysgit" with "git for windows" in sma=
ll type under it, which I take to be a descriptive statement, not a pro=
duct name also. =A0The downloads call them "Full installer for official=
 Git" (what I used) and "...if you want to hack on Git".
>
> The usage on this mailing list has always been "msysgit" as this wind=
ows variant git, as opposed to the Cygwin build. =A0Mentioning that is =
necessary for accurate help. =A0I mentioned msysgit as the keyword nece=
ssary when asking for help, not to mean I installed the development sou=
rce.

I'm aware of all this, but I don't think you're hearing me: the reason
why the behavior has changed for you is very likely to be you having
switched package. Yes, the naming is confusing.

--=20
Erik "kusma" Faye-Lund
