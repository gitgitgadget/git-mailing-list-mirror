From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2009, #01; Wed, 05)
Date: Thu, 06 Aug 2009 01:24:24 -0700 (PDT)
Message-ID: <m3vdl1pcyb.fsf@localhost.localdomain>
References: <7v8whxx6gx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 10:24:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYyHR-0007mK-K6
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 10:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbZHFIY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 04:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754341AbZHFIY2
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 04:24:28 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:34848 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbZHFIY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 04:24:26 -0400
Received: by fxm28 with SMTP id 28so589222fxm.17
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=lvBEVveXknF1Ln4xRF9NskFmJJ8UFF+IpGYa3v4wVnY=;
        b=ayGs2DfRTkdJCts0wxMMHsvixUe64UbeuDoB1exGUXrNpe6AbU5Nf5aZH57XsP+Gjf
         ilNrBBfTKmlkI9RcCoAZ7/+sd4brPtk2IZ3kUUapMLfEJh/VdzgoIL/fda7xBVo5bG65
         s5G5/mbkEfV5j5D2bDljAIYWIEzgDGDA3vaL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=DrYS/zDn12Ajsh2ZBwmHrK9gGgt1pCH0cpag1Idw90ejEVVIuyNUUQsGfoS+t+jxvP
         AavfRLyX0Sro5iZnYLk/ajwRtIkwzqJMn6gLucvM1WBAmtWJ2r8Evz+3qQXeJBgTb3vG
         aCzmfY9dp+1TnjZMA/W6nBQoLJuHuPL+EFsEI=
Received: by 10.86.49.8 with SMTP id w8mr4749494fgw.37.1249547065464;
        Thu, 06 Aug 2009 01:24:25 -0700 (PDT)
Received: from localhost.localdomain (abwm109.neoplus.adsl.tpnet.pl [83.8.236.109])
        by mx.google.com with ESMTPS id l12sm9098977fgb.23.2009.08.06.01.24.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 01:24:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n768OKNT029349;
	Thu, 6 Aug 2009 10:24:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n768ODDU029345;
	Thu, 6 Aug 2009 10:24:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v8whxx6gx.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125051>

Junio C Hamano <gitster@pobox.com> writes:

> * jn/gitweb-blame (Sat Jul 25 00:44:10 2009 +0200) 10 commits
>  + gitweb: Create links leading to 'blame_incremental' using
>    JavaScript
>  + gitweb: Incremental blame (proof of concept)
>  + gitweb: Add optional "time to generate page" info in footer
>  + gitweb: Add -partial_query option to href() subroutine

>  + gitweb: Use light/dark for class names also in 'blame' view
>  + gitweb: Add author initials in 'blame' view, a la "git gui blame"
>  + gitweb: Mark commits with no "previous" in 'blame' view
>  + gitweb: Use "previous" header of git-blame -p in 'blame' view
>  + gitweb: Mark boundary commits in 'blame' view
>  + gitweb: Make .error style generic
> 
> Will merge soon.

Actually I'd rather only the first part (the 'blame' view
improvements) were merged.  

The 'blame_incremental' part is still in flux; I'll send in a while
next iteration of it.  Currently most important part is that
"Incremental blame (proof of concept)" turns off sending
application/xhtml+xml because my browser (Firefox up to 1.5) turned on
strict mode also for JavaScript, which means no innerHTML.  Also there
are quite a few items on the TODO list...

I'm sorry that I haven't made it clear.  I should have send those two
parts as a separate series, in separate threads.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
