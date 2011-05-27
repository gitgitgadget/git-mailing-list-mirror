From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/3] gitweb: Improving blame_incremental.js
Date: Fri, 27 May 2011 16:04:38 +0200
Message-ID: <201105271604.41731.jnareb@gmail.com>
References: <1306504201-18014-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 16:05:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPxev-0006Ou-4R
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 16:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab1E0OE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 10:04:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61556 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab1E0OEz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 10:04:55 -0400
Received: by bwz15 with SMTP id 15so1315437bwz.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=KRkTbKqi/T4Y5mnbXywb3DIjkxgoyBvXlnQxBsc/cnU=;
        b=x1DtxUxjsUSYvtgX5/z0xJph5FTYcdoFvZipYETfy7OdvlyUEDATLsvVKBDiPPK/pj
         BZKsBSIF/o3XwOut3UEWcitk3N+qZ23OYcWPlOplVWLiZ+HLDAJmduYDsR5lALLvT1Bq
         xlOc7j/SYr1LW4j0qqTcDTB7OO7sB81HEvKjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=V8jHduQeQcd2NM95AomUC/TywjSGuZ/vN7dLJpXDntXTE9Gao2quk59aQnd2Ed7j+7
         XrsT/2tXcuiwVoHik31/b9x6TVF0s9c9ZXFU8YeJlDuewkbmUA6kgWxbclgi5dh3R3yD
         4u3g/CLnMzHHtzp9/GIG1W8ZjFB0IYHCzorQY=
Received: by 10.205.83.3 with SMTP id ae3mr1811346bkc.71.1306505094505;
        Fri, 27 May 2011 07:04:54 -0700 (PDT)
Received: from [192.168.1.13] (abvw13.neoplus.adsl.tpnet.pl [83.8.220.13])
        by mx.google.com with ESMTPS id k10sm1302269bkq.10.2011.05.27.07.04.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 May 2011 07:04:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1306504201-18014-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174623>

Jakub Narebski wrote:

> Two first patches remove unnecessary code from JavaScript-side of
> blame_incremental code. [...]
> 
> So those two are pure simplification.
> 
> 
> The third (last) patch replaces setInterval (where events might
> accumulate if browser is very busy) to recommended re-enabled
> setTimeout.  [...]
> 
> This one adds more code than it removes, and could be split into two
> patches: [...]

I forgot to add that this series is based on top of jn/gitweb-js
series, namely it theoretically require "gitweb: Split JavaScript for
maintability, combining on build"... but thanks to Git rename detection
it should [had] apply on top of master as well.

-- 
Jakub Narebski
Poland
