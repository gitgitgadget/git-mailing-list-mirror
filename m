From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: how to change/fake the time for next commit ?
Date: Fri, 23 Nov 2007 01:45:01 +0100
Message-ID: <46d6db660711221645t652d767fjbe8c5dfc2f93483f@mail.gmail.com>
References: <46d6db660711221629j5d294a5dp4771778e38b14962@mail.gmail.com>
	 <Pine.LNX.4.64.0711230032320.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 23 01:45:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvMfa-0005Df-VF
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 01:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbXKWApF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 19:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXKWApE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 19:45:04 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:49562 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbXKWApD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 19:45:03 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3327392wah
        for <git@vger.kernel.org>; Thu, 22 Nov 2007 16:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kEzh1NpYlYv8zTZW5i6N+Sx5pn3A0Vagg6SpkHboOCk=;
        b=qSf+wN77xBTFDFZ2tUbxhbEecwDqDHem8UAc5oGi8KwadkOv9q0tWbu7zOGSvvcpwBl5g5wJWXpnc4x+kPcFTg6T3t2HjL5g6aDcrRSsFDUynvWESXsafF57CiRNR6EQ4X3Lp9nAvQetpoWl/WKPopEMINwDFMdB+fIOamKZo1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=doWx6wHVIwxUs8klxM4F61qYgC8JMgQiZS2pTA7sqXPT9ZEPixXgf2Bix+mgfs6X2RYEtl+tNmRry+O+d+ocXSGYO+AIe73Fi42Qhp3gXbY1MtjndNDpk+rDsGFu24rdI6r1qzSfMqiduOIK1UCPTmixrSuDMmsWvDyBWfK3ShY=
Received: by 10.114.190.6 with SMTP id n6mr123509waf.1195778701749;
        Thu, 22 Nov 2007 16:45:01 -0800 (PST)
Received: by 10.115.18.10 with HTTP; Thu, 22 Nov 2007 16:45:01 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711230032320.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65864>

On Nov 23, 2007 1:34 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Have you tried setting the environment variables GIT_COMMITTER_DATE and
> GIT_AUTHOR_DATE before committing?

cool! yes indeed it helped. ;-)

Thanks Dscho!

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
