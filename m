From: Mark A Rada <markrada26@gmail.com>
Subject: Gitweb giving me some warnings in Apache's error_log
Date: Fri, 7 Aug 2009 09:00:12 -0400
Message-ID: <533D6DDF-4DAC-4A86-A6F7-95B54B77E48B@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 07 15:00:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZP3f-0000cb-Sm
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 15:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870AbZHGNAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 09:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757851AbZHGNAU
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 09:00:20 -0400
Received: from mail-yw0-f177.google.com ([209.85.211.177]:43501 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837AbZHGNAS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 09:00:18 -0400
Received: by ywh7 with SMTP id 7so2101516ywh.21
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=6BtZ4PcBLaB1pI+2zNIDy88PdKAMWIdkMrjq9nKE0yk=;
        b=f3UCZ8lZWisUC8te5Kx5YVGSVHUzWFoQtjdJebqucVFch4UVJxt7adwCCVUOZvpuio
         0G2oCYnygd2IdLJKKEee/EHyupB7xi4QmN6NS4ZOSCCfDrkS8TOYkuxgn45cbER8xDbQ
         rbB5XxgnWckkCaHU+V34dBtkZvPeFsaQy3bPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=SHdD6KLnU6s+ddXxfcZrDysaThHM3jz/oc3a+e9tWoSlApfbjJK/+QwtVgC/GfiQSJ
         WZkP8a1l/nEjE5jmnQVjmmNHY8dl6ZV1KNQbqnBiXg7/WS469jQn6Xsz0Lk4b6Mc5BE/
         8+7VI9k4G4FimZuTvTl2bawfmDRgt1M0kJQo4=
Received: by 10.100.201.7 with SMTP id y7mr247878anf.115.1249650017754;
        Fri, 07 Aug 2009 06:00:17 -0700 (PDT)
Received: from ?192.168.1.102? (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
        by mx.google.com with ESMTPS id d35sm945363and.15.2009.08.07.06.00.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 06:00:15 -0700 (PDT)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125194>

It doesn't seem to cause any other problems, but I don't know if it is  
significant or not.

[Fri Aug  7 08:51:13 2009] gitweb.cgi: Variable "$project_maxdepth"  
may be unavailable at /var/www/private/gitweb/cgi-bin/gitweb.cgi line  
2296.
[Fri Aug  7 08:51:13 2009] gitweb.cgi: Variable "$projectroot" may be  
unavailable at /var/www/private/gitweb/cgi-bin/gitweb.cgi line 2304.


Apache 2.2.12/ mod_perl 2.04/ perl 5.8.8


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca
