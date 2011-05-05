From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: How to fork a file (git cp ?)
Date: Thu, 5 May 2011 22:06:44 +0200
Message-ID: <BANLkTimn9uKXfRDFnmOhbs6=93xASQ42-g@mail.gmail.com>
References: <4DC1934D.6070608@aldan.algebra.com>
	<4DC19955.7040503@kdbg.org>
	<7viptqdvrf.fsf@alter.siamese.dyndns.org>
	<4DC20461.4090703@aldan.algebra.com>
	<7v1v0ddhbz.fsf@alter.siamese.dyndns.org>
	<4DC2FB0A.2090100@aldan.algebra.com>
	<BANLkTikE8aMh6RUDzrh=SuOxvKxuPShQhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: "Mikhail T." <mi+thun@aldan.algebra.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:06:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4p1-0008CA-Nf
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab1EEUGr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 16:06:47 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53579 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab1EEUGq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 16:06:46 -0400
Received: by vxi39 with SMTP id 39so2628811vxi.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 13:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mI9M3qjcWA//imxooQYXhmMFzKIQAGBXKeB/+Vg64aQ=;
        b=QRuJaEXJZYVRoTXRkm3+lyVT1aN/yPOZez4VbL15MNuVeCwtxYlOyELNHC7+UEIolJ
         bT6Xq0oV37dUYK786dSDHoOgsc9Fbok7Hel8FUp8vKpOHUqvU7mjMoTjxLkoUGTGj2Hs
         gFlR9T+TohDYoTBs847xyyiXtYX7TKjsqZ/eA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tL+/hqjhNUTrXn6SISGd2t1sl6vvYNu0+I87h4Zhe2VWvO1zBE1NkRNoSz7bMIl5L8
         Vcw0RjX/BTPqkhFad7AV3j2BYENcw7hrK4Nsll8321W8PxMddOYi9wy/rIejrKLh9UFG
         aRIWCt//PJWQw+LTCMPu+aWy3xwlkD9KUz2JM=
Received: by 10.220.20.81 with SMTP id e17mr687615vcb.85.1304626004786; Thu,
 05 May 2011 13:06:44 -0700 (PDT)
Received: by 10.220.201.135 with HTTP; Thu, 5 May 2011 13:06:44 -0700 (PDT)
In-Reply-To: <BANLkTikE8aMh6RUDzrh=SuOxvKxuPShQhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172901>

On Thu, May 5, 2011 at 10:01 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> BTW, I don't understand why 'status' shows renames but not copies:
>
> $ cp f fcp && git add fcp && git status
> # Changes to be committed:
> # =A0 =A0 =A0 new file: =A0 fcp
>
> $ mv f fmv && git add fmv && git rm f && git status
> # Changes to be committed:
> # =A0 =A0 =A0 renamed: =A0 =A0f -> fmv
>
> I would expect sth like "copied: f -> fcp".
> Not sure what about one file copied to multiple files, but I suppose
> renames have the same problem.

I mean similar problem - you can delete one or more identical files and=
 add one
or more new files with the same content.


> It should not be a problem performance-wise...


--=20
Piotr Krukowiecki
