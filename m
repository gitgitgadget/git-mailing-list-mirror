From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 20:38:09 +1000
Message-ID: <BANLkTikLh5smW1u+V++05JK89EgK-WSzyw@mail.gmail.com>
References: <4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
	<7vsjt35l84.fsf@alter.siamese.dyndns.org>
	<20110427234224.GA26854@elie>
	<7viptz5j82.fsf@alter.siamese.dyndns.org>
	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
	<alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
	<BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
	<4DB92F55.5090409@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>, david@lang.hm,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Apr 28 12:38:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFObx-0003xl-TC
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 12:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759209Ab1D1KiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 06:38:12 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44630 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab1D1KiL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 06:38:11 -0400
Received: by ewy4 with SMTP id 4so779745ewy.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 03:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t7QKRl4lHsesfr3WTK3kbPP7PxUC8i2/ympdOF72/M8=;
        b=UKO4hD4NrEiKCZEh69KrWQnsITtbPSQGyW9z1Ztnbny9JHC9cGRGaBJkz8cO0Bxkp7
         HvLl9JI6uFmmTCegBLw3jmhmyPUmUj1gp80cATfntPOCx09X+jUv96gPIYMkWleaYBE4
         KVkAihvOhcoVcQDYh0XKNn8p9MgWFnfLt5Rg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q06SFwMji/uurQVt4hBVEiJdWbDU7Rl/FLdeXKbZ9M+N76HRGX7waE9SaQyqcbhzAX
         je9XVoEHOuDUAsiTOtYv7A6t2MsoCR+2Bi5D92AAQAlUIQPOGNIccuOACy6fKrTL73IK
         T6F09E1wmjecOz4F4HhXJ/3C3P6OhSIaSrmO4=
Received: by 10.14.6.10 with SMTP id 10mr1445828eem.117.1303987090072; Thu, 28
 Apr 2011 03:38:10 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Thu, 28 Apr 2011 03:38:09 -0700 (PDT)
In-Reply-To: <4DB92F55.5090409@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172349>

On Thu, Apr 28, 2011 at 7:11 PM, Andreas Ericsson <ae@op5.se> wrote:
> On 04/28/2011 04:15 AM, Jon Seymour wrote:
>>
>> * suppose that git-core defined a git install _interface contract_ b=
ut
>> did not define an implementation.
>>
>
> Please. I'm already on my way to a seriously boring sales meeting wit=
hout
> having developers throw garbage terms on me. You've done a lot of tha=
t in
> this thread and I for one am confused by them as to what you want to
> achieve and how you want to achieve it.
>

I am confused. Is "interface contract" a "garbage term" for you?

As I understand the term, it is a good way to enable strong separation
of concerns and information hiding and these techniques are both
valuable tools in the battle against complexity, a battle that I
understand from other posts this in thread you are vitally engaged in.

My apologies, if terms such as "separation of concerns" and
"information hiding" are viscerally offensive to you. I must learn to
deploy phrases such as "horrid" and "utterly horrid" with more panache
and aplomb.

>> Then, a distribution could install its own implementation of the
>> git-install plugin into git installations it manages.
>>
>> Then a command like:
>>
>> =C2=A0 =C2=A0 =C2=A0git install gitwork
>>
>> would trivially work across all distributions precisely because the
>> distribution has provided the implementation of the git install
>> interface contract that git-core has helpfully mandated.
>>
>
> And so we force package maintainers to become git extension developer=
s.
> Brilliant. They'll love you for it.

This exactly the wrong way around, but I can understand your mistake
since I used this phrase:

- distributions would know how to run git plugin activate and properly
 handle non-zero return codes from same

when precision dictates that I should have used the more wordy, but
more accurate:

- distributions would know how to invoke plugin installation scripts
provided by the plugin author, and these plugin installation scripts
would, by virtue of being intimately aware of the public interfaces
(oops, there is that word again) of git, know how to invoke the git
plugin command in order to activate their own plugin.

I have explained in my most recent reply to Pau that in the absence of
a plugin management script provided by the git core, any hope of
plugin conflict management has to be delegated to other parties such
as the package manager author, the package  author or the plugin
author or, alas, to the poor user.

I fail to see why management of plugin conflicts is better handled by
N authors and M users, rather than a single author of the git-plugin
script [ except for the minor detail that the only potential author of
such a script seems to spend all his time writing e-mails instead of
cutting code ].

jon.
