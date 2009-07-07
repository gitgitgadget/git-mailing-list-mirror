From: Jakub Narebski <jnareb@gmail.com>
Subject: git-blame: Documenting "previous" header
Date: Tue, 7 Jul 2009 14:23:39 +0200
Message-ID: <200907071423.40938.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 14:24:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO9j0-00032y-8k
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 14:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465AbZGGMXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 08:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754814AbZGGMXm
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 08:23:42 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:45691 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbZGGMXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 08:23:41 -0400
Received: by fxm18 with SMTP id 18so4856189fxm.37
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=J0kJ6E+KE6y1/k2GU0ZwxdoOYsfAISsc8Vc9B6aWZ1E=;
        b=eDD33uskfQoYyBZ+zv5r7A0b+g+oJdIBc1rwSgmlMEUv7fDkmHdTaH/3bcaoKQlvHu
         9Nl7UhLu2Yx3Vt7GQl9akfsYVxyeulGhJHHsqRmJsYQWmaPoOEFTxglweQywdmOjaz6S
         ymGyi97mlJCD/zVT3tkBIgq1ii/777+iBJvBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=SVIkhvxtXQfRwCv/nLO+ECIsF0H/qildP1sSExH1vKC2qXbsJ5DTcWZ8AE8DAXRhcH
         CmlRQ1623fWcoRMFl2POf5xcbRFCou/E5nqOfW3kqGZGFuapipYJghpz6QrGtWU28KHI
         qT56nAf3kd4G3VmRqQ3p0yoaJF/xetRScw2ws=
Received: by 10.204.65.17 with SMTP id g17mr5736185bki.193.1246969423867;
        Tue, 07 Jul 2009 05:23:43 -0700 (PDT)
Received: from ?192.168.1.13? (abva123.neoplus.adsl.tpnet.pl [83.8.198.123])
        by mx.google.com with ESMTPS id 19sm13499024fkr.55.2009.07.07.05.23.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 05:23:43 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122837>

I have just noticed that talked about "previous" ("parent") header was 
added to --porcelain/--incremental output of git-blame in 96e1170 
(blame: show "previous" information in --porcelain/--incremental 
format).

It didn't get documented however.  My question is if <sha1> in
"previous <sha1> <filename>" is <sha1> of parent (taking grafts
and refs/replace into account), or is it <sha1> of _effective_
parent for given line?

-- 
Jakub Narebski
Poland
