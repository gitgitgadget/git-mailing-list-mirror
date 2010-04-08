From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull with "no common commits" : danger?
Date: Wed, 7 Apr 2010 22:43:47 -0400
Message-ID: <h2g3abd05a91004071943g6352370fnc68b81c73a204bb0@mail.gmail.com>
References: <v2t3abd05a91004071856s5811e086q17241996a359e172@mail.gmail.com> 
	<4BBD3A98.2020207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 04:44:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzhj6-0002XV-Pn
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 04:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab0DHCoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 22:44:12 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:41825 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab0DHCoI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 22:44:08 -0400
Received: by bwz1 with SMTP id 1so1407925bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 19:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=Le56vmXvhNpdHaWLYB5fSj9b/mZA7m6vP58R0oVhMgg=;
        b=XqXdWNoVPRg/GlmibaMch2JQPVT0bvFnVrQTy3g8fDVCCuLA2iratdeifdIyaxiHLs
         uDeXDaurCZTmh8jSk+WwnKn6K3tk/43K30ynCnTtmbxn2Io9rRjzs2hliv8zPDiGmZER
         hGeq1ZmQFM12LuwtWkj4kbyOkwqOPBYsEApqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YUTAdwwnc8ETGPfpRWwhuWmsoE6hwqw8M0e2CB2HhNvzFScIoiAfOjEnn+JUZwv7iu
         Kd+96rh5eK4VF9LW2dCQmxJrZkKs7AsGUisOL0NKvU/RpstuGDj7mUaBOR6WX3EDXLsn
         h/OHHoN/Fb0H8KSq9cOa2VTHWx2byuIs3eBD0=
Received: by 10.204.63.196 with HTTP; Wed, 7 Apr 2010 19:43:47 -0700 (PDT)
In-Reply-To: <4BBD3A98.2020207@drmicha.warpmail.net>
Received: by 10.204.163.129 with SMTP id a1mr10033624bky.144.1270694647150; 
	Wed, 07 Apr 2010 19:44:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144308>

> Aghiles venit, vidit, dixit 08.04.2010 09:56:
>> Hello,
>>
>> I mistakenly pulled a project into another project. I had the
>> "warning: no common commits" but the pull did proceed.
>> I am wondering if, from a usability point of view, it would be
>> best to avoid doing so by default.
>
> Puleeezze: No animals were harmed during the process, right? I mean, no
> data loss, all you have to do is a git reset. Let's try and not make Git
> into "Are you sure"dom.

How many times did you see that message? If you saw it, it was probably a
mistake. I think that it is a safe bet to assume that whoever does that won't
complain to type something like: git pull --no-common-commits-ok

I manage many git projects and this happens from time to time, mainly
because of tiredness. I simply consider the proposed behaviour more
natural.

Git is not the bare bone tool set anymore, it aspires into becoming a user
friendly tool, usable by "the masses". And don't worry, following some simple
usability rules won't make git less "cool".

Now, that was just a suggestion,

  -- aghiles
