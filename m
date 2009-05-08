From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Tests in Cygwin
Date: Fri, 8 May 2009 11:28:37 +0200
Message-ID: <81b0412b0905080228j6b114631p35395464c0c98540@mail.gmail.com>
References: <83prfbhasp.fsf@kalahari.s2.org>
	 <4A01E64C.7050703@SierraAtlantic.com>
	 <7vvdoet13g.fsf@alter.siamese.dyndns.org>
	 <4A028A0A.5070003@viscovery.net> <4A030277.2000708@SierraAtlantic.com>
	 <20090508020037.GA1264@coredump.intra.peff.net>
	 <4A03CAFE.4060503@viscovery.net>
	 <7v4ovwaygf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	Don Slutz <Don.Slutz@sierraatlantic.com>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 11:28:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2MNr-000448-AB
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 11:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265AbZEHJ2j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2009 05:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754715AbZEHJ2j
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 05:28:39 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:47918 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbZEHJ2i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 05:28:38 -0400
Received: by bwz22 with SMTP id 22so1244277bwz.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NL/RxWtaEehvOO28qpK3R7PN0t8gXtIdgI+MU1rmlc4=;
        b=RQmxjH4DWvj+YU/a3zBCNpnQsocX+Njh6Jha1hCWwtm3aMyP9ejbHLEZlGaBxQDpda
         f3BTJhqV9WXSJx1lRL79Q06IESmXBYBbmVqneoPM3ltYn0kTl110jpVKvzoIDWJXK7VN
         h9rxrNVY9MXFAKLJnZdpdZaHvbNUhkcdT0SQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xyeiAMdqlg2asVpcW8TPUP9mppscIaByPG0L8uNeq3aZJ2yNZx3lZpLR7S+oRh1iic
         pdA7Qd0c2lauKOuWcsmm7VMvUxN0Pr/Q0D3y8Wzi9NoVDtt1+n9m1mzfoBMoRcpfQqgE
         ENpK50KyPxc6P80pLfC5Pz0UUvsZUlHIQWJ6Y=
Received: by 10.204.124.7 with SMTP id s7mr3387588bkr.105.1241774917730; Fri, 
	08 May 2009 02:28:37 -0700 (PDT)
In-Reply-To: <7v4ovwaygf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118595>

2009/5/8 Junio C Hamano <gitster@pobox.com>:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>>> =C2=A0 +for prerequisite in $(echo "$1" | tr , ' ')
>>
>> So, you dislike the space separator, but you also dislike the IFS ga=
mes
>> that save a few new processes? ;) (Think of Windows, where fork is e=
xpensive).
>
> You can play IFS=3D, game, then ;-)
>
> I have to admit that it feels so 80'ish, back when our UNIX machines =
were
> so slow that we tried to shave every fork+exec from our shell scripts=
 by
> using built-ins when possible, though.

Well, on Windows (at least with Cygwin), it is 80's still. My workstati=
on
(a 2.4GHz P4, 70C hot, 2Gb Dell monster) is about 100x slower than my
old Asus laptop (a 384Mb, 1200Ghz Pentium-M) in starting a trivial prog=
ram
("int main() { return 0; }").

I'm trying to save where possible on cygwin, whatever cost.
