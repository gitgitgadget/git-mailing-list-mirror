From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 00/12] gitweb: remote_heads feature
Date: Sun, 26 Sep 2010 20:18:50 +0200
Message-ID: <201009262018.50565.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 20:19:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzvoY-0001P6-00
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 20:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504Ab0IZSTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 14:19:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50473 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757177Ab0IZSTA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 14:19:00 -0400
Received: by bwz11 with SMTP id 11so2876447bwz.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ccBigkzZ2VnPGLsojBuT1gaviz1BqndzLwF2vhYnQ24=;
        b=k5um8fixfBMHukpinJLpR+q3Xa6+X9p35XSz21vb+m/rxZJ/7nULLI6xHA7sj2aNs4
         brcQidcGjaomejy21rjoOvq1WuoYcgdHymvFQtYueVi0JlSAb1KZ3iacGJVmqfeoHop7
         2L4lHpZ8UpvIXplxC5Ip1GPeEMXafANk/XuMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WHGbHybydE1ZCvrPYKw8wYu1jUb0TAwIuga8vhf90uDEc6zW+OFQYHBFkkFjWu3all
         EoEzx6Z2ctEVz7u24bwORGaMiCzL0hbmeOVycK/xx6QbP8a45U9ezOY3cvJS9C+lv5eg
         F4hYxGlD9aVftuvX4cSEvAQKaPE3OKtF8Zle4=
Received: by 10.204.58.74 with SMTP id f10mr4318368bkh.161.1285525138836;
        Sun, 26 Sep 2010 11:18:58 -0700 (PDT)
Received: from [192.168.1.13] (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id 11sm3605797bkj.23.2010.09.26.11.18.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 11:18:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157249>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

> New version of the remote heads feature for gitweb (v5 because the
> previous rehash was actually v4, although I forgot to prefix the
> patchset accordingly).
> 
> I've included all the comments received from the previous review (unless
> I forgot about something), as well as the suggestions about how to
> select and present remotes in summary view.
> 
> The first 4 patches are rather straightforward and can probably go
> straight in. The 5th patch is a bugfix for something that is only
> triggered by the name manipulation done with the remote heads, but can
> probably useful even without the rest of the series.

Those patches can go as-is.  For what it is worth they all have ACK
from me.
 
I am working on review of other patches in this series.

-- 
Jakub Narebski
Poland
