From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] Add test for using Git at root of file system
Date: Thu, 11 Feb 2010 17:01:53 +0700
Message-ID: <fcaeb9bf1002110201u44e7dbf4r8722152d5f63d51@mail.gmail.com>
References: <1265734950-15145-1-git-send-email-pclouds@gmail.com> 
	<1265734950-15145-4-git-send-email-pclouds@gmail.com> <4B72B035.9080603@jonny.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?UTF-8?Q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>
X-From: git-owner@vger.kernel.org Thu Feb 11 11:02:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfVsJ-0007kI-IY
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 11:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab0BKKCO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 05:02:14 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:45220 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab0BKKCN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 05:02:13 -0500
Received: by pzk2 with SMTP id 2so387677pzk.21
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 02:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=AWEjE61Tq1FUS/07x6RfA65iPmx798XBqTJhwL8dWRo=;
        b=a/7RtNlt6vmEXvFD5YZTtw6niF9e4LS3Nhe71KHej4/9bKPwHVb/n7dEqVhYKNkXVJ
         rMKw5OkBeXLAMJ0ZR0lHx1IKvgtWXogI41NIYFJbuSF/tMzjQ2P7FFW1UeTK1sSY/VQ0
         NXJz4tzs+9dWv0iJMhh/LaIZwBclNn67iiInU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SlVNTUfSp3/Juymb3NeN9zDMuysQ0hZBquevdFj8Kn46QR/LdzjAaAHlp5lD4K4LaK
         yaa8/UW+d7YGThwy6Sd1lC3NubcRWGo65fMeYXcDkwoyXDww64ZzhJ2p4TdqhnD+1jf0
         602dSS4q8vNdeZC22fDIsmJ0EA27S5X72jifM=
Received: by 10.114.119.3 with SMTP id r3mr1039568wac.16.1265882533090; Thu, 
	11 Feb 2010 02:02:13 -0800 (PST)
In-Reply-To: <4B72B035.9080603@jonny.eng.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139580>

2010/2/10 Jo=C3=A3o Carlos Mendes Lu=C3=ADs <jonny@jonny.eng.br>:
>
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>
>> This kind of test requires a throw-away root filesystem so that it c=
an
>> play on. If you have such a system, go ahead, "chmod 777 /" and run
>> this test manually ("make test" with root permission won't work).
>>
>
> I've seen you have a prepare-chroot.sh file in there. =C2=A0Is it wor=
king or not?
> =C2=A0I mean, did you create a chrooted environment to test, or there=
 was any
> problem with that?

That means if you already have a chroot environment, use it. Or you
can use prepare-chroot.sh to create a new chroot environment. Yes I
used prepare-chroot.sh for my testing.
--=20
Duy
