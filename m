From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2] gitweb: Use list for of open for running git commands, thorougly.
Date: Sun, 30 Jul 2006 04:12:04 +0200
Message-ID: <200607300412.04545.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com> <200607292251.21072.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 04:12:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G70mW-0006nc-4S
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 04:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWG3CLt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 22:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWG3CLt
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 22:11:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:20701 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751061AbWG3CLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 22:11:49 -0400
Received: by ug-out-1314.google.com with SMTP id m3so255696ugc
        for <git@vger.kernel.org>; Sat, 29 Jul 2006 19:11:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YY8i0qK0+H69ivNmhtjizyZJoZAL4Uyn5riHbwq7piy/LYp3xbUuMdXwVW5rTgAdzfq2Cze0nqJHf6OuRlDY7kf1j9wjYM632nXkxfvlPNdYBAkpAfAqP+OmFuy5ofQF63TOF9Ol644+ZiHCPTzmCezAJSpdwwMRsnSPVPAfXb8=
Received: by 10.67.101.8 with SMTP id d8mr1124908ugm;
        Sat, 29 Jul 2006 19:11:47 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id k1sm3692218ugf.2006.07.29.19.11.47;
        Sat, 29 Jul 2006 19:11:47 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292251.21072.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24447>

This patch introduces error in git_commit, corrected in [PATCH 6].
-- 
Jakub Narebski
