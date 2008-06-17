From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: error: cannot lock ref 'refs/remotes/origin/*'
Date: Tue, 17 Jun 2008 12:09:07 -0700 (PDT)
Message-ID: <m3fxrbop4g.fsf@localhost.localdomain>
References: <1213635227.17814.6.camel@localhost>
	<alpine.DEB.1.00.0806171140470.6439@racer>
	<1213712520.6400.1.camel@localhost>
	<200806171629.06570.johan@herland.net>
	<1213717788.13390.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Bock <nbock@lanl.gov>
X-From: git-owner@vger.kernel.org Tue Jun 17 21:10:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8gZK-00061J-T6
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 21:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460AbYFQTJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 15:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756419AbYFQTJN
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 15:09:13 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:9105 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309AbYFQTJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 15:09:11 -0400
Received: by yx-out-2324.google.com with SMTP id 31so579273yxl.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=c+yNAfK4XmIkLYHqS/79D2fAv1yZPir+SLWRfkhFeWA=;
        b=Mxr+ONvijpO72ijV+K9FhugupRZyaWGqaAmwVRTqPxNZgdqVf3+BlNgHZMjO06gVPL
         sXkuMf5KRxoOS4U0QmM0GIQYnkEQijAY1qcSbWmUvHuSP8SgC+YB92UxqYfG4tjrqzl1
         mIpN1ZvPTm1Y214bJXbL++cEbx27HId002iTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=x5c9dsPeSvRiFT7Frg5XYL1Y6Te43ww7UAtup703zrWeRBh7axd5AOfiMyFBBBzhpl
         NkAjqK4Hs2sUeEg0dV0fOkagF1UPSNx5LhnSHSHoEF+dC43fxABVFQNDx/8FfwxHDKRC
         DzF9LE2p9V9Mb5zoYkmLyeE95V64LQ7xW9s10=
Received: by 10.151.99.17 with SMTP id b17mr13361030ybm.212.1213729748342;
        Tue, 17 Jun 2008 12:09:08 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.204.69])
        by mx.google.com with ESMTPS id p27sm3063555ele.6.2008.06.17.12.09.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 12:09:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5HJ95v9002890;
	Tue, 17 Jun 2008 21:09:06 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5HJ938k002887;
	Tue, 17 Jun 2008 21:09:03 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1213717788.13390.2.camel@localhost>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85317>

Nicolas Bock <nbock@lanl.gov> writes:

> I guess I don't understand refs. I figured that since I have
> 
> remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
> 
> set, I should have a ref refs/remotes/origin/* as well.

The above is _globbing_ refspec, it means that it maps 
"refs/heads/<name>" branch in remote repository to 
"refs/remotes/origin/<name>" remote-tracking branch in local
repository.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
