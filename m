From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 1/6] send-email: Add --delay for separating emails
Date: Thu, 9 Apr 2009 16:02:35 -0500
Message-ID: <b4087cc50904091402qbe4a0f2m90c18ab049012cdd@mail.gmail.com>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
	 <20090409081443.GB17221@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0904091342170.6741@xanadu.home>
	 <7vskkh1va5.fsf@gitster.siamese.dyndns.org>
	 <b4087cc50904091359q7cadc31cp150b2681775e7022@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 23:04:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls1Py-0000CB-Oi
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 23:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759641AbZDIVCh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 17:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759109AbZDIVCh
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 17:02:37 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:48204 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757720AbZDIVCg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 17:02:36 -0400
Received: by qw-out-2122.google.com with SMTP id 8so961187qwh.37
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Kmu63lvr8cpUuSx8wedffJr+lYmWsV+67Bp6kuTooA=;
        b=fZoDyvhj2bAB6RC0+UZdZWiHU4LiL7GFAos27iRWfrv2Yhojx74x6Jkj5UEk9FtBFg
         kRpxQ/LfDNV0OVuW3cGLKunD4ttlhq3ghWg2c3zkNPX+Xbr4k1wZvzI6a9ya0GZ5Vd2C
         Or5JLZrf7phfXNDJdBb7ChS+hH3nqjccGBVqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zyy5E7JCspY9YFrZEI4CyZK4uD+ilkZBAIOqlBpYshsVaUzYOj3cIzTbpkK9s915ZG
         RBkH9JtZbF6OEg/KYLFw33NMC1rQQ1yX6/HLB+Nv7CI1GEgz3ndxt7gwHk3Ga8ezwPWf
         etV6creMuRuETEzboJkpFLTWTwmUZQZI0WGSU=
Received: by 10.224.60.70 with SMTP id o6mr3467039qah.280.1239310955342; Thu, 
	09 Apr 2009 14:02:35 -0700 (PDT)
In-Reply-To: <b4087cc50904091359q7cadc31cp150b2681775e7022@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116208>

On Thu, Apr 9, 2009 at 15:59, Michael Witten <mfwitten@gmail.com> wrote=
:
>> Perhaps --pause=3DN,M to say "Pause N seconds for every M messages",=
 where
>> Michael's --delay=3DN is just a shorthand for --pause=3DN,1 is what =
you want?
>> That is, reset the counter to 0 at the beginning, increment it after
>> sending each message, and when the counter is M and if you have more=
 to
>> send, you wait for N seconds and reset the counter to 0. =A0Then whe=
n you
>> have a series smaller than 20 you won't have to suffer from any arti=
ficial
>> delay.
>
> This sounds reasonable, but I would have:
>
> =A0 =A0--rate=3DM/N

I take that back. Clearly `rate' connotes an average rather than a burs=
t.
