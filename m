From: Joel Saltzman <saltzmanjoelh@gmail.com>
Subject: self contained executable
Date: Wed, 16 Sep 2009 00:45:12 -0700
Message-ID: <ED42F58A-A814-467B-A37D-B485B2E267ED@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 09:45:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnpCj-0003Aq-7X
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 09:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbZIPHpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 03:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753688AbZIPHpP
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 03:45:15 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:33225 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbZIPHpO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 03:45:14 -0400
Received: by yxe1 with SMTP id 1so6337741yxe.21
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=sAmKIgYbjqN6MITVVgl9qucRU2m/RfW2pdprTsecmSQ=;
        b=G8b5BODnkm5dCBoMrolgo9jSWwpwLB03KL7a3of2L3+hx7Asd2Kjpym7i/8VnvGL0f
         EW86tH7Vch3JjWmh+SgltoMv3vle5GQCouoowCX6qik2NKxgcFPv+1kEdp+GH5sbkurJ
         9ATBzho3rfcha8SELyDIwcgJMqJPWz1mW2I3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=v8sTHb9WoS40sF9f9prmh45f6p35DsyzJjYVpSSOiEnnR4DtWr/zcgDLgT6sar+BlW
         j9sG5UadlxtSA8QursG79+PJlZlI6G5omexHQfOI2Dh/AERDUoq2is3Uo82eCUOHUVu1
         ZBGoeJKCjuofbuoBD/HxszqaJrhyrHkhvlZE4=
Received: by 10.90.58.29 with SMTP id g29mr5219556aga.44.1253087117689;
        Wed, 16 Sep 2009 00:45:17 -0700 (PDT)
Received: from ?10.0.253.229? (99-26-120-241.lightspeed.sndgca.sbcglobal.net [99.26.120.241])
        by mx.google.com with ESMTPS id 18sm1183668agb.72.2009.09.16.00.45.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 00:45:17 -0700 (PDT)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128611>

is it possible to compile git with all its dependencies so I can run  
it on a server that does not have root access?
