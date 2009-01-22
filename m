From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Thu, 22 Jan 2009 00:07:27 -0500
Message-ID: <81bfc67a0901212107i466335b3h863745902fb688c@mail.gmail.com>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
	 <81bfc67a0901210817r49971c09kea9dc8ee5ae21572@mail.gmail.com>
	 <200901211949.53432.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Thu Jan 22 06:09:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LProG-00048c-4j
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 06:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbZAVFHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 00:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbZAVFHa
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 00:07:30 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:45102 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbZAVFH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 00:07:29 -0500
Received: by fxm13 with SMTP id 13so835846fxm.13
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 21:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AW4Zc8d98hDdar0J3BwdcW3F16voXHNUk4GQkckgg8A=;
        b=VSI65KabmBgsqrSmTMDrQRQCza7SK/bZdXA54OwhHcPtzvl1UZN8ZyGGLwadoV9Qw0
         Tzh56lKaD1miM4szOQ4z2iMYkVEFjAXhsX0IN5ABtm1m4dmsvr3GuOz1SLbWtr5J76uI
         cWZYuonaEv0uSDIunWPYPdXisgpM+f1JtKTY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MZgjUXnhE2BxhM9dKPp2dD+KCTRuXLMXxw/gGN7ocq9vPx+4J7Y/ziAQmdAyQQpR1e
         jl+KzuSPG5Go3VanKs2zCHou+cbVYA7aTvEWr+0QfV9oiOeI8dy3x5W0GyWP2FT9gjYZ
         lLbXNt5/dKtt6PA4w67vy+GnXClXNRDngCjsM=
Received: by 10.223.111.19 with SMTP id q19mr1051749fap.58.1232600847169; Wed, 
	21 Jan 2009 21:07:27 -0800 (PST)
In-Reply-To: <200901211949.53432.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106720>

> This looks to me like no merge will happen if --no-prompt/-y or
>  mergetool.prompt is set to false. Have you tested with this option or
>  have I misread?

sorry haven't tested as I don't use that. will test in the morning...
if it doesn't work will try to get it working.

>  Also, I think you've lost some tabs. Mergetool does have some
>  inconsistent tabbing but they way I've been aiming towards (which
>  matches most, but not all of git-mergetool.sh) is to use tabs == 8
>  spaces for indents but to indent each level by 4 spaces. e.g. three
>  levels of indent is one tab plus four spaces.

thanks wasn't sure on the indentation, I set tabstop to 4 spaces in
vim so my tabs look like your spaces. I'll correct in the next case.

>  It might be quite nice to offer the option of directly using an 'ours'
>  or 'theirs' as an alternative to skip for binary files. A bit like
>  symlinks are handled in mergetool.

I could look into it... at the same time I don't have a good test case
so I'd rather leave it to someone else.


> I'd like to keep (additionally) the behaviour, that the merge starts
> with just pressing <Enter>. Because what you mostly want to do, when
> using git-mergetool, is actually merging.

I'd thought of that... and I'll see what I can do, although to me it
doesn't matter much.

> This doesn't seem right.

erm.. yeah... I'll fix it
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
