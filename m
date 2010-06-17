From: Daniel Blendea <bdaniel7@gmail.com>
Subject: Re: git pull (Your local changes to ... would be overwritten by 
	merge)
Date: Thu, 17 Jun 2010 14:18:21 +0300
Message-ID: <AANLkTinWS0zWhh0d-yrb7eWMEeQenoAF8tA6-l9BRP_q@mail.gmail.com>
References: <AANLkTinokUxiDdetcrsrlSExQ7hmhLS5szbTt9KzGKr_@mail.gmail.com> 
	<AANLkTimeIWseETfYiMajIqesjJ_p55pRislnQQIaCrbG@mail.gmail.com> 
	<4C19FBF8.6010709@drmicha.warpmail.net> <vpq4oh1zzfs.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 17 13:18:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPD7a-0003d7-0G
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 13:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759867Ab0FQLSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 07:18:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58853 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759761Ab0FQLSw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 07:18:52 -0400
Received: by iwn9 with SMTP id 9so6667985iwn.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=icJcYPwbfZ8CVgCHVos18sNd1CuIGtkQh96xlLmKiPI=;
        b=G/+4ssrJ2/Q2FawqVYKf9P4ekAkCmuZkC6dqPDvgJ80eFDc6B//e2kvxvM84uJ7l7H
         7Ek5dNWUQscZelHNBxxOLKPTZXqjq9QS7zOIuihVuZotCM0F/Yjl26v5yPCmpSMs4zde
         VQBFOOmfO7E1F67MVeMYQ1r77tM/VAFtD3ptQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BZLA7W4b/F9JLDpP0st8PP4wW2iGAhk+F6Ecnxc/NUXchYdwC5ZMNK2oLnGVHVgJ4G
         QUJ556cD2mkJZuAaQHTiiiw0taOhmB/B8WeoXWGt6j6AKSKbA4VELo5Td6CFnaYF+FKg
         /QBOo6QZVxNfeUr1S2loglWmMLr2wdLBrg3sw=
Received: by 10.231.141.15 with SMTP id k15mr609269ibu.161.1276773531119; Thu, 
	17 Jun 2010 04:18:51 -0700 (PDT)
Received: by 10.231.190.11 with HTTP; Thu, 17 Jun 2010 04:18:21 -0700 (PDT)
In-Reply-To: <vpq4oh1zzfs.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149299>

Windows 7, did not change anything related to crlf.

I solved the problem with

git fetch --all
git reset --hard origin/master

---
Daniel



On Thu, Jun 17, 2010 at 14:11, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> Daniel Blendea venit, vidit, dixit 17.06.2010 11:35:
>>> Hello,
>>>
>>> A while ago I have cloned on my computer a git repo.
>>> Since then, the developers have modified several files in the repo.
>>> Now I want to update my copy with the latest changes.
>>>
>>> I do 'git pull' but I get 'Your local changes to .... would be
>>> overwritten by merge. =A0Aborting.'
>>> I didn't modified any local file. I tried using 'git stash save' bu=
t no luck.
>
> Which OS? Do you have any crlf conversion enabled? Any filter set in
> .gitattributes?
>
>> Most likely the remote side did a non-forward push and brought you i=
n
>> that situation.
>
> A non-fast forward push would force a non-fast forward pull,
> possibly/probably with conflicts, but wouldn't trigger this message,
> which is generated before the merge is actually started.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>
