From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Narrow clone (Re: features from GitSurvey 2010)
Date: Thu, 3 Feb 2011 15:38:30 -0600
Message-ID: <20110203213830.GE16391@elie>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino>
 <201102011451.17456.jnareb@gmail.com>
 <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
 <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com>
 <AANLkTi=KUpYJBRMp9ti0h+g6a0iTw4D113rTgfTpR8C4@mail.gmail.com>
 <alpine.LFD.2.00.1102011647000.8580@xanadu.home>
 <FE2BDD68-9CFA-4CBB-9F66-32BE6CF3E174@adacore.com>
 <20110203173835.GC30341@elie>
 <5E0364BF-35CD-4797-BBAF-98A54D1F7F6E@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 22:38:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl6t0-0003c3-Mj
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 22:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab1BCVih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 16:38:37 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42870 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab1BCVig (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 16:38:36 -0500
Received: by eye27 with SMTP id 27so993606eye.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 13:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SNxrK7bPgWsoh8G6hIdNtSYOc6DW3hOKadan0/AF6Nw=;
        b=bUEKCm4cNUI/8oqOYPN5g94UKk/FPaq6uh/QEWe3LFoeJI3OhOzXB5ujF3OPIv2uSv
         vzSh0cwlWkXHZqrNBLcY3N7/be06izm/soO4H0EhLYsjpT/q/LdbHTWnFZRiXHTqJiWV
         Fw0xtEqdRCrYzGsxDyZ0KHU9tkOPOsnYtCBp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=C3C9ucnCyekQbsG8clPFiJg3as57TjBnXUKqM8BHaXep57eex5sG0JKNUgfNQeK2Hk
         AAaAt0WJCi9vPf3NAJS7IYhTIELXqh3fh0g9RPeE3noPxg6Gywia7mNqZ19a2Ymo7Jwj
         pElFH3b0+mUNzTUlK6Os685m+ciP8xZfcduPM=
Received: by 10.213.105.80 with SMTP id s16mr9155532ebo.18.1296769115653;
        Thu, 03 Feb 2011 13:38:35 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id b52sm992958eei.7.2011.02.03.13.38.33
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Feb 2011 13:38:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5E0364BF-35CD-4797-BBAF-98A54D1F7F6E@adacore.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166002>

Geert Bosch wrote:

> Of course the resulting git repository will be less than useful.
> And that's where the narrow clone comes in handy...

Side note: while clearly I don't consider this particular use case to
be a strong motivation, there are other use cases that do strongly
motivate the feature.  And if this particular use case happens to
motivate someone to work on it, I'd be happy for it still.  I just
hope the documentation does not encourage people to do such things.
