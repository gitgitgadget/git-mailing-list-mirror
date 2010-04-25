From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] gitweb: Miscellaneous improvements, in preparation for caching support
Date: Sun, 25 Apr 2010 13:45:57 +0200
Message-ID: <201004251346.01183.jnareb@gmail.com>
References: <20100424132255.30511.98829.stgit@localhost.localdomain> <20100425092035.GO3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Apr 25 13:52:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O60Ni-0000nu-Kd
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 13:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab0DYLwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 07:52:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:29151 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab0DYLwF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 07:52:05 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1901608fga.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 04:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9MTnC6THL9dZlfXtC7E/fgEohiTontVWpugnAHV+9+I=;
        b=D8AHWramfooGuqYD+HWFAubEncCIU3j6FLsNfuL6snhsKAbyChnewI3nHHT3CxRkY2
         6LkqJx3HuP7WKk+kjLEl8C9u9aBCI3YiCd63jhMRv/nPFJ/vOLgA7QEM+eKFKv8T63Vq
         vHoaa8LJkk5LJRhD+uUJKjszk3WLn5pftBt08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tlzfxOBiARw9G/kUL8xGjIB1segUy9YfCZrnWoPGpTEP9Hyd8e1H197FvfwwtpKAEb
         1VDMf9A1H9bTNGWi7P1l6Awk74VRsuBrm4PrGBUPA/MQ4venCnCJF/T9evEBsmqUPxFl
         Jg66twWnQ1+69RGSR8B9AMIzsG7JuhpRwBOsY=
Received: by 10.103.76.21 with SMTP id d21mr1406617mul.17.1272195971203;
        Sun, 25 Apr 2010 04:46:11 -0700 (PDT)
Received: from [192.168.1.13] (abvs189.neoplus.adsl.tpnet.pl [83.8.216.189])
        by mx.google.com with ESMTPS id e10sm12124690muf.38.2010.04.25.04.46.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 04:46:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100425092035.GO3563@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145737>

Petr Baudis wrote:
> On Sat, Apr 24, 2010 at 03:46:25PM +0200, Jakub Narebski wrote:
> > Jakub Narebski (5):
> >       gitweb: Move generating page title to separate subroutine
> >       gitweb: Add custom error handler using die_error
> >       gitweb: Use nonlocal jump instead of 'exit' in die_error
> >       gitweb: href(..., -path_info => 0|1)
> >       Export more test-related variables when running external tests
> > 
> >  gitweb/gitweb.perl |   69 ++++++++++++++++++++++++++++++++++++++--------------
> >  t/test-lib.sh      |    3 ++
> >  2 files changed, 53 insertions(+), 19 deletions(-)

> >  mode change 100644 => 100755 t/test-lib.sh

Ooops, the mode change was accidental.

> 
> Except the last one, I don't think the patches bring something useful
> in on their own so ordinarily they would probably have to be a part of
> some series that makes use of them, but there's no harm done either.

Actually "gitweb: Use nonlocal jump instead of 'exit' in die_error"
could in theory improve performance of gitweb on mod_perl, but I have
not benchmarked it...

-- 
Jakub Narebski
Poland
