From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH WIP 0/3] top-level gitignore considered less harmful
Date: Sun, 27 May 2012 10:45:44 +0700
Message-ID: <CACsJy8AAqQ-VBhuEwH01ym16T2sMUMBJJhXpqBMD72B8tU7=2Q@mail.gmail.com>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
 <CACsJy8Bbn3hSDC_LmFtOXfJZhV9SqStwSSXFwcQLjDyUUAjOpQ@mail.gmail.com> <20120526214529.GA29463@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 27 05:46:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYURU-00026u-J7
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 05:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016Ab2E0DqT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 23:46:19 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:54222 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab2E0DqS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 May 2012 23:46:18 -0400
Received: by wibhn6 with SMTP id hn6so707985wib.1
        for <git@vger.kernel.org>; Sat, 26 May 2012 20:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KkPZqLbvyC1NpwF72f8tV57cQd6b4D8ejyquk3qUBVs=;
        b=SHyoTq8XbERJIBUz5dQZsQoGAzS70ADMRacRx9g4q9LSaUxk86GKkAsOVDiG1fx+tF
         UzzzD9qkIw2gFBOmMGZQ4On/Ge/bAj8tRd90qgtTI8o99j2xk+ohp6nr4WNeByLXma6k
         bbsKq1KiR1nuRUSUUeS5DExju7UomTQA1OC5rEHwT+5RtRbLmTQOtlvLJyac64+5qpeP
         JMj4AxPhX8GLUYw5rKiydPERADcwkMaGedTDRZUZuCZz55VVLb3i79ZyE0j1q52lzOPf
         36oqxw2GnXaUqU5c0nTSaHCjds4y9eZwoHM48oJkPSIV4gP4DIpKhSg+MwAH7lKs2nnE
         /xCQ==
Received: by 10.216.226.218 with SMTP id b68mr2162490weq.167.1338090374594;
 Sat, 26 May 2012 20:46:14 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sat, 26 May 2012 20:45:44 -0700 (PDT)
In-Reply-To: <20120526214529.GA29463@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198576>

On Sun, May 27, 2012 at 4:45 AM, Jeff King <peff@peff.net> wrote:
> On Sat, May 26, 2012 at 08:25:54PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Sat, May 26, 2012 at 7:31 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> > The result is not so impressive (i'm on -O0 though). Old webkit.gi=
t,
>> > before:
>>
>> (it's "git status" by the way)
>>
>> >
>> > real =C2=A0 =C2=A00m6.418s
>> > user =C2=A0 =C2=A00m5.561s
>> > sys =C2=A0 =C2=A0 0m0.827s
>> >
>> > after:
>> >
>> > real =C2=A0 =C2=A00m5.262s
>> > user =C2=A0 =C2=A00m4.407s
>> > sys =C2=A0 =C2=A0 0m0.850s
>>
>> and with your patch to redistribute .gitignore in webkit, so top-lev=
el
>> is small again:
>>
>> real =C2=A0 =C2=A00m4.185s
>> user =C2=A0 =C2=A00m3.271s
>> sys =C2=A0 =C2=A0 0m0.905s
>>
>> so my numbers look "ok".
>
> Is that last number just with the redistribution, or with the
> redistribution _and_ your patch? I'd like to see both to see whether =
it
> is the case that the two optimizations work together for combined
> benefit, or if doing one makes the other one pointless.

without my patch. redistribution with my patch is:

real    0m4.284s
user    0m3.407s
sys     0m0.864s
--=20
Duy
