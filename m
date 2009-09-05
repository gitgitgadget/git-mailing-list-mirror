From: demerphq <demerphq@gmail.com>
Subject: Re: `Git Status`-like output for two local branches
Date: Sat, 5 Sep 2009 16:58:36 +0200
Message-ID: <9b18b3110909050758k597f917fn3baefa5fdb4741a0@mail.gmail.com>
References: <c115fd3c0908311320q46d585d2v457ccd0f411a6404@mail.gmail.com>
	 <20090902075713.GA1832@coredump.intra.peff.net>
	 <fabb9a1e0909020118m2fe2e6e1g79cc83ce941ac000@mail.gmail.com>
	 <20090905081726.GA7109@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 16:58:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjwiz-0006Ck-BH
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 16:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbZIEO6g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Sep 2009 10:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbZIEO6f
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 10:58:35 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:62568 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZIEO6e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Sep 2009 10:58:34 -0400
Received: by ewy2 with SMTP id 2so1117446ewy.17
        for <git@vger.kernel.org>; Sat, 05 Sep 2009 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ooEQ2OXNiCvV9c8Bm1VKLLrv/oxvJ1QoJri97vgvrrw=;
        b=edOEHAQu9Vpm65zXWKc3QaKcnLylXQHD7U5+dnS82YSU/pxHmqT/LsZOaMAvCgcjTT
         IJ2HzJq8tAcP50U7VxKx3X0e+askpaOJZ0PMtUPxwqeMfLYWnMztB1YHB/zlO49VOY8Y
         BsC+Zp8aYoNcQAsL49ZhDSJDnfRzohIIM1YyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r4GO4NLs3+2JYhbH3Khr46m/VAREuTOjSfG/kGUeu8gSUyBbweCpYC5DVMPwUfjOwa
         GFAXcobUXFWeO7bxZOKnecGQNh1c7VBufujB4ZrsVexAg9GGqI8HR/WblqM2NOcu0VeV
         IgzMB9PzcwrAdW6Gk2RqdoBemNo89jJvLvyvU=
Received: by 10.216.7.67 with SMTP id 45mr1071827weo.95.1252162716299; Sat, 05 
	Sep 2009 07:58:36 -0700 (PDT)
In-Reply-To: <20090905081726.GA7109@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127818>

2009/9/5 Jeff King <peff@peff.net>:
> On Wed, Sep 02, 2009 at 10:18:54AM +0200, Sverre Rabbelier wrote:
>
>> On Wed, Sep 2, 2009 at 09:57, Jeff King<peff@peff.net> wrote:
>> > =A02. Count the commits on each side that are not in the other.
>>
>> [...]
>>
>> > =A0 =A0 =A0You can also do that by parsing the output of:
>> > =A0 =A0 =A0 git rev-list --left-right $a...$b --
>>
>> Perhaps it is useful to introduce a --left-right-count or such?
>
> I'm not opposed to that if it is something a lot of people found usef=
ul,
> but I am not sure we have established that as the case (I am curious =
to
> hear from Tim what his actual use case is).

It would be useful in for instance prompt status line. At $work we
have a number of people using a prompt that includes the result of
parsing git-status, but something --left-right-count would be much
nicer, and if i understand it, more efficient (although maybe im
wrong). In the prompt they use a number of different unicode arrows to
show what has happened, with a Y type thing for diverged.

cheers,
Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
