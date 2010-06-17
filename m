From: Daniel Blendea <bdaniel7@gmail.com>
Subject: Re: git pull (Your local changes to ... would be overwritten by 
	merge)
Date: Thu, 17 Jun 2010 13:20:31 +0300
Message-ID: <AANLkTinQkCH5OhnoerCJs2x_2uChwaqVPApeezwcYy1o@mail.gmail.com>
References: <AANLkTinokUxiDdetcrsrlSExQ7hmhLS5szbTt9KzGKr_@mail.gmail.com> 
	<AANLkTimeIWseETfYiMajIqesjJ_p55pRislnQQIaCrbG@mail.gmail.com> 
	<AANLkTimakxkEzFHSwezpXelLV171zGFEQULNEVpJlrah@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Jun 17 12:21:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPCDg-0003E0-Uf
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 12:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429Ab0FQKVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 06:21:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62270 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab0FQKVD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 06:21:03 -0400
Received: by iwn9 with SMTP id 9so6621567iwn.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oXtMZ3mNw6zR4WaAE44efXS6Jlytem19VN7vbtrqjVQ=;
        b=u1RIIHVYqkepiRZ1GRYIxPm1AtFhgLKOSRS6lJFDzJkw4eDS04vPWZwGQTsysr8dBl
         vKRBJVOKX5YJdRTYSS8obbZN4/VyW2xrssWQ7zOF2aPF9mkxmxdSyL5dzoqvAGq+L/wk
         UVAbpxN93oikjF3LmXmPGDzkEQfAcQZfDlT9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=navmRXFzVv9KY0XVci3g8+B+STaOMheiiJpR3YadSJJrLTnLyIn1UnX6npulLQR1/L
         3aVCJNE2wrkYQi+Za9gksHXFNVZgHvfB+tWT1CFWePds7kUV0A8CNv/6fgdjdsg2h0IH
         COvNz3ARp3UfeeoVZtAQdkqLp7VrblybecdrA=
Received: by 10.42.7.210 with SMTP id f18mr3590376icf.9.1276770061382; Thu, 17 
	Jun 2010 03:21:01 -0700 (PDT)
Received: by 10.231.190.11 with HTTP; Thu, 17 Jun 2010 03:20:31 -0700 (PDT)
In-Reply-To: <AANLkTimakxkEzFHSwezpXelLV171zGFEQULNEVpJlrah@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149295>

I have no idea, I know git just barely to be able to update my copy
once in a while, then build it to get the binaries.
I didn't modified anything and the build script builds the binaries in
a different location.

The file which threw the first error was already in my copy and it was
modified in the remote branch.
---
Daniel



On Thu, Jun 17, 2010 at 12:46, Santi B=E9jar <santi@agolina.net> wrote:
> On Thu, Jun 17, 2010 at 11:35 AM, Daniel Blendea <bdaniel7@gmail.com>=
 wrote:
>> Hello,
>>
>> A while ago I have cloned on my computer a git repo.
>> Since then, the developers have modified several files in the repo.
>> Now I want to update my copy with the latest changes.
>>
>> I do 'git pull' but I get 'Your local changes to .... would be
>> overwritten by merge.=A0 Aborting.'
>> I didn't modified any local file. I tried using 'git stash save' but=
 no luck.
>
> Are they known to git? What is their status (git status)?
>
> If they are not known to git, it seams that there are *new* files bot=
h
> in the remote branch and the working copy (new files in the working
> copy are not saved with 'git stash save').
>
> I would rename/mv the conflicting new files in the working copy,
> perform the pull and maybe compare the new files from the branch with
> the ones from the working copy.
>
> HTH,
> Santi
>
