From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] unpack_sha1_file(): zlib can only process 4GB at a time
Date: Fri, 10 Jun 2011 00:28:39 +0200
Message-ID: <BANLkTimtaFGhrzTVsg0=gods5Kza7tZ9=A@mail.gmail.com>
References: <7vpqmmwyl9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 00:29:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUnjC-0006qU-6x
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 00:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756846Ab1FIW3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 18:29:20 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64255 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab1FIW3U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 18:29:20 -0400
Received: by qyg14 with SMTP id 14so1100649qyg.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 15:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=XuIku9nRImVqH35T7KfhpUeL4sJjIIbuMFIe4nkrJAc=;
        b=cvQOoqouteq2Hat9T446+V/p5gL7KHVlOfH1CXidabAFUgmazTL3HbJKOYOBVbS8FT
         KcGIp/itSwa7nEnHnTjDe+j7kQbvd75TBa3cLsMBS0+vhhTxLAHIj+MEVHnIB/ojxDOa
         bT2i8gRdiIUqoVcydKg9HrDEWv2ht1NS4IiQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NfqPY1iWD17Fjdp2bfyoThF3d76h/Lt7o7rD2PvYt35wNQl7SmDw++1Zb8S4+PWvTs
         zhpoaE+tsN87VXLPuGcQeCjyG7lX6RzBTqKSy3Hc3bnbXPNmY54Cj3n3KxITSfnPH3Di
         KTWiKOAnOdETCidMWCeay74Zri8f760mjyiRk=
Received: by 10.229.100.20 with SMTP id w20mr1086364qcn.129.1307658559311;
 Thu, 09 Jun 2011 15:29:19 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Thu, 9 Jun 2011 15:28:39 -0700 (PDT)
In-Reply-To: <7vpqmmwyl9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175582>

Heya,

On Thu, Jun 9, 2011 at 22:15, Junio C Hamano <gitster@pobox.com> wrote:
> =C2=A0* On a beefy enough machine, you could register a large binary =
blob
> =C2=A0 and run fsck, fetch, or push to play with that object with the=
se
> =C2=A0 patches, but there are many more places that aren't safe.

Do you know what those places are, and do you plan to fix them when
you get better? If not, should we record those places somewhere (if
nothing else just on the list)?

--=20
Cheers,

Sverre Rabbelier
