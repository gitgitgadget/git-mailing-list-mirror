From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/RFC v2 0/3] git checkout optimisation - part 3
Date: Fri, 20 Feb 2009 10:26:04 +0100
Message-ID: <bd6139dc0902200126j51177504hfeb23b4ec07dfea0@mail.gmail.com>
References: <cover.1235071656.git.barvik@broadpark.no>
	 <7vfxi9fqup.fsf@gitster.siamese.dyndns.org>
	 <86r61tiio2.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri Feb 20 10:27:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaRfb-00058T-PY
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 10:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbZBTJ0J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2009 04:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbZBTJ0I
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 04:26:08 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:3831 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbZBTJ0H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 04:26:07 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1759516fgg.17
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 01:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=1OKkobiDaIO1a4V3FbiA6HIyYdS+Np1hKraMCD5a9Dg=;
        b=jwupnLKC1wFJd/ljOWqVlG6tPf4poRlvuABztWZ9SzxAnC77lQb6ZYMxGqDBUXzixO
         QrHuPzaxgjIshv2y2nRw44VKgpwaWZltyTmiQnDPl0UwF27l5TQX/rtW6ZoXF0aKmPn9
         g6128u+kOnDoiSYcWoCqJgpmyEOZtwe3KnlpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=EOaZARegJPGunEVbdyY117PWYcChJLcWH7ykRRc6tfRGWIlLI5QDbfSZN4KPcqKSVU
         8SG2gxGWeXILH4ovtUhD0Ge3W3Lw+y/imhj0Tekg2oPsIIoFig9LOL0dLMlsdcvsbMdP
         jG8B7dJI5syHIuU1XOT9g0VMVxWQfiJ9F4zYI=
Received: by 10.86.52.6 with SMTP id z6mr863379fgz.35.1235121964849; Fri, 20 
	Feb 2009 01:26:04 -0800 (PST)
In-Reply-To: <86r61tiio2.fsf@broadpark.no>
X-Google-Sender-Auth: a5d32d017b90d216
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110828>

Heya,

On Fri, Feb 20, 2009 at 10:03, Kjetil Barvik <barvik@broadpark.no> wrot=
e:
> Junio C Hamano <gitster@pobox.com> writes:
>> Hmm, have you noticed that the rest of the stuff are queued on 'next=
'?
>
> =A0Yes, I have! =A0I was also glad to receive my first acked-by git-t=
ag!!

In that case, it wouldof been appopriate to base your further patches
on next rather than master ;).

--=20
Cheers,

Sverre Rabbelier
