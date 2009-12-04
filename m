From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 3 Dec 2009 22:49:54 -0500
Message-ID: <76c5b8580912031949k7f4193f9q94f9a2040b877571@mail.gmail.com>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
	 <4B17ABE3.6060003@drmicha.warpmail.net> <m2d42w5fqq.fsf@igel.home>
	 <4B17D078.6080000@drmicha.warpmail.net>
	 <20091203150323.GI23717@inocybe.localdomain>
	 <7viqco54xh.fsf@alter.siamese.dyndns.org>
	 <20091203202738.GP23717@inocybe.localdomain>
	 <7vfx7r4we7.fsf@alter.siamese.dyndns.org>
	 <20091203220020.GS23717@inocybe.localdomain>
	 <7vbpif4rn2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Todd Zullinger <tmz@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 04:50:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGPBK-0005Xx-DQ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 04:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbZLDDtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Dec 2009 22:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753922AbZLDDtt
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 22:49:49 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:44366 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbZLDDts convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2009 22:49:48 -0500
Received: by iwn1 with SMTP id 1so1410072iwn.33
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 19:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JPIvJJfv5AHEpwqRK7nR10NI+z4dgKVxqgeyXdYBIVM=;
        b=ksR1eXbsm/MGMER4unVE0kqoDaZYMXDK1dbFhJMy2kpAYVL8FqP2UoI1/Ac5537j+J
         nc9llSOtMJMbTARWRS4pqItthaZT601+yYJf4bInsk2+q7s+6VVGcIm5rglSCYH2vM0E
         IuZF5ul3Trlo0uANhNm2JTslF5y3SfcHmhm+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ePTNGTFLSdapZq8skd5INis4xxxnqIBpIo6ulIPHg/pjFvaeqr0MpjLY21PjJGJGE5
         DNJv5dIdkgEKOzloTrmKaXAU9oCu0rMWAxVFYJqt3SxfGVc2fLWlgYBdio8doSAWS7RS
         nd149V58W6lFDGO6NpeWvlHcj6Hprgl01DAQI=
Received: by 10.231.153.69 with SMTP id j5mr1672260ibw.33.1259898594608; Thu, 
	03 Dec 2009 19:49:54 -0800 (PST)
In-Reply-To: <7vbpif4rn2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134490>

On Thu, Dec 3, 2009 at 5:30 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Todd Zullinger <tmz@pobox.com> writes:
>
>> I tested with this in Documentation/manpage-base.xsl on a CentOS 5 b=
ox
>> and it builds fine, leaving no cruft in the man pages regarding the
>> man.base.url...
>>
>> <!-- set a base URL for relative links -->
>> <xsl:param name=3D"man.base.url.for.relative.links"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0>/path/to/git/docs</xsl:param>
>>
>> Of course, the relative links looked just like they did in older
>> docbook releases:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A01. Everyday Git
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 everyday.html
>>
>> Is it worth the effort to have @@MAN_BASE_URL@@ in
>> Documentation/manpage-base.xsl or similar and replace it at build
>> time?
>
> I think it depends on the likelihood that a distro has xmlto so old t=
hat
> it does not understand --stringparam yet it uses stylesheet so new th=
at
> setting the parameter makes a positive difference (either it gives th=
e
> full URL or at least squelches the "You should define the parameter"
> noise) in the output.
>
> I am guessing that the answer would be that is a very unlikely combin=
ation
> and not worth worrying about it, but I've been wrong before in this e=
xact
> area ;-)


Hello,

We have RH with xmlto 0.0.18. I was getting ready to update our
installation to 1.6.5.4, but as i understand the documentation will
not be fully available untill this issue is resolved. Could you,
please, advise if this is going to be in next 1.6.5.5?

Thanks,
Eugene
