From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0 RFC] push: start warning upcoming default change for
 push.default
Date: Mon, 14 Feb 2011 15:21:31 -0600
Message-ID: <20110214212131.GA23806@elie>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net>
 <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net>
 <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com>
 <AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
 <AANLkTin5ZcZU8iwPSm4A87bYRrSCcXJVLBFGSr2+j30j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 22:21:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp5rd-000741-1f
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab1BNVVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 16:21:41 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58462 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab1BNVVj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 16:21:39 -0500
Received: by qyj19 with SMTP id 19so1815031qyj.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 13:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1gu+3LrzaBSX7rQrAkZSl1dCLktvAmcXUMdZwLTdpBM=;
        b=C7mmOracU7DeUk86YQQKmQ1+8GlcfyNRhi3N5TQKu5cNvLaH/4aFJOGKNyRQjzor03
         nfU7k3kDl3ob4IYpRrjQnloEsFQabCuFj5HI36nJo5cvLGPIbay21pzIVoo6vLtmalB/
         vs31WKlMlqEcMB95n+G3MPC49R8YXkWa654Is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GIUTVNT6b/XJsjHHp+AOSgE3PWblhGPo8wH+ENOLkC7E2zEC9z0BxbFMNbRZd/SokK
         7HoiGi15Oz9D2TqnX7lfhShYbG7iNETumVYxUXrDiP+YLEggEmwxNVHEGMTyYPicF7Hf
         6mQNXSSLfjD0Rp0+FsvYm1Dnl0o83oqW1XnQg=
Received: by 10.229.89.208 with SMTP id f16mr3396878qcm.43.1297718499044;
        Mon, 14 Feb 2011 13:21:39 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id nb15sm2093315qcb.14.2011.02.14.13.21.35
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 13:21:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTin5ZcZU8iwPSm4A87bYRrSCcXJVLBFGSr2+j30j@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166769>

Jay Soffian wrote:
> On Mon, Feb 14, 2011 at 2:44 PM, Sverre Rabbelier <srabbelier@gmail.c=
om> wrote:
>> On Mon, Feb 14, 2011 at 19:53, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
>>> Junio C Hamano wrote:

>>>> +	warning("You do not have an explicit 'matching' setting for push=
=2Edefault");
>>>> +	warning("Your workflow will be broken at 1.8.0 unless you do so =
now");
[...]
>>> =C2=A0push.default is unset; its implicit value is changing in 1.8.=
0. To squelch
>>> =C2=A0this message, set push.default. See push.default in 'git help=
 config'.
>>
>> This is worse than what Junio suggested because it does not tell you
>> what to set it to.
>
> Which was intentional on my part. If the message says what to set it
> to, the beginner will just go 'okay' and set it to that, in which
> case, what is the point of changing the default?

Wait, why isn't that a good thing?  The beginner only has to learn one
set of semantics.  My only complaint is that the warning does not
explain how to specify "squelch this warning and give me the future
semantics instead".

So maybe:

warning: You do not have an explicit 'matching' setting for push.defaul=
t.
warning: Your workflow will be broken at 1.8.0 unless you do so now.
hint: See /usr/share/doc/git/RelNotes/1.7.5.txt for details.
