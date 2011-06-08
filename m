From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 8 Jun 2011 18:30:38 +0200
Message-ID: <BANLkTim2W8FxMTLyYE5+iRQWseZ6H_oZjA@mail.gmail.com>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
 <20110608150106.GB7805@sigill.intra.peff.net> <vpqhb8049m3.fsf@bauges.imag.fr>
 <BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com> <vpqtyc0wc1j.fsf@bauges.imag.fr>
 <BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com> <vpqmxhss2yw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, thomas@xteddy.org, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:31:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QULep-00086a-OC
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 18:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230Ab1FHQa7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 12:30:59 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56627 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab1FHQa6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 12:30:58 -0400
Received: by pwi15 with SMTP id 15so323962pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=+ZMYhfvi5nQprwaBdI5A/jpm2/IA/LSeeiogvJq1tOM=;
        b=qlAkD7ecVTl1b39a4r//BSu/PVcPQBMX+NCPdHTsiKpQK4myfnIFkicmoCBowW172g
         U71Nz0iARY8qMXRRlQrh51wTKacmuhp4Qorgn6fvFmc/0L5GyEA2qXk5VeS3YlL7WPWY
         G+aEKE1EXVrFjeZ9oOnrVSjBh+20L3+TnNc3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xppMaVu4+556xbccsbDU9wRa0337VSC/asvcEraf1gLBrYoySsma5qFAa+xBpmbs5P
         l83jQRUaN6Q7WaJCsfqfyoJwovLQIsjZskG/G2qYtVBa1r0PuuWM04JTnC63t0NH8YWh
         gcZEqT1lVCtvzUudxw2+mX4BCaUGXzJQvZ/kg=
Received: by 10.142.208.21 with SMTP id f21mr305193wfg.243.1307550658241; Wed,
 08 Jun 2011 09:30:58 -0700 (PDT)
Received: by 10.142.136.2 with HTTP; Wed, 8 Jun 2011 09:30:38 -0700 (PDT)
In-Reply-To: <vpqmxhss2yw.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175396>

2011/6/8 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> J=E9r=E9mie NIKAES <jeremie.nikaes@gmail.com> writes:
>
>> Yes I tried uri_escape, but that only works in the direction mediawi=
ki -> git.
>> A page named "Et=E9" on mediawiki comes as a Et%C3%A9.mw file on the=
 repo.
>> However, when I try to send that file "Et%C3%A9" with the mediawiki
>> API, I get this error
>>
>> "Can't use an undefined value as a HASH reference at
>> /usr/local/share/perl/5.10.1/MediaWiki/API.pm line 554."
>>
>> So I tried to backslash the '%' but it does not do it...
>
> What if you uri_unescape before sending to MediaWiki?

Same problem, same error. Unfortunately.
--=20
J=E9r=E9mie Nikaes
