From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Running git on Windows command line
Date: Thu, 22 Jul 2010 22:41:23 +0200
Message-ID: <AANLkTin-RMEOfc7FlfnQfTgzxMfV-Vq6r5ahkP6P6_SJ@mail.gmail.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB939B8A@FL01EXMB01.trad.tradestation.com>
	<AANLkTimXZtlRKlAVuFH5TzzQ1z19ddYazIRKIgGALMpZ@mail.gmail.com>
	<1A9EA7E081C3FE46A0F446FFB66D10EB939D37@FL01EXMB01.trad.tradestation.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 22:41:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc2aB-0005pN-JI
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 22:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756337Ab0GVUl0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 16:41:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59448 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab0GVUlZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 16:41:25 -0400
Received: by wyf19 with SMTP id 19so976304wyf.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=gmoLiQFCM/Bhl5jxh7FQMucXLH5flnkTNfszHTA3PmI=;
        b=thLWhAnDCeyqDqWSXfKoY7rwA6JIiMixbi2SCPtLMzFq5Miuuy5kLMyFzbCVIvUEzC
         kKi6anlowk2BswL16p1VuKUMWiitPu9xC+0B/03aoyIxG69oKWkwNfcg7KrJV21KyDcY
         ZVq3MbgEKV4/P3LgkuhvZEBF05CY75EVIuISI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=V8ioziOwG4Cs8v9i7lyBrlTvvpBjfN5MyCK0pJxEKYIcNYLDkt+iS73i6roriMOs1t
         ZspnmB2GZW8TkfaD0xRbOqg68++nBGnAdAKDTR70ejdFMfxVSIP8SttSZ8OY0G7E5vXO
         k1r1wX+Ruz69lUfsuzLzvs7WOdFo6vFrEPNNU=
Received: by 10.227.128.210 with SMTP id l18mr2439692wbs.189.1279831283895; 
	Thu, 22 Jul 2010 13:41:23 -0700 (PDT)
Received: by 10.216.70.67 with HTTP; Thu, 22 Jul 2010 13:41:23 -0700 (PDT)
In-Reply-To: <1A9EA7E081C3FE46A0F446FFB66D10EB939D37@FL01EXMB01.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151481>

On Thu, Jul 22, 2010 at 10:02 PM, John Dlugosz
<JDlugosz@tradestation.com> wrote:
>
>> The msysGit (the development environment for Git for Windows)
>> installer does not modify the system-wide path, but the Git for
>> Windows installer does. Perhaps you've previously been using msysGit
>> instead of Git for Windows?
>>
>> --
>> Erik "kusma" Faye-Lund
>
> I've only installed "msysgit". =A0The item in the path, which I assum=
e was added by the option to "Git from command prompt", with the other =
two choices being "Git bash only" and "git and included unix tools from=
 command prompt". =A0I did notice that the exact wording, if not the ch=
oices meanings (I'm not sure), seemed to change some time within the la=
st two years.
>

It sounds to me like you've installed indeed Git for Windows (which is
the end-user product from the msysGit-project); the msysGit installers
doesn't show a wizard with questions, it just installs a
self-contained development environment.

You can tell the packages apart by the name:
* Git-something.exe and PortableGit-something.exe are installers for
Git for Windows.
* msysGit-netinstall-something.exe and
msysGit-fullinstall-something.exe are installers for msysGit, the
development environment used to develop Git for Windows.

I hope this clears up a bit.

--=20
Erik "kusma" Faye-Lund
