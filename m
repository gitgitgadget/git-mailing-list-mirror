From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv3 1/2] Add a remote helper to interact with mediawiki,
 pull & clone handled
Date: Thu, 9 Jun 2011 16:32:58 +0200
Message-ID: <BANLkTimRZ14NhD+evfZu2stHO+DFH0uuPw@mail.gmail.com>
References: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
 <BANLkTikp6bGwVZqq7XAZ1bKVaMVLJ9XQiw@mail.gmail.com> <BANLkTinduWxp5QR+Ri3REoqVY3hYPc_-rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?Q?Sylvain_Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: =?UTF-8?B?SsOpcsOpbWllIE5JS0FFUw==?= 
	<jeremie.nikaes@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 16:33:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUgIq-0005OC-HZ
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 16:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab1FIOdj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 10:33:39 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46083 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab1FIOdj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 10:33:39 -0400
Received: by qwk3 with SMTP id 3so745039qwk.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=jiAW6y1q35NWW1ThQCaJWiooRL5xLmVxnl9k5Iavs9I=;
        b=ZZ9gxz1KsCHr5FU8UmhNr9P8u8Hru7loAJS2jP90OtiRI9TUAEovCeaxB/clh8Uhhn
         VkQRUtxKnJUS4QgxkmS485+GsH60JoghsaoLjiTLpk8F810OxTGZ0SampKjGXMZSpVN7
         0++zKcTHjDron8ud7XTQbHXLnsFWrD6XwutN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kD76yaN6jM8x6+zZakonTeduYILrTOoMLULAIFDyNe8p7Y5jatmRqAobv12bXkLp/N
         dXHegd9joSzvajTrcGtpm5dlPnI9mycG0oPO1HJ7torUMffOojsOSNNWMs1zMOtto3/2
         NpqtFLTQJfu42LFmQJ77GyY4fhiUuKt4xStoQ=
Received: by 10.229.127.99 with SMTP id f35mr635963qcs.91.1307630018248; Thu,
 09 Jun 2011 07:33:38 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Thu, 9 Jun 2011 07:32:58 -0700 (PDT)
In-Reply-To: <BANLkTinduWxp5QR+Ri3REoqVY3hYPc_-rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175528>

Heya,

2011/6/9 J=C3=A9r=C3=A9mie NIKAES <jeremie.nikaes@ensimag.imag.fr>:
> Well, if you dont give the capability to push, you get the following =
message
>
> error: failed to push some refs to 'mediawiki::http://mediawikiurl'
>
> Which is less explicit than 'Push not yet implemented'.

I suspected as much. In that case perhaps the transport-helper.c code
needs to be updated to give a more helpful message?

--=20
Cheers,

Sverre Rabbelier
