From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] remove doubled words, e.g., s/to to/to/, and fix related typos
Date: Wed, 13 Apr 2011 15:26:06 -0700 (PDT)
Message-ID: <m3aaft3i2d.fsf@localhost.localdomain>
References: <87d3kq6tz7.fsf@rho.meyering.net>
	<1302719749.21047.6.camel@drew-northup.unet.maine.edu>
	<87mxjtn8x7.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:26:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA8Vr-0003Xz-HS
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 00:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933309Ab1DMW0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 18:26:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52076 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933284Ab1DMW0J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 18:26:09 -0400
Received: by fxm17 with SMTP id 17so771959fxm.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 15:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=NzkrfqjF4anZLk4NMamWqmSSys/syIsxHWHzSo9vk+c=;
        b=xWhNSAhv/exyL3rUdmZAbLBQP4PhqMbWSMcMnv/mKq4LgRWW5Q9+VzBSKyTkYwuANe
         iVYIQ6z3wwBrtnWkQvoeirEkDPpm2IMW/NhbzeQrDBJPpM8MOvqWHsN/XDF9nwkcUXO1
         IPb67xE56sVRnvDLs7hpPce9wGdL+2hwAtYrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=LnF3CsMpWDiVCX3cT4HRumwaDJCDmuWiWkFDqfVk/rXRU3SqCaLQjtVxLBWAdgjpaR
         daXcf/PvYDMqoXyA6lTwOrFW//jeSjmPBrFEiMZ6RJVnM85nnDBoKTjaYaNusPrL5/dI
         RMTIdXvZqmd1UYInTCtvZ0YP0GRQwANYcrTgE=
Received: by 10.223.97.142 with SMTP id l14mr1497fan.111.1302733567883;
        Wed, 13 Apr 2011 15:26:07 -0700 (PDT)
Received: from localhost.localdomain (abwc79.neoplus.adsl.tpnet.pl [83.8.226.79])
        by mx.google.com with ESMTPS id x16sm305486fal.43.2011.04.13.15.26.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 15:26:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3DMPVAF031375;
	Thu, 14 Apr 2011 00:25:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3DMPFr1031370;
	Thu, 14 Apr 2011 00:25:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87mxjtn8x7.fsf@rho.meyering.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171494>

Jim Meyering <jim@meyering.net> writes:
> Drew Northup wrote:
>> On Wed, 2011-04-13 at 17:39 +0200, Jim Meyering wrote:

>>> I found that some doubled words had snuck back into projects from
>>> which I'd already removed them, so now there's a "syntax-check" makefile
>>> rule in gnulib to help prevent recurrence.  Running the command below
>>> spotted a few in git, too:
>>>
>>> This patch is relative to "next".
>>
>> Jim,
>> Try putting the output of git format-patch into your drafts folder, then
>> open that draft in your mail client. The output of format-patch isn't
>> meant to be pasted directly into a mail message.
> 
> I hope I haven't caused Junio or anyone else undue trouble.
> I know well how format-patch output can be used, but in the vast
> majority of patch-including messages I send, I include format-patch
> output mainly as an FYI, *following* commentary that does not
> belong in the log, so it's ok there -- desirable, even.
> 
> I find it slightly backwards to have to put non-log (i.e, intro
> commentary) *after* the real log, and that's why I've developed
> this habit.
> 
> I'll try to remember to do it the other way when the
> recipient is more likely to apply the patch.

You can put patch _after_ commentary, but if you do it this way you
should include "scissors" line to make it possible to extract commit
part automatically by "git am --scissors", and remove unnecessary
headers.

In other words you had:

> From d21d6f61bbeeba4a754cdcded66ca86a709695ee Mon Sep 17 00:00:00 2001
> From: Jim Meyering <meyering@redhat.com>
> Date: Wed, 13 Apr 2011 17:34:44 +0200
> Subject: [PATCH] remove doubled words, e.g., s/to to/to/, and fix related
>  typos
> 
> Run this command to identify suspects:

and you should have

  -- >8 --
  Run this command to identify suspects:

or in case author is different from email from

  -- >8 --
  From: Jim Meyering <meyering@redhat.com>

  Run this command to identify suspects:

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
