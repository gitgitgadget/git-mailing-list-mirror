From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: filter-branch --env-filter GIT_AUTHOR_DATE
Date: Wed, 19 Jan 2011 11:08:48 +0100
Message-ID: <AANLkTi=TAhYeWbyocag2myBXA2TfH7_r=hmam51YKbhm@mail.gmail.com>
References: <AANLkTinx7cs6YTvSTTv-njHA+vk264u1EaJettSdBF9U@mail.gmail.com> <4D368C49.3080105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 19 11:09:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfUyu-0000A1-MN
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 11:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab1ASKJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 05:09:29 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:63303 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab1ASKJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 05:09:29 -0500
Received: by pxi15 with SMTP id 15so113012pxi.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 02:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=sxYlnZJ0fMaoiFiNtOVYNqb6qOaHTRikUWIAPa2vIxQ=;
        b=m2ZW7SOSsNmmUHZ/lTy9n7TG2YBb4ST6rg5zBXtEuYD/V5W3zAqd5G0gmPD7q/vbIi
         9UE4hJtm6mQ0xTDzYzd3AkMG1D5zanzBkpRovVJJ7/RKRZsPHAOHJxJ7j0qnyCB+vwl5
         4Ajc2QcjeHSE7e40i8I9joZTZy3Glv0kqOt90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cM6tS+O+dPf1uvkMJZuYPQUedAeEbsWIp1Cu5w7Bkn9qUJISXmU+uCXt9CcCmc5DI4
         e140nQkxbYtT3LUKEfVCjbLOgzJArcMzZ2iLFsS/NqOwfxYD/vgzWeTjONUvs85e2YGR
         PX9adI1LKEPNEywNpQg4KxZwXqjT9Fs8hEA6g=
Received: by 10.142.53.11 with SMTP id b11mr424791wfa.250.1295431768552; Wed,
 19 Jan 2011 02:09:28 -0800 (PST)
Received: by 10.142.76.11 with HTTP; Wed, 19 Jan 2011 02:08:48 -0800 (PST)
In-Reply-To: <4D368C49.3080105@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165255>

On Wed, Jan 19, 2011 at 8:01 AM, Johannes Sixt wrote:
> Am 1/18/2011 17:43, schrieb Tuncer Ayaz:
>> To fix invalid timezone info in a repo I ran
>> git filter-branch --env-filter '
>>   GIT_AUTHOR_DATE=`echo ${GIT_AUTHOR_DATE}|sed s/+0000/-0800/`' HEAD
>>
>> This fixed the invalid entries but the new timezone is -0700
>> instead of -0800. Is this expected?
>
> Parse error. You fixed it, but it is not fixed? So what?

Fixed because it is not +0000 anymore. Surprised because the new
timezone is -0700 and not -0800.

> What do you mean by "the new timezone is"? Do you mean "...is reported
> as"? If so, reported by which tools?

git log
git cat-file $REV

>> git version 1.7.4.rc2
>
> I tried your command, but the timezone was changed in the expected way.

How did you check?
