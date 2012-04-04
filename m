From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: rebase -p loses amended changes
Date: Thu, 5 Apr 2012 09:05:16 +1000
Message-ID: <CAH3AnrphGmrZSxALP3j3ADt6Cg4Tr2O83mcDBU2LfUdpdtUCUw@mail.gmail.com>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
	<CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
	<87fwcpun95.fsf@thomas.inf.ethz.ch>
	<CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
	<CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
	<CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
	<CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com>
	<4F7BEA9F.3060805@viscovery.net>
	<7vpqbna0cd.fsf@alter.siamese.dyndns.org>
	<7viphf8cqh.fsf@alter.siamese.dyndns.org>
	<CAH3AnrrE9Fbs_p_=ETRns4vyz8J879-m+KDF5K4j7vDdTh9bEg@mail.gmail.com>
	<7vlimb6r37.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Phil Hord <phil.hord@gmail.com>,
	J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 01:05:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFZGV-0005wq-CB
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 01:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757279Ab2DDXFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 19:05:19 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41043 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757211Ab2DDXFS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 19:05:18 -0400
Received: by wibhj6 with SMTP id hj6so1041157wib.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 16:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cD0m2QuWFeqp2ERL9erV4tK+NdSBX5r2Bh8F5voaDJ0=;
        b=MTcdcLxRWIZj572SXzXCNVKfa4xFGSXkz6Sgg4PKi49wXv0wNRjB7Nf+1TrhjxafU2
         svfMo9z36jEXIs+0JVtWVey3QZS4lkXmDttcSbqXQuR+rj6u6Vo4yNtgfUZEbtD8oXTi
         pIvHsPRfGJ98k5qIJeGIQSKN1ni2xI2r/eTwT7y8uZY054P6OPMrv5AZ3YUVfBmGrB71
         RAX0Oh+j2mJW3mToQS90Ry3jzXuxuwW7nZCLchzl0yWfn18wrmMnYW8APrHVmgsvFze/
         s6zGWwRPBJ1HIupjFkwNmi/iv2P63gafhlBBScnKTqxJj1I0GB/Dj8qOzeA0PcmY13NG
         6w1w==
Received: by 10.216.131.154 with SMTP id m26mr175472wei.91.1333580716629; Wed,
 04 Apr 2012 16:05:16 -0700 (PDT)
Received: by 10.180.82.35 with HTTP; Wed, 4 Apr 2012 16:05:16 -0700 (PDT)
In-Reply-To: <7vlimb6r37.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194753>

On Thu, Apr 5, 2012 at 8:59 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> Are there any flaws, I wonder?
>
> It all depends on how close the base is to M^1. =C2=A0The difference =
might make
> it unnecessary (or even more necessary) to do any evil merge.

True. I guess it is still true there are no perfect solutions in this
area. This does seem like a step in a better direction, though.

jon.
