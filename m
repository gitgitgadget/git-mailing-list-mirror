From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH v2] Extend sample pre-commit hook to check for non ascii 
	filenames
Date: Fri, 15 May 2009 12:52:41 +0200
Message-ID: <46a038f90905150352q76157227q24c6b8c0befa4108@mail.gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
	 <m3r5yukv6g.fsf@localhost.localdomain>
	 <20090512214250.GA22974@macbook.lan>
	 <200905122356.00659.jnareb@gmail.com>
	 <20090514175850.GA26267@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 15 12:52:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4v25-0005FT-Ku
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 12:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760409AbZEOKwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 06:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760723AbZEOKwm
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 06:52:42 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:57025 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759692AbZEOKwl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 06:52:41 -0400
Received: by bwz22 with SMTP id 22so1821082bwz.37
        for <git@vger.kernel.org>; Fri, 15 May 2009 03:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ArjZgSI5FT9emJB+HPcXRlgZWS2wqU/G+FzhjhdqsQ8=;
        b=g/5SUBaIGsnevdBWDquuGeiyXSsPr1FyiM3rqLTFXzaQ8Biw7GHz2WTsUpt+BnAnFv
         yreoPYwgB9vBMJcioclknSe5jXTY7Tl8h2/kv3lBMb6OUB+zmG1S2pHwJJrtKD+KfVK0
         9Kg/4Ucpernxosf/AhzP+d54ArgjU4v9/2qrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mPSdVbVDzCeaZZrO5wx2CB//Q5FuG7hVPQ0aenoTlp0woLlRzEkQ75sBGfCDvkgpu6
         6FjgDOj5Iin4AUsVXo69DdHru/tk63PlU6iuhi1IqhYod31PFkHG4uY9mvUKr6XE56jA
         7V6FROo9faXYsBmA1Aigkr/vXztk2VOMUmFkM=
Received: by 10.223.110.11 with SMTP id l11mr2346804fap.50.1242384761210; Fri, 
	15 May 2009 03:52:41 -0700 (PDT)
In-Reply-To: <20090514175850.GA26267@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119253>

On Thu, May 14, 2009 at 7:59 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> At the moment non-ascii encodings of filenames are not portably converted
> between different filesystems by git. This will most likely change in the
> future but to allow repositories to be portable among different file/operating
> systems this check is enabled by default.

Nice!

 - It'd be a good idea to add to the mix a check for filenames that
are equivalent in case-insensitive FSs.

 - Should all of this be a general "portablefilenames" setting?

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
