From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFD: Shipping GitBrowser.js for instaweb
Date: Sun, 02 May 2010 13:14:27 -0700 (PDT)
Message-ID: <m3wrvmf4ei.fsf@localhost.localdomain>
References: <4BDDA780.7090500@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 02 22:14:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8fYj-0002Ev-5w
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 22:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab0EBUOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 16:14:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:37611 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758581Ab0EBUOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 16:14:31 -0400
Received: by fg-out-1718.google.com with SMTP id d23so806839fga.1
        for <git@vger.kernel.org>; Sun, 02 May 2010 13:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=XzCNudorQawSUeUjxTK7T0rtUXvk6RpDUEK1Ap9B1hc=;
        b=FAFiCvfde7c4LPtEXLVAmMoNqX3c8YSVXhw6H0bd7b9o2HczUG3qlUailoEqlBbzEM
         Mp8aZtgtLnVpj1QxA61/NS7LFbh5DavEY9KJv1xTnB+Yx1cFynS0qzL2LQB0WjjsZB58
         50myf6o6PRrChSWfQf4CLRDdCVFYtTWk8IVxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=QlEQGNSS3L1LAaCosERWHVRbrV02LtJs6XrLch0cq7gf+2fo1/lrr1sCzV3trMttUP
         YbP+e7RS2fhnHijH8kJ+q0O1mDaPH6XGOmn0fXP9SVT/GXELMN1tWBsKi2ZHGEOTqdCq
         ihNWN3LYto4Lvo0w0uSK4F2gwqEMI0XGMGWi4=
Received: by 10.87.68.36 with SMTP id v36mr8756930fgk.43.1272831267584;
        Sun, 02 May 2010 13:14:27 -0700 (PDT)
Received: from localhost.localdomain (abvt225.neoplus.adsl.tpnet.pl [83.8.217.225])
        by mx.google.com with ESMTPS id e20sm4021605fga.26.2010.05.02.13.14.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 13:14:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o42KDvhq014346;
	Sun, 2 May 2010 22:14:07 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o42KDfur014340;
	Sun, 2 May 2010 22:13:41 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4BDDA780.7090500@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146200>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I was wondering whether it would make sense to ship GitBrowser.js with
> Git and how much it would take to do so.
> 
> My personal answer to the 1st Q is Yes: instaweb as well as simple
> gitweb installs would benefit from a graphical DAG viewer.
> 
> About the required effort I have no clue: I find it difficult to see
> through which repo contains current gitweb, current repo.or.cz mods, and
> especially the GitBrowser integration bits. Maybe we could ship the
> integration bits without the actual GitBrowser if that is more feasible?

The integration parts are actually present in gitweb, I think.  It is
a matter of configuration to enable 'graphiclog' link like in
http://repo.or.cz

GitBrowser.js is not, I think, the best solution for having graphical
history in gitweb, but would do...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
